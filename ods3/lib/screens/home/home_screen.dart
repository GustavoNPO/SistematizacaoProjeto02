import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class HomeScreen extends StatelessWidget {
  final String? userId = FirebaseAuth.instance.currentUser?.uid;
  final String displayName = FirebaseAuth.instance.currentUser?.isAnonymous == true
      ? "Usuário Anônimo"
      : (FirebaseAuth.instance.currentUser?.email ?? "Usuário");


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
              // O AuthCheckScreen vai lidar com a navegação para /login
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Olá, $displayName!',
                style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: 8),
            Text(
              'Seu ID de usuário (para teste): $userId',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            SizedBox(height: 24),
            Text(
              'Próximos lembretes e metas aparecerão aqui.',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            // para mostrar um resumo dos próximos remédios e o progresso das metas.
          ],
        ),
      ),
    );
  }
}


