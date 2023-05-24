
import 'dart:io';
import 'package:booklibrary/widgtes/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../widgtes/app_button.dart';

class AddItem extends StatefulWidget {
  const AddItem({Key? key}) : super(key: key);

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerdetailes = TextEditingController();
  TextEditingController _controllerauther = TextEditingController();

  GlobalKey<FormState> key = GlobalKey();

  CollectionReference _reference =
  FirebaseFirestore.instance.collection('book_user');

  String imageUrl = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: key,
          child: Card(
            margin: EdgeInsets.only(top: 90),
            shadowColor: Colors.black,
            color: Color(0xFFF1E7D7),
            elevation: 50,
            child: SizedBox(
              width: 400,
              height: 450,
              child:  Padding(
                  padding: const EdgeInsets.all(15.0),
            child: Column(
            children: [
              // SizedBox(height: 20.h),
              // Text(
              //   'اعرض كتابك المستعمل للبيع',
              //   textAlign: TextAlign.center,
              //   style: GoogleFonts.poppins(
              //     fontSize: 16,
              //     fontWeight: FontWeight.w500,
              //     color: Colors.grey.shade500,
              //   ),
              // ),
              SizedBox(height: 40.h),
              IconButton(
                  onPressed: () async {
                    /*
                * Step 1. Pick/Capture an image   (image_picker)
                * Step 2. Upload the image to Firebase storage
                * Step 3. Get the URL of the uploaded image
                * Step 4. Store the image URL inside the corresponding
                *         document of the database.
                * Step 5. Display the image on the list
                *
                * */

                    /*Step 1:Pick image*/
                    //Install image_picker
                    //Import the corresponding library

                    ImagePicker imagePicker = ImagePicker();
                    XFile? file =
                    await imagePicker.pickImage(source: ImageSource.gallery);
                    print('${file?.path}');

                    if (file == null) return;
                    //Import dart:core
                    String uniqueFileName =
                    DateTime.now().millisecondsSinceEpoch.toString();

                    /*Step 2: Upload to Firebase storage*/
                    //Install firebase_storage
                    //Import the library

                    //Get a reference to storage root
                    Reference referenceRoot = FirebaseStorage.instance.ref();
                    Reference referenceDirImages =
                    referenceRoot.child('images');

                    //Create a reference for the image to be stored
                    Reference referenceImageToUpload =
                    referenceDirImages.child('name');

                    //Handle errors/success
                    try {
                      //Store the file
                      await referenceImageToUpload.putFile(File(file!.path));
                      //Success: get the download URL
                      imageUrl = await referenceImageToUpload.getDownloadURL();
                    } catch (error) {
                      //Some error occurred
                    }
                  },
                  icon: Icon(Icons.camera_alt)),
              SizedBox(height: 20.h),
              AppTextField(
                textEditingController: _controllerName,
                hintText: 'أدخل اسم الكتاب',
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(10),
                 // child: SvgPicture.asset('images/email.svg'),
                ),
                keyboardType: TextInputType.text,
                // only accept letters from a to z
                //FilteringTextInputFormatter(RegExp(r'[a-zA-Z]'), allow: true)
              ),
              SizedBox(height: 20.h),
              AppTextField(
                textEditingController: _controllerauther,
                hintText: 'أدخل اسم مؤلف الكتاب ',
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(10),
                  // child: SvgPicture.asset('images/email.svg'),
                ),
                keyboardType: TextInputType.text,
                // only accept letters from a to z
                //FilteringTextInputFormatter(RegExp(r'[a-zA-Z]'), allow: true)
              ),
              SizedBox(height: 20.h),
              AppTextField(
                textEditingController: _controllerdetailes,
                hintText: 'أدخل تفاصيل الكتاب ',
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(10),
                  // child: SvgPicture.asset('images/email.svg'),
                ),
                keyboardType: TextInputType.text,
                // only accept letters from a to z
                //FilteringTextInputFormatter(RegExp(r'[a-zA-Z]'), allow: true)
              ),
              SizedBox(height: 20.h),
              AppButton(
                text: 'اضافة',
                buttonColor: const Color(0XFFC19A6B),
                  onPress: () async {
                    if (imageUrl.isEmpty) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text('ارفع صورة من فضلك !')));

                      return;
                    }

                    if (key.currentState!.validate()) {
                      String itemName = _controllerName.text;
                      String itemQuantity = _controllerdetailes.text;
                      String itemauther = _controllerauther.text;

                      //Create a Map of data
                      Map<String, String> dataToSend = {
                        'name': itemName,
                        'auther': itemauther,
                        'detiles': itemQuantity,
                        'image': imageUrl,
                      };

                      //Add a new item
                      _reference.add(dataToSend);
                    }
                  },
                  )
            ],
          ),
        ),
      ),
      ),
    ),
      ),
    );
  }
}
/*
import 'package:booklibrary/models/add_book_user.dart';
import 'package:flutter/material.dart';

import '../Firebase/fb_firebase.dart';
import '../models/Helpers.dart';
import '../widgtes/app_text_field.dart';
class AddBook extends StatefulWidget {
  const AddBook({Key? key}) : super(key: key);

  @override
  State<AddBook> createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> with Helpers{
  late TextEditingController _titleTextController;
  late TextEditingController _autherTextController;
  late TextEditingController _detailsTextController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _titleTextController = TextEditingController();
    _autherTextController = TextEditingController();
    _detailsTextController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _titleTextController.dispose();
    _autherTextController.dispose();
    _detailsTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: [
          AppTextField(
            prefixIcon: Padding(
              padding: const EdgeInsets.all(10),
            ),
            textEditingController: _titleTextController,
            hintText: 'أدخل اسم الكتاب ',
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 10),
          AppTextField(
            prefixIcon: Padding(
              padding: const EdgeInsets.all(10),
            ),
            textEditingController: _autherTextController,
            hintText: 'أدخل اسم المؤلف ',
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 10),
          AppTextField(
            prefixIcon: Padding(
              padding: const EdgeInsets.all(10),
            ),
            textEditingController: _detailsTextController,
            hintText: 'أدخل تفاصيل الكتاب  ',
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: () async => await performProcess(),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(0, 50),
            ),
            child: const Text('SAVE'),
          ),

        ],
      ),
    );
  }

  Future<void> performProcess() async {
    if (checkData()) {
      await process();
    }
  }

  bool checkData() {
    if (_titleTextController.text.isNotEmpty &&
        _autherTextController.text.isNotEmpty&&
        _detailsTextController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(context,message: 'يجب ادخال بيانات', error: true);
    return false;
  }

  Future<void> process() async {
    bool b = await FBFireStore().addData(note);
    if (b) {
      showSnackBar(context, message: 'تمت الاضافة بنجاح', error: true);
    } else {
      showSnackBar(context, message: 'هناك خطأ ما!', error: true);
    }
  }

  Book get note {
    Book note =  Book() ;
    note.name = _titleTextController.text;
    note.auther = _autherTextController.text;
    note.details = _detailsTextController.text;
    return note;
  }

  void clear() {
    _titleTextController.text = '';
    _autherTextController.text = '';
    _detailsTextController.text = '';
  }
}
*/
