
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../controller/auth_controller.dart';
import '../views/auth_screen.dart';
import '../views/home_screen.dart';

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Use GetX's reactive stream to listen for auth changes
      final authController = Get.put(AuthController());
      if (authController.user.value != null) {
        return HomeScreen(); // Show home screen
      } else {
        return AuthScreen(); // Show authentication screen
      }
    });
  }
}
