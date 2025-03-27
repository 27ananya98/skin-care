import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../controller/auth_controller.dart';

class StreakDisplay extends StatelessWidget {
  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection('users')
          .doc(authController.user!.value!.uid)  // Use the user from GetX
          .collection('streak')
          .doc('streak')
          .get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Text('No streak data available.');
        }

        final streakData = snapshot.data!.data() as Map<String, dynamic>;
        final currentStreak = streakData['currentStreak'] ?? 0;
        final longestStreak = streakData['longestStreak'] ?? 0;
        final lastCompleted = streakData['lastCompleted'] != null
            ? (streakData['lastCompleted'] as Timestamp).toDate()
            : DateTime.utc(1970);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Current Streak: $currentStreak days',
                style: const TextStyle(fontSize: 16)),
            Text('Longest Streak: $longestStreak days',
                style: const TextStyle(fontSize: 16)),
            Text(
              'Last Completed: ${DateFormat('yyyy-MM-dd').format(lastCompleted)}',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        );
      },
    );
  }
}