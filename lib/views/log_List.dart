import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../controller/auth_controller.dart';

class LogList extends StatelessWidget {
  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(authController.user.value?.uid)
          .collection('logs')
          .orderBy('date', descending: true)
          .limit(5)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
          return const Text('No logs available.');
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            final log = snapshot.data!.docs[index];
            final logData = log.data() as Map<String, dynamic>;
            final logDate = (logData['date'] as Timestamp).toDate();

            return Card(
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Date: ${DateFormat('yyyy-MM-dd – kk:mm').format(logDate)}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text('Face Wash: ${logData['faceWash'] ? 'Yes' : 'No'}'),
                    Text('Toner: ${logData['toner'] ? 'Yes' : 'No'}'),
                    Text('Moisturizer: ${logData['moisturizer'] ? 'Yes' : 'No'}'),
                    Text('Sunscreen: ${logData['sunscreen'] ? 'Yes' : 'No'}'),
                    Text('Lip Balm: ${logData['lipBalm'] ? 'Yes' : 'No'}'),
                    Text('Notes: ${logData['notes'] ?? 'None'}'),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
