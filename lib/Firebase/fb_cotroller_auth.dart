import 'package:firebase_auth/firebase_auth.dart';

import '../models/Helpers.dart';

class FBAuthController with Helpers{
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<bool> newAccount({email, password}) async {
    return await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value){
      value.user!.sendEmailVerification();
      return true;
    }).onError((error, stackTrace) {
      print(error);
      return false;
    });
  }

  Future<bool> login({id,context ,email, password}) async {
    return await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value){
      UserCredential user = value;
      if(user.user!.emailVerified){
        return true;
      }
      return false;
    }).onError((error, stackTrace) {
      showSnackBar(context, message: error.toString());
      return false;
    });
  }

  Future<bool> forgetPassword({email,context}) async {
    return await _firebaseAuth.sendPasswordResetEmail(email: email).then((value) {
      showSnackBar(context, message: "انظر الي ايميلك ! لقد ارسلنا لك رسالة ");
      return true;
    }).onError((error, stackTrace){
      showSnackBar(context, message: error.toString());
      return false;
    });

  }
}
