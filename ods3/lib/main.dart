import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'services/notification_service.dart';

import 'firebase_options.dart';
import 'themes/app_theme.dart';
import 'screens/auth/auth_check_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/shell/main_app_screen.dart';
import 'screens/meds/add_medicamento_screen.dart';
import 'screens/goals/add_meta_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final notificationService = NotificationService();
  await notificationService.initialize();
  notificationService.setNavigatorKey(navigatorKey);

  runApp(const CuidarTechApp());
}

class CuidarTechApp extends StatelessWidget {
  const CuidarTechApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'CuidarTech',
      theme: appTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: '/authcheck',
      routes: {
        '/authcheck': (context) => AuthCheckScreen(),
        '/login': (context) => LoginScreen(),
        '/app': (context) => MainAppScreen(),
        '/addMedicamento': (context) => AddMedicamentoScreen(),
        '/addMeta': (context) => AddMetaScreen(),
      },
    );
  }
}
