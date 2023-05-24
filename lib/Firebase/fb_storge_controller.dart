import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FBStorageFireBase {
  /*
  * add
  * delete
  * read*/

  Future<TaskSnapshot?> addImage(String path) async {
    final storageRef = FirebaseStorage.instance.ref("images/");
    final mainStorage = storageRef.child("${DateTime.now()}_image");
    try {
      TaskSnapshot task =  await mainStorage.putFile(File(path));
      return task;
      // print(task.state);
      // print(await mountainImagesRef.getDownloadURL());

    } on FirebaseException catch (e) {
      print(e.message);
      return null;
    }
    // TaskSnapshot task =  await mainStorage.putFile(File(path)).snapshot;
    // return task;
  }

  Future<List<Reference>> readAllImage() async {
    final storageRef = FirebaseStorage.instance.ref("images/");
    ListResult result = await storageRef.listAll();
    return result.items;
  }

  deleteImage(path) {
    final storageRef = FirebaseStorage.instance.ref("images/");

    storageRef
        .child(path)
        .delete()
        .then((value) => true)
        .onError((error, stackTrace) => false);
  }
}
