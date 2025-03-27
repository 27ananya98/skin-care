import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../controller/auth_controller.dart';
import '../routes/app_pages.dart';

class LogRoutineScreen extends StatefulWidget {
  @override
  _LogRoutineScreenState createState() => _LogRoutineScreenState();
}

class _LogRoutineScreenState extends State<LogRoutineScreen> {
  bool _faceWash = false;
  bool _toner = false;
  bool _moisturizer = false;
  bool _sunscreen = false;
  bool _lipBalm = false;
  final _notesController = TextEditingController();
  final AuthController authController = Get.find();

  Future<void> _saveLog() async {
    try {

      DateTime now = DateTime.now();

      Timestamp firestoreTimestamp = Timestamp.fromDate(now);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(authController.user.value?.uid)
          .collection('logs')
          .add({
        'date': firestoreTimestamp,
        'faceWash': _faceWash,
        'toner': _toner,
        'moisturizer': _moisturizer,
        'sunscreen': _sunscreen,
        'lipBalm': _lipBalm,
        'notes': _notesController.text.trim(),
      });


      Get.snackbar(
        'Success',
        'Routine logged successfully!',
        duration: const Duration(seconds: 2),
      );


      Get.offNamed(Routes.HOME);
    } catch (e) {

      Get.snackbar(
        'Error',
        'Error logging routine: $e',
        duration: const Duration(seconds: 5),
      );
    }
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log Your Routine'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          // Make it scrollable
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              CheckboxListTile(
                title: const Text('Face Wash'),
                value: _faceWash,
                onChanged: (value) {
                  if (value != null) {
                    // null check
                    setState(() {
                      _faceWash = value;
                    });
                  }
                },
              ),
              CheckboxListTile(
                title: const Text('Toner'),
                value: _toner,
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _toner = value;
                    });
                  }
                },
              ),
              CheckboxListTile(
                title: const Text('Moisturizer'),
                value: _moisturizer,
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _moisturizer = value;
                    });
                  }
                },
              ),
              CheckboxListTile(
                title: const Text('Sunscreen'),
                value: _sunscreen,
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _sunscreen = value;
                    });
                  }
                },
              ),
              CheckboxListTile(
                title: const Text('Lip Balm'),
                value: _lipBalm,
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _lipBalm = value;
                    });
                  }
                },
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _notesController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Notes (Optional)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveLog,
                child: const Text('Save Log'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



