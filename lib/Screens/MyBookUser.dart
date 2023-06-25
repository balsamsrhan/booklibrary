import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class MyBook extends StatefulWidget {
  const MyBook({Key? key}) : super(key: key);
  // _stream = _reference.snapshots();

  @override
  _MyBookState createState() => _MyBookState();
}
class _MyBookState extends State<MyBook> {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  late String action;
  @override
  Future<void> initState() async {
    // TODO: implement initState
    super.initState();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    action = prefs.getString('user_id')!;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
  }