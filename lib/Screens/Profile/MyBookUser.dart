import 'package:booklibrary/Screens/SecondeHandBooks/UpdateSecondHandBook.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Shared_Pref/Shard_Pref_Controller.dart';
import '../../models/Seconde_HandBooks.dart';
import '../SecondeHandBooks/AddSecondHandeBooks.dart';

class MyBookUser extends StatefulWidget {
  const MyBookUser({Key? key}) : super(key: key);
  // _stream = _reference.snapshots();

  @override
  _MyBookUserState createState() => _MyBookUserState();
}

class _MyBookUserState extends State<MyBookUser> {
  late Book b;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  late String uuid;
  @override
  void initState() {
    super.initState();
    uuid = SharedPrefController().getUserID()!;
  }

  // Future<void> getPrefs() async {
  //   prefs  = await SharedPreferences.getInstance();
  //   uuid = prefs.getString('user_id')!;
  //   print("uuid: $uuid");
  // }
  // CollectionReference _reference =
  // FirebaseFirestore.instance.collection('book_user');

  //_reference.get()  ---> returns Future<QuerySnapshot>
  //_reference.snapshots()--> Stream<QuerySnapshot> -- realtime updates
  late Stream<QuerySnapshot> _stream;

  @override
  Widget build(BuildContext context) {
    DatabaseReference db_Ref =
    FirebaseDatabase.instance.ref().child('Second_HandBook');
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            IconButton(
                icon: Icon(Icons.arrow_forward_ios_outlined),
                onPressed: () {
                  Navigator.pop(context);
                }),
            Expanded(
              child:
            Container(
              child: FirebaseAnimatedList(
                query: db_Ref,
                shrinkWrap: true,
                itemBuilder: (context, snapshot, animation, index) {
                  Map Contact = snapshot.value as Map;
                  Contact['key'] = snapshot.key;
                  print("db_Ref.child('id_user'): ${Contact['id_user']}");

                  return uuid == Contact['id_user']
                      ? GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => UpdateRecord(
                            Contact_Key: Contact['key'],
                          ),
                        ),
                      );
                      print(Contact['key']);
                    },
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          tileColor: Colors.grey[300],
                          trailing: IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red[900],
                            ),
                            onPressed: () {
                              db_Ref.child(Contact['key']).remove();
                            },
                          ),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                              Contact['url'],
                            ),
                          ),
                          title: Text(
                            Contact['name'],
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            Contact['auther'],
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                      : const SizedBox();
                },
              ),
            ),
            )
          ],
        ),
      ),
    );
  }
}