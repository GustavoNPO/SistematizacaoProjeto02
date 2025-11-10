import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthCheckScreen extends StatefulWidget {
  @override
  _AuthCheckScreenState createState() => _AuthCheckScreenState();
}


class _AuthCheckScreenState extends State<AuthCheckScreen> {
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (!mounted) return;


        if (user == null) {
          Navigator.pushReplacementNamed(context, '/login');
        } else {
          Navigator.pushReplacementNamed(context, '/app');
        }
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    // Tela de carregamento simples
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text('Verificando acesso...'),
          ],
        ),
      ),
    );
  }
}


