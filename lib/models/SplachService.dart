import 'dart:async';

import 'package:booklibrary/Screens/bottom_navigation.dart';
import 'package:booklibrary/auth/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class splachservice{
  void islogn(BuildContext context){
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if(user != null){
      Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNavigationScreen()));

    }else{
      Timer(const Duration(seconds: 3),
              ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()))
      );
    }
  }
}