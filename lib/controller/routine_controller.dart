

import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RoutineController extends GetxController {
  // Rx variables for skincare steps and streak
  var routineSteps = {
    "Face Wash": false,
    "Toner": false,
    "Moisturizer": false,
    "Sunscreen": false,
    "Lip Balm": false
  }.obs;

  var streak = 0.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Function to log the routine to Firestore
  Future<void> logRoutine() async {
    final user = _auth.currentUser;
    if (user != null) {
      final userId = user.uid;
      final now = DateTime.now();

      // Save routine log in Firestore
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('skincareLogs')
          .doc(now.toIso8601String()) // Store log with timestamp
          .set({
        'date': now,
        'routine': routineSteps,
      });

      // Update streak
      await updateStreak(userId);
    }
  }

  // Update streak based on the last 7 routine logs
  Future<void> updateStreak(String userId) async {
    final logs = await _firestore
        .collection('users')
        .doc(userId)
        .collection('skincareLogs')
        .orderBy('date', descending: true)
        .limit(7) // Check last 7 days for streak calculation
        .get();

    int calculatedStreak = 0;
    DateTime? previousDate;

    for (var doc in logs.docs) {
      DateTime logDate = doc['date'].toDate();
      if (previousDate == null || logDate.difference(previousDate).inDays == 1) {
        calculatedStreak++;
      } else {
        break;
      }
      previousDate = logDate;
    }

    streak.value = calculatedStreak;

    // Update streak in Firestore
    await _firestore.collection('users').doc(userId).update({
      'streak': streak.value,
    });
  }

  // Fetch streak from Firestore
  Future<void> fetchStreak() async {
    final user = _auth.currentUser;
    if (user != null) {
      final userId = user.uid;
      final doc = await _firestore.collection('users').doc(userId).get();
      if (doc.exists && doc.data() != null) {
        streak.value = doc['streak'] ?? 0;
      }
    }
  }
}
