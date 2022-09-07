// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:aesthetic_app/authentication/auth_screen.dart';
import 'package:aesthetic_app/common/utils.dart';
import 'package:aesthetic_app/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseAuthMethods {
  final FirebaseAuth auth;
  FirebaseAuthMethods({
    required this.auth,
  });

  User get user => auth.currentUser!;

  Stream<User?> get authState => FirebaseAuth.instance.authStateChanges();

  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required BuildContext context,
    required String name,
  }) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user.updateDisplayName(name);
      ShowSnackBar(
          context: context, content: "account created, log in with your id");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      ShowSnackBar(context: context, content: e.message!);
    }
  }

  Future<String> loginWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      final loger = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // if (!user.emailVerified) {
      //   await sendEmailVerification(context);

      // }

      Navigator.pushNamed(context, HomeScreen.routeName);
      return "success";
    } on FirebaseAuthException catch (e) {
      ShowSnackBar(context: context, content: e.message! + "hi");
      return "fail";
      // Displaying the error message
    }
  }

  Future<void> sendEmailVerification(BuildContext context) async {
    try {
      auth.currentUser!.sendEmailVerification();
      ShowSnackBar(context: context, content: 'Email verification sent!');
    } on FirebaseAuthException catch (e) {
      ShowSnackBar(
          context: context, content: e.message!); // Display error message
    }
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await auth.signOut();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AuthScreen()),
      );
    } on FirebaseAuthException catch (e) {
      ShowSnackBar(context: context, content: e.message!);
    }
  }
}
