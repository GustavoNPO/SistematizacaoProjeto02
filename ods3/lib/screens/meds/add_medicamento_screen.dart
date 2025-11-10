import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddMedicamentoScreen extends StatefulWidget {
  @override
  _AddMedicamentoScreenState createState() => _AddMedicamentoScreenState();
}


class _AddMedicamentoScreenState extends State<AddMedicamentoScreen> {
  final _nomeController = TextEditingController();
  final _dosagemController = TextEditingController();


  bool _isLoading = false;


  Future<void> _salvarMedicamento() async {
    final String nome = _nomeController.text;
    final String dosagem = _dosagemController.text;
    final String? userId = FirebaseAuth.instance.currentUser?.uid;


    // Validação simples
    if (nome.isEmpty || dosagem.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, preencha todos os campos.')),
      );
      return;
    }


    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro: Não foi possível identificar o usuário.')),
      );
      return;
    }


    setState(() => _isLoading = true);


    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('medications')
          .add({
        'nome': nome,
        'dosagem': dosagem,
        'horario': '08:00',
        'criadoEm': FieldValue.serverTimestamp(),
      });


      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      print("Erro ao salvar: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao salvar no banco de dados.')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }


  @override
  void dispose() {
    _nomeController.dispose();
    _dosagemController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Novo Medicamento')),
      body: SingleChildScrollView( // Dica: Use SingleChildScrollView para evitar overflow
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: 'Nome do Remédio'),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: 24),
            TextField(
              controller: _dosagemController,
              decoration:
                  InputDecoration(labelText: 'Dosagem (ex: 1 comprimido)'),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: 40),
            if (_isLoading)
              CircularProgressIndicator()
            else
              ElevatedButton(
                onPressed: _salvarMedicamento,
                child: Text('Salvar'),
              ),
          ],
        ),
      ),
    );
  }
}


