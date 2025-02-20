import 'package:chatapp_flutter/services/auth/auth_gate.dart';
import 'package:chatapp_flutter/firebase_options.dart';
//import 'package:chatapp_flutter/auth/login_or_register.dart';
//import 'package:chatapp_flutter/pages/login_page.dart';
//import 'package:chatapp_flutter/pages/register_page.dart';
//import 'package:chatapp_flutter/themes/light_mode.dart';
import 'package:chatapp_flutter/themes/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
   ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    child: const MyApp(),
    ),
    );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthGate(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}


