import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirService extends ChangeNotifier {
  FirebaseAuth fireAuth = FirebaseAuth.instance;
  FirebaseFirestore fstorage = FirebaseFirestore.instance;

  Future<UserCredential> registeruser(
      String email, String pass, String name) async {
    try {
      UserCredential userCredential = await fireAuth
          .createUserWithEmailAndPassword(email: email, password: pass);

      try {
        await fstorage.collection("users").doc(userCredential.user!.uid).set({
          "uid": userCredential.user!.uid,
          "email": userCredential.user!.email,
          "name": name,
        }, SetOptions(merge: true));
      } on Exception catch (e) {
        print("addusererror $e");
      }
      return userCredential;
    } on Exception catch (e) {
      print(e);
      rethrow;
    }
  }

  void loginusers(String email, String pass) async {
    try {
      await fireAuth.signInWithEmailAndPassword(email: email, password: pass);
    } on Exception catch (e) {
      print(e);
    }
  }
}
