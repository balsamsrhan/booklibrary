import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../profile/profile_screen.dart';


class ResetScreen extends StatefulWidget {
  @override
  _ResetScreenState createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  late String _email;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 40,
            width: 40,
            child: IconButton(
              // Your drawer Icon
              onPressed: () {
                Navigator.pop(context);
              },
              icon: ImageIcon(
                AssetImage("images/appbar_back.png"),
                color: Colors.black,
              ),
            ),
          ),
          // Your widgets here
        ],
      ),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  hintText: 'البريد الالكتروني'
              ),
              onChanged: (value) {
                setState(() {
                  _email = value.trim();
                });
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
             TextButton(
                child: Text('ارسال طلب'),
                onPressed: () {
                  auth.sendPasswordResetEmail(email: _email);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProfileScreen(),
                    ),
                  );
                },

              ),

            ],
          ),

        ],),
    );
  }
}