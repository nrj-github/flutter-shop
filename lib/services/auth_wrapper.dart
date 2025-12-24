import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../screens/main_nav_screen.dart'; // UPDATED: Import the Navigation Screen
import '../screens/login_screen.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      // REQUIREMENT: Maintain session during usage (Checks local storage for token)
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {

        // 1. While Firebase is checking the device for a saved session
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        // 2. Persistent Login: If session exists, go to the Main Navigation (Borobazar style)
        if (snapshot.hasData) {
          return const MainNavScreen();
        }

        // 3. Otherwise, show the Login Screen
        return const LoginScreen();
      },
    );
  }
}
