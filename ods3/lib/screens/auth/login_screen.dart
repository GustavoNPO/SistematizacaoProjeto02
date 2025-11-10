import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}


class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;


  Future<void> _signInAnonymously() async {
    setState(() => _isLoading = true);
    try {
      await FirebaseAuth.instance.signInAnonymously();
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/app');
      }
    } catch (e) {
      print("Erro no login anônimo: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao tentar login: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Entrar no CuidarTech')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Tela de Login', style: Theme.of(context).textTheme.titleLarge),
              SizedBox(height: 40),


              if (_isLoading)
                CircularProgressIndicator()
              else
                ElevatedButton(
                  onPressed: _signInAnonymously,
                  child: Text('Entrar Anônimo (Teste)'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
