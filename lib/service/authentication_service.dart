import 'package:creatro_app/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  // get all current user data from firestore
  Future<CreatroUser> getCurrentUserData() async {
    User user = _firebaseAuth.currentUser!;
    DocumentSnapshot snapshot =
        await _firebaseFirestore.collection('users').doc(user.uid).get();
    return CreatroUser.fromSnapshot(snapshot);
  }

  //Register guest user
  // Future regGuest() async {
  //   String username = "Guest";
  //   String email = "guest@mydrills.com";
  //   try {
  //     UserCredential credential = await _firebaseAuth.signInAnonymously();

  //     // GuestUser object
  //     GuestUser user = GuestUser(
  //       username: username,
  //       uid: credential.user!.uid,
  //       email: email,
  //       followers: [],
  //       following: [],
  //       photourl: "",
  //     );

  //     // link user to datbase(firestore)
  //     await _firebaseFirestore
  //         .collection('users')
  //         .doc(credential.user!.uid)
  //         .set(user.toJson());
  //   } catch (e) {
  //     print(e.toString());
  //     return;
  //   }
  // }

  //Register user
  Future<String> regUser({
    required String email,
    required String password,
  }) async {
    String result = "error";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        UserCredential userCredential = await _firebaseAuth
            .createUserWithEmailAndPassword(email: email, password: password);

        // User object
        CreatroUser user = CreatroUser(
          uid: userCredential.user!.uid,
          email: email,
          photourl: "",
        );

        // link user to datbase(firestore)
        await _firebaseFirestore
            .collection('users')
            .doc(userCredential.user!.uid)
            .set(user.toJson());
        result = "success";
      } else {
        result = "A field is empty or not correct";
      }
    } catch (e) {
      result = e.toString();
    }
    return result;
  }

  //Login user to firebase_auth
  Future<String> logUser({
    required String email,
    required String password,
  }) async {
    String result = "error";

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        result = "success";
      } else {
        result = "A field is empty or not correct";
      }
    } catch (e) {
      result = e.toString();
    }
    return result;
  }

  //sign out
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
