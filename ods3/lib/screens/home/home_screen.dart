import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatelessWidget {
  final String? userId = FirebaseAuth.instance.currentUser?.uid;
  final String displayName =
      FirebaseAuth.instance.currentUser?.isAnonymous == true
          ? "Usuário Anônimo"
          : (FirebaseAuth.instance.currentUser?.email ?? "Usuário");

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Painel CuidarTech'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            tooltip: "Sair",
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Olá, $displayName!',
                  style: Theme.of(context).textTheme.titleLarge),
              SizedBox(height: 24),
              Text(
                'Próximos lembretes:',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 8),
              StreamBuilder(
                stream: FirebaseAuth.instance.currentUser == null
                    ? null
                    : FirebaseFirestore.instance
                        .collection('users')
                        .doc(userId)
                        .collection('medications')
                        .orderBy('horario')
                        .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  final docs = snapshot.data!.docs;
                  if (docs.isEmpty) {
                    return Text('Nenhum lembrete agendado.');
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: docs.length,
                    itemBuilder: (context, idx) {
                      final med = docs[idx].data() as Map<String, dynamic>;
                      final horario = DateTime.tryParse(med['horario'] ?? '') ??
                          DateTime.now();
                      return Card(
                        elevation: 2,
                        margin: EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          leading: Icon(Icons.medication),
                          title: Text(med['nome'] ?? ''),
                          subtitle: Text(
                              'Dosagem: ${med['dosagem'] ?? ''}\nHorário: ${horario.day}/${horario.month} ${horario.hour.toString().padLeft(2, '0')}:${horario.minute.toString().padLeft(2, '0')}'),
                        ),
                      );
                    },
                  );
                },
              ),
              SizedBox(height: 24),
              Text(
                'Suas Metas:',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 8),
              StreamBuilder(
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
                    return Text('Nenhuma meta definida.');
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: docs.length,
                    itemBuilder: (context, idx) {
                      final goal = docs[idx].data() as Map<String, dynamic>;
                      final prazo = DateTime.tryParse(goal['prazo'] ?? '') ??
                          DateTime.now();
                      return Card(
                        elevation: 2,
                        margin: EdgeInsets.symmetric(vertical: 8),
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
            ],
          ),
        ),
      ),
    );
  }
}
