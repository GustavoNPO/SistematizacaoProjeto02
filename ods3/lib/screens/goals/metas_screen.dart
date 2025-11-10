import 'package:flutter/material.dart';




class MetasScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Metas Semanais')),
      body: Center(
        child: Text(
          'Lista de metas de saúde (ex: Beber Água, Caminhar).',
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add),
        label: Text('Adicionar'),
        onPressed: () {
        },
      ),
    );
  }
}
