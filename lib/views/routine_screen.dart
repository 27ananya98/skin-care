import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/routine_controller.dart';

class RoutineLogScreen extends StatelessWidget {
  final RoutineController _controller = Get.put(RoutineController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Skincare Routine Log"),
          backgroundColor: Colors.pinkAccent,
        ),
        body: Padding(
        padding: const EdgeInsets.all(16.0),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    // Routine steps title
    Text(
    'Complete your daily routine:',
    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ),
    SizedBox(height: 16),

    // Skincare routine steps (checkboxes)
    Obx(() {
    return Column(
    children: _controller.routineSteps.keys.map((step) {
    return ListTile(
    contentPadding: EdgeInsets.zero,
    title: Text(
    step,
    style: TextStyle(fontSize: 18, color: Colors.black),
    ),
    trailing: Checkbox(
    value: _controller.routineSteps[step],
    onChanged: (value) {
    _controller.routineSteps[step] = value!;
    },
    activeColor: Colors.pinkAccent,
    ),
    );
    }).toList(),
    );
    }),

    SizedBox(height: 24),

    // Streak Display
    Obx(() {
    return Center(
    child: Text(
    'Your Current Streak: ${_controller.streak.value} days',
    style: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.pinkAccent,
    ),
    )
    );
  }),

  // Save button
  Spacer(),
  Align(
  alignment: Alignment.center,
  child: ElevatedButton(
  onPressed: () async {
  await _controller.logRoutine();
  Get.snackbar(
  "Success",
  "Your routine has been logged successfully.",
  snackPosition: SnackPosition.BOTTOM,
  );
  },
  style: ElevatedButton.styleFrom(
  backgroundColor: Colors.pinkAccent,
  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
  shape: RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(12),
  ),
  ),
  child: Text(
  "Save Routine",
  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  ),
  ),
  ),
  ],
  ),
  ),
  );
}
}
