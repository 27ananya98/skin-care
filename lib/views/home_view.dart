import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controller/home_controller.dart';

class LoginPage extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: authController.emailController,
              decoration: InputDecoration(labelText: "Email"),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: authController.passwordController,
              decoration: InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: authController.signInWithEmail,child: const Text("Sign in with Email"),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              icon: Image.asset(
                'assets/image/google_logo.png',
                height: 24,
              ),
              label: const Text("Sign in with Google"),
              onPressed: () async {
                UserCredential? user = await authController.signInWithGoogle();
                if (user != null) {
                  print("Logged in: ${user.user?.displayName}");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
