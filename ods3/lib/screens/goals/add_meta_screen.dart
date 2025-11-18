import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../services/notification_service.dart';

class AddMetaScreen extends StatefulWidget {
  const AddMetaScreen({super.key});

  @override
  _AddMetaScreenState createState() => _AddMetaScreenState();
}

class _AddMetaScreenState extends State<AddMetaScreen> {
  final _nomeController = TextEditingController();
  final _descricaoController = TextEditingController();
  DateTime? _selectedDeadline;

  bool _isLoading = false;

  Future<void> _salvarMeta() async {
    final String nome = _nomeController.text;
    final String descricao = _descricaoController.text;
    final String? userId = FirebaseAuth.instance.currentUser?.uid;
    final DateTime? deadline = _selectedDeadline;

    if (nome.isEmpty || descricao.isEmpty || deadline == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Preencha todos os campos e selecione o prazo.')),
      );
      return;
    }

    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro: Usuário não identificado.')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('goals')
          .add({
        'nome': nome,
        'descricao': descricao,
        'prazo': deadline.toIso8601String(),
        'criadoEm': FieldValue.serverTimestamp(),
      });

      try {
        await NotificationService().scheduleNotification(
          id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
          title: 'Meta: $nome',
          body: 'Prazo chegando! Descrição: $descricao',
          scheduledDateTime: deadline,
        );
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erro ao agendar notificação: $e')),
          );
        }
      }

      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
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
    _descricaoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Nova Meta')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(
                labelText: 'Nome da Meta',
                icon: Icon(Icons.flag_outlined),
              ),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: 24),
            TextField(
              controller: _descricaoController,
              decoration: InputDecoration(
                labelText: 'Descrição',
                icon: Icon(Icons.description_outlined),
              ),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: 24),
            ElevatedButton.icon(
              icon: Icon(Icons.calendar_today),
              label: Text(_selectedDeadline == null
                  ? 'Selecione o prazo'
                  : 'Prazo: '
                      '${_selectedDeadline!.day}/${_selectedDeadline!.month}/${_selectedDeadline!.year} '
                      '${_selectedDeadline!.hour.toString().padLeft(2, '0')}:${_selectedDeadline!.minute.toString().padLeft(2, '0')}'),
              onPressed: () async {
                final localContext = context;
                final date = await showDatePicker(
                  context: localContext,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(Duration(days: 365)),
                );
                if (date == null) return;

                if (!mounted) return;
                final time = await showTimePicker(
                  context: localContext,
                  initialTime: TimeOfDay.now(),
                );
                if (time == null) return;

                if (!mounted) return;
                setState(() {
                  _selectedDeadline = DateTime(
                    date.year,
                    date.month,
                    date.day,
                    time.hour,
                    time.minute,
                  );
                });
              },
            ),
            SizedBox(height: 40),
            if (_isLoading)
              CircularProgressIndicator()
            else
              ElevatedButton(
                onPressed: _salvarMeta,
                child: Text('Salvar'),
              ),
          ],
        ),
      ),
    );
  }
}