import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/User.dart';
import '../models/add_book_user.dart';

class FirebaseAuthHelper {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  //TODO : Sign In Anonymously
  Future<Map<String, dynamic>> SignInAnonymously() async {
    Map<String, dynamic> res = {};
    try {
      UserCredential? userCredential = await firebaseAuth.signInAnonymously();
      User? user = userCredential.user;
      res = {
        'user': user,
      };
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'operation-not-allowed':
          res = {'error': 'Server Temporary Closed...'};
          break;
      }
    }

    return res;
  }

  //TODO :Sign Up With Email Password
  Future<Map<String, dynamic>> createUserWithEmailPassword(
      {required String? email, required String? password}) async {
    Map<String, dynamic> res = {};
    try {
      UserCredential? userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email!, password: password!);
      User? user = userCredential.user;
      res = {
        'user': user,
      };
    } on FirebaseAuthException catch (e) {
      print("-----------------------");
      print(e.code);
      print("-----------------------");
      switch (e.code) {
        case 'invalid-email':
          res = {'error': 'Invalid Email....'};
          break;
        case 'weak-password':
          res = {'error': 'Your Password is Weak....'};
          break;
        case 'operation-not-allowed':
          res = {'error': 'Server is temporary off....'};
          break;
        case 'email-already-in-use':
          res = {'error': 'Please select another email....'};
          break;
      }
    }
    return res;
  }

  Future<bool> addData(Users users) async {
    return await _firebaseFirestore
        .collection("Users")
        .add(users.toMap())
        .then((value) => true)
        .onError((error, stackTrace){
      print(error);
      return false;
    });
  }
  //
  // Future<bool> addDataBookUser(Book book) async {
  //   return await _firebaseFirestore
  //       .collection("Book_Users")
  //       .add(book.toMap())
  //       .then((value) => true)
  //       .onError((error, stackTrace){
  //     print(error);
  //     return false;
  //   });
  // }

}