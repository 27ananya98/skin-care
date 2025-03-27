

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:skin_care/views/streak_display.dart';

import '../controller/auth_controller.dart';
import '../routes/app_pages.dart';
import 'log_List.dart';


class HomeScreen extends StatelessWidget {
  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Skincare Routine'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await authController.logout();
              Get.offNamed('/');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Obx(()=>
                Text(
                  'Welcome, ${authController.user?.value?.email ?? 'User'}!',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
            ),
            const SizedBox(height: 20),
            StreakDisplay(), // Display streak
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {

                Get.toNamed(Routes.ROUTINE);
              },
              child: const Text('Log Your Routine'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Your Recent Logs:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: LogList(),
            ),
          ],
        ),
      ),
    );
  }
}
