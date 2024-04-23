import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // Make sure this path is correct
import 'screens/home_screen.dart'; // Make sure this path is correct
import 'package:firebase_auth/firebase_auth.dart';
import 'screens/splash_screen.dart'; // Make sure this path is correct

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BuiltBuddy',
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.data == null) {
              return SplashScreen();
            }
            return const HomeScreen();
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
