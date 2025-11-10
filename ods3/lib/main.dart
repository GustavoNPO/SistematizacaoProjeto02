import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ods3/screens/noti_service.dart';


import 'firebase_options.dart';


import 'themes/app_theme.dart';
import 'screens/auth/auth_check_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/shell/main_app_screen.dart';
import 'screens/meds/add_medicamento_screen.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Notifications init
  NotiService().initNotification();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );




  runApp(CuidarTechApp());
}


class CuidarTechApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CuidarTech',
      theme: appTheme,
      debugShowCheckedModeBanner: false,


      initialRoute: '/authcheck',
      routes: {
        '/authcheck': (context) => AuthCheckScreen(),
        '/login': (context) => LoginScreen(),
        '/app': (context) => MainAppScreen(),
        '/addMedicamento': (context) => AddMedicamentoScreen(),
        // '/addMeta': (context) => AddMetaScreen(),
      },
    );
  }
}




