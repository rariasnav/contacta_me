import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart'; 

void main() {
  runApp(const ContactaApp());
}

class ContactaApp extends StatelessWidget {
  const ContactaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ContactaMe',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}

