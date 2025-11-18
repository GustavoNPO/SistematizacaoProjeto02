import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

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
              Text('Bem-vindo ao CuidarTech',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall), // Atualizado de titleLarge
              SizedBox(height: 8),
              Text('Seu assistente de saúde pessoal',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium),
              SizedBox(height: 40),
              if (_isLoading)
                CircularProgressIndicator()
              else
                ElevatedButton.icon(
                  icon: Icon(Icons.person),
                  label: Text('Entrar Anônimo (Teste)'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    textStyle: TextStyle(fontSize: 16),
                  ),
                  onPressed: _signInAnonymously,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
