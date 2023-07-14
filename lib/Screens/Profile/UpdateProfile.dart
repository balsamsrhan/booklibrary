import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../Shared_Pref/Shard_Pref_Controller.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key,   required this.studentKey,}) : super(key: key);
  final  String studentKey;
  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {

  final  userNameController = TextEditingController();
  final  userAgeController= TextEditingController();
  final  userSalaryController =TextEditingController();
  late DatabaseReference dbRef;

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('Users');
    Contactt_data();
  }

  // void getStudentData() async {
  //   DataSnapshot snapshot = await dbRef.child(widget.studentKey).get();
  //
  //   Map student = snapshot.value as Map;
  //
  //   userNameController.text = student['name'];
  //   userAgeController.text = student['email'];
  //   userSalaryController.text = student['password'];
  //
  // }

  void Contactt_data() async {
    DataSnapshot snapshot = await dbRef.child(widget.studentKey).get();

    Map Contact = snapshot.value as Map;

    setState(() {
      userNameController.text = Contact['name'];
      userAgeController.text = Contact['email'];
      userSalaryController.text = Contact['password'];
    });
  }

  @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Updating record'),
        ),
        body:  Center(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  'Updating data in Firebase Realtime Database',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: userNameController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                    hintText: 'Enter Your Name',
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: userAgeController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'email',
                    hintText: 'Enter Your Age',
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: userSalaryController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'password',
                    hintText: 'Enter Your Salary',
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                MaterialButton(
                  onPressed: () {

                    Map<String, String> students = {
                      'id' : SharedPrefController().getUserID()!,
                      'name': userNameController.text,
                      'email': userAgeController.text,
                      'password': userSalaryController.text
                    };

                    dbRef.child(widget.studentKey).update(students)
                        .then((value) => {
                      // Navigator.pop(context)
                    });

                  },
                  child: const Text('Update Data'),
                  color: Colors.blue,
                  textColor: Colors.white,
                  minWidth: 300,
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      );
    }
  }