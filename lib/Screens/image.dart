import 'dart:io';

import 'package:booklibrary/models/Helpers.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../Firebase/fb_storge_controller.dart';
class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({Key? key}) : super(key: key);

  @override
  _UploadImageScreenState createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> with Helpers {
  ImagePicker _imagePicker = ImagePicker();
  XFile? _pickedFile;
  double? _linearProgressValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Image'),
      ),
      body:  Column(
        children: [
          LinearProgressIndicator(
            minHeight: 10,
            color: Colors.green,
            backgroundColor: Colors.blue.shade200,
            value: _linearProgressValue,
          ),
          Expanded(
            child: _pickedFile != null
                ? Image.file(File(_pickedFile!.path))
                : TextButton(
              onPressed: () async => _pickImage(),
              style: TextButton.styleFrom(
                minimumSize: const Size(double.infinity, 0),
              ),
              child: const Text("Pick Image"),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () async => await performUpload(),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 60),
            ),
            icon: const Icon(Icons.cloud_upload),
            label: const Text(
              'UPLOAD',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _pickImage() async {
    XFile? imageFile = await _imagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);
    if (imageFile != null) {
      setState(() {
        _pickedFile = imageFile;
      });
    }
  }

  Future<void> performUpload() async {
    if (checkData()) {
      await uploadImage();
    }
  }

  bool checkData() {
    if (_pickedFile != null) {
      return true;
    }
    showSnackBar(
      context,
      message: 'Select image to upload',
      error: true,
    );
    return false;
  }

  Future<void> uploadImage() async {
    _changeProgressValue(value: null);
    // TaskSnapshot? task = await FbStorageController().uploadImage1(path: _pickedFile!.path);
    TaskSnapshot? task = await FBStorageFireBase().addImage(_pickedFile!.path);
    if(task != null){
      if(task.state == TaskState.success){
        showSnackBar(
          context,
          message: 'done',
          error: false,
        );
        // Navigator.pushNamed(context, "/images_screen");
        Navigator.pop(context);
      }
    }else {
      showSnackBar(
        context,
        message: 'Failed upload Image',
        error: true,
      );
    }

    // BlocProvider.of<StorageBloc>(context).add(CreateEvent(_pickedFile!.path));
  }

  void _changeProgressValue({double? value}) {
    setState(() {
      _linearProgressValue = value;
    });
  }
}

// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// class AddItem extends StatefulWidget {
//   const AddItem({Key? key}) : super(key: key);
//
//   @override
//   State<AddItem> createState() => _AddItemState();
// }
//
// class _AddItemState extends State<AddItem> {
//   TextEditingController _controllerName = TextEditingController();
//   TextEditingController _controllerQuantity = TextEditingController();
//
//   GlobalKey<FormState> key = GlobalKey();
//
//   CollectionReference _reference =
//   FirebaseFirestore.instance.collection('shopping_list');
//
//   String imageUrl = '';
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add an item'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Form(
//           key: key,
//           child: Column(
//             children: [
//               TextFormField(
//                 controller: _controllerName,
//                 decoration:
//                 InputDecoration(hintText: 'Enter the name of the item'),
//                 validator: (String? value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter the item name';
//                   }
//
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _controllerQuantity,
//                 decoration:
//                 InputDecoration(hintText: 'Enter the quantity of the item'),
//                 validator: (String? value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter the item quantity';
//                   }
//
//                   return null;
//                 },
//               ),
//               IconButton(
//                   onPressed: () async {
//                     /*
//                 * Step 1. Pick/Capture an image   (image_picker)
//                 * Step 2. Upload the image to Firebase storage
//                 * Step 3. Get the URL of the uploaded image
//                 * Step 4. Store the image URL inside the corresponding
//                 *         document of the database.
//                 * Step 5. Display the image on the list
//                 *
//                 * */
//
//                     /*Step 1:Pick image*/
//                     //Install image_picker
//                     //Import the corresponding library
//
//                     ImagePicker imagePicker = ImagePicker();
//                     XFile? file =
//                     await imagePicker.pickImage(source: ImageSource.camera);
//                     print('${file?.path}');
//
//                     if (file == null) return;
//                     //Import dart:core
//                     String uniqueFileName =
//                     DateTime.now().millisecondsSinceEpoch.toString();
//
//                     /*Step 2: Upload to Firebase storage*/
//                     //Install firebase_storage
//                     //Import the library
//
//                     //Get a reference to storage root
//                     Reference referenceRoot = FirebaseStorage.instance.ref();
//                     Reference referenceDirImages =
//                     referenceRoot.child('images');
//
//                     //Create a reference for the image to be stored
//                     Reference referenceImageToUpload =
//                     referenceDirImages.child('name');
//
//                     //Handle errors/success
//                     try {
//                       //Store the file
//                       await referenceImageToUpload.putFile(File(file!.path));
//                       //Success: get the download URL
//                       imageUrl = await referenceImageToUpload.getDownloadURL();
//                     } catch (error) {
//                       //Some error occurred
//                     }
//                   },
//                   icon: Icon(Icons.camera_alt)),
//               ElevatedButton(
//                   onPressed: () async {
//                     if (imageUrl.isEmpty) {
//                       ScaffoldMessenger.of(context)
//                           .showSnackBar(SnackBar(content: Text('Please upload an image')));
//
//                       return;
//                     }
//
//                     if (key.currentState!.validate()) {
//                       String itemName = _controllerName.text;
//                       String itemQuantity = _controllerQuantity.text;
//
//                       //Create a Map of data
//                       Map<String, String> dataToSend = {
//                         'name': itemName,
//                         'quantity': itemQuantity,
//                         'image': imageUrl,
//                       };
//
//                       //Add a new item
//                       _reference.add(dataToSend);
//                     }
//                   },
//                   child: Text('Submit'))
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }