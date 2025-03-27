import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Rxn<User> user = Rxn<User>();  // Reactive user object

  @override
  void onReady() {
    super.onReady();
    user.bindStream(_auth.authStateChanges()); // Listen to auth state changes
  }

  // Add methods for login and register.
  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      // Handle errors
      String errorMessage = "An error occurred.";
      if (e.code == 'user-not-found') {
        errorMessage = "No user found for that email.";
      } else if (e.code == 'wrong-password') {
        errorMessage = "Wrong password.";
      }
      Get.snackbar('Login Error', errorMessage); // Use GetX snackbar
      throw e; // rethrow
    }
  }

  Future<void> register(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      //Also create the user's initial streak document
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        await FirebaseFirestore.instance.collection('users').doc(currentUser.uid).collection('streak').doc('streak').set({
          'currentStreak': 0,
          'longestStreak': 0,
          'lastCompleted': Timestamp.fromDate(DateTime.utc(1970, 1, 1)),
        });
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = "An error occurred.";
      if (e.code == 'email-already-in-use') {
        errorMessage = "The email address is already in use.";
      } else if (e.code == 'invalid-email'){
        errorMessage = "The email address is badly formatted.";
      }
      Get.snackbar('Registration Error', errorMessage);
      throw e;
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}