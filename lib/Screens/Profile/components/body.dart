import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../../../Shared_Pref/Shard_Pref_Controller.dart';
import '../../../auth/login_screen.dart';
import '../../Profile/AddressScreen.dart';
import '../MyBookUser.dart';
import '../UpdateProfile.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    //TODO: here must add the object key of user to update it
    DatabaseReference dbRef = FirebaseDatabase.instance.ref();
    print(
        "test: ${dbRef.key}");
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(),
          SizedBox(height: 20),
          ProfileMenu(
            text: "تحديث بياناتي",
            icon: "images/User Icon.svg",
            press: () => {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) {
                return UpdateProfileScreen(studentKey: '${dbRef.key}');
              }))
            },
          ),
          ProfileMenu(
            text: "العنوان",
            icon: "images/Location point.svg",
            press: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) {
                return MyAdress();
              }));
            },
          ),
          ProfileMenu(
            text: "كتبي",
            icon: "images/book.svg",
            press: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) {
                return MyBookUser();
              }));
            },
          ),
          ProfileMenu(
            text: "تسجيل خروج",
            icon: "images/log out.svg",
            press: () {
              FirebaseAuth.instance.signOut().then((value) {
                SharedPrefController().removeUserID('user_id');
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return LoginScreen();
                }));
              });
            },
          ),
        ],
      ),
    );
  }
}
