import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MetasScreen extends StatelessWidget {
  const MetasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String? userId = FirebaseAuth.instance.currentUser?.uid;

    return Scaffold(
      appBar: AppBar(title: Text('Metas Semanais')),
      body: StreamBuilder(
        stream: FirebaseAuth.instance.currentUser == null
            ? null
            : FirebaseFirestore.instance
                .collection('users')
                .doc(userId)
                .collection('goals')
                .orderBy('prazo')
                .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final docs = snapshot.data!.docs;
          if (docs.isEmpty) {
            return Center(
              child: Text(
                'Nenhuma meta definida.',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            );
          }
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, idx) {
              final goal = docs[idx].data() as Map<String, dynamic>;
              final prazo = DateTime.tryParse(goal['prazo'] ?? '') ??
                  DateTime.now();
              return Card(
                elevation: 2,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  leading: Icon(Icons.flag),
                  title: Text(goal['nome'] ?? ''),
                  subtitle: Text(
                      'Descrição: ${goal['descricao'] ?? ''}\nPrazo: ${prazo.day}/${prazo.month} ${prazo.hour.toString().padLeft(2, '0')}:${prazo.minute.toString().padLeft(2, '0')}'),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add),
        label: Text('Adicionar'),
        onPressed: () {
          Navigator.pushNamed(context, '/addMeta');
        },
      ),
    );
  }
}
