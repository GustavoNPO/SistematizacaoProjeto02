import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthCheckScreen extends StatefulWidget {
  const AuthCheckScreen({super.key});

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
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlutterLogo(size: 100),
            SizedBox(height: 40),
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text('Aguarde, estamos preparando tudo para você...'),
          ],
        ),
      ),
    );
  }
}
