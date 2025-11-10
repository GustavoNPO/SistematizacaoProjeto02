import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';


class TeleorientacaoScreen extends StatelessWidget {
  // (usar o pacote url_launcher)
  Future<void> _makePhoneCall(String phoneNumber) async {
    /*
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      print('Não foi possível ligar para $phoneNumber');
    }
    */
    print('Simulando ligação para $phoneNumber');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ajuda e Contatos')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Precisa de ajuda? Ligar para:',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32),


            // (ex: /users/{userId}/profile)


            ElevatedButton.icon(
              icon: Icon(Icons.family_restroom, size: 32),
              label: Text('Familiar (Ex: Filho)'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
              ),
              onPressed: () {
                _makePhoneCall('+5561999998888'); // Número de exemplo
              },
            ),
            SizedBox(height: 24),
            ElevatedButton.icon(
              icon: Icon(Icons.local_hospital, size: 32),
              label: Text('Médico(a)'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
              ),
              onPressed: () {
                _makePhoneCall('+5561999997777'); // Número de exemplo
              },
            ),
            SizedBox(height: 24),
            ElevatedButton.icon(
              icon: Icon(Icons.emergency, size: 32),
              label: Text('Emergência (SAMU)'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange.shade800,
              ),
              onPressed: () {
                _makePhoneCall('192'); // Número real
              },
            ),
          ],
        ),
      ),
    );
  }
}


