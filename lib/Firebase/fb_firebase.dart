import 'package:booklibrary/models/User.dart';
import 'package:booklibrary/models/add_book_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FBFireStore {
  /*
  * create
  * delete
  * read
  * update
  * */

  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<bool> addData(Book book) async {
    return await _firebaseFirestore
        .collection("book_user")
        .add(book.toMap())
        .then((value) => true)
        .onError((error, stackTrace){
      print(error);
      return false;
    });
  }
  // Future<bool> addDataWithoutAuto(Book book) async {
  //   var f =  _firebaseFirestore.collection("book_user").doc();
  //   book.id = f.id;
  //   return await _firebaseFirestore
  //       .collection("book_user")
  //       .doc(f.id)
  //       .set(book.toMap())
  //       .then((value) => true)
  //       .onError((error, stackTrace){
  //     print(error);
  //     return false;
  //   });
  // }

  // updateData(id, User note) {
  //   //db.rowquery(note,note.toMap,where:'id = ?',whereArgs:id);
  //   _firebaseFirestore.collection("note").doc(id).update(note.toMap());
  // }
  //
  // deleteData(id) {
  //   _firebaseFirestore.collection("note").doc(id).delete();
  // }

  Stream<QuerySnapshot> readData() async* {
    yield* _firebaseFirestore.collection("book_user").snapshots();
  }

  // Future<QuerySnapshot> readData1() async {
  //   return _firebaseFirestore.collection("book_user").get();
  // }
}
