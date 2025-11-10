import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class MedicamentosScreen extends StatelessWidget {
  final String? userId = FirebaseAuth.instance.currentUser?.uid;


  @override
  Widget build(BuildContext context) {
    if (userId == null) {
      return Scaffold(
        appBar: AppBar(title: Text('Meus Medicamentos')),
        body: Center(child: Text('Erro: Usuário não identificado.')),
      );
    }


    final CollectionReference medicamentosCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('medications');


    return Scaffold(
      appBar: AppBar(title: Text('Meus Medicamentos')),


      body: StreamBuilder<QuerySnapshot>(
        stream: medicamentosCollection.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar medicamentos.'));
          }


          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }


          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                'Nenhum medicamento cadastrado.\nClique em "+" para adicionar.',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            );
          }


          return ListView(
            padding: EdgeInsets.all(8.0),
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;


              return Card(
                elevation: 3.0,
                margin: EdgeInsets.symmetric(vertical: 6.0),
                child: ListTile(
                  title: Text(data['nome'] ?? 'Nome não informado',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  subtitle: Text(data['dosagem'] ?? 'Dosagem não informada',
                      style: TextStyle(fontSize: 16)),
                  trailing: Icon(Icons.medical_services, color: Colors.green),
                ),
              );
            }).toList(),
          );
        },
      ),


      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add),
        label: Text('Adicionar'),
        onPressed: () {
          Navigator.pushNamed(context, '/addMedicamento');
        },
      ),
    );
  }
}


