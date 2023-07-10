import 'dart:io';

import 'package:booklibrary/Screens/Home_Page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UpdateRecord extends StatefulWidget {
  String Contact_Key;
  UpdateRecord({required this.Contact_Key});

  @override
  State<UpdateRecord> createState() => _UpdateRecordState();
}

class _UpdateRecordState extends State<UpdateRecord> {
  TextEditingController contactName = new TextEditingController();
  TextEditingController contactNumber = new TextEditingController();
  var url;
  var url1;
  File? file;
  ImagePicker image = ImagePicker();
  DatabaseReference? db_Ref;

  @override
  void initState() {
    super.initState();
    db_Ref = FirebaseDatabase.instance.ref().child('Book_user');
    Contactt_data();
  }

  void Contactt_data() async {
    DataSnapshot snapshot = await db_Ref!.child(widget.Contact_Key).get();

    Map Contact = snapshot.value as Map;

    setState(() {
      contactName.text = Contact['name'];
      contactNumber.text = Contact['details'];
      url = Contact['url'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Record'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                height: 200,
                width: 200,
                child: url == null
                    ? MaterialButton(
                  height: 100,
                  child: Image.file(
                    file!,
                    fit: BoxFit.fill,
                  ),
                  onPressed: () {
                    getImage();
                  },
                )
                    : MaterialButton(
                  height: 100,
                  child: CircleAvatar(
                    maxRadius: 100,
                    backgroundImage: NetworkImage(
                      url,
                    ),
                  ),
                  onPressed: () {
                    getImage();
                  },
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: contactName,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Name',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: contactNumber,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Number',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            MaterialButton(
              height: 40,
              onPressed: () {
                // getImage();

                if (file != null) {
                  uploadFile();
                } else {
                  directupdate();
                }
              },
              child: Text(
                "Update",
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 20,
                ),
              ),
              color: Colors.indigo[900],
            ),
          ],
        ),
      ),
    );
  }

  getImage() async {
    var img = await image.pickImage(source: ImageSource.gallery);
    setState(() {
      url = null;
      file = File(img!.path);
    });

    // print(file);
  }

  uploadFile() async {
    try {
      var imagefile = FirebaseStorage.instance
          .ref()
          .child("book_photo")
          .child("/${contactName.text}.jpg");
      UploadTask task = imagefile.putFile(file!);
      TaskSnapshot snapshot = await task;
      url1 = await snapshot.ref.getDownloadURL();
      setState(() {
        url1 = url1;
      });
      if (url1 != null) {
        Map<String, String> Contact = {
          'name': contactName.text,
          'details': contactNumber.text,
          'url': url1,
        };

        db_Ref!.child(widget.Contact_Key).update(Contact).whenComplete(() {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => HomeScreen(),
            ),
          );
        });
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  directupdate() {
    if (url != null) {
      Map<String, String> Contact = {
        'name': contactName.text,
        'details': contactNumber.text,
        'url': url,
      };

      db_Ref!.child(widget.Contact_Key).update(Contact).whenComplete(() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => HomeScreen(),
          ),
        );
      });
    }
  }
}