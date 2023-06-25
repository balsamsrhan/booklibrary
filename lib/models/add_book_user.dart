import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Book {
  late String id;
  late String name;
  late String auther;
  late String details;
  late String phone;

  Book();
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Book.fromMap(Map<String, dynamic> documentMap) {
    name = documentMap['name'];
    auther = documentMap['auther'];
    details = documentMap['details'];
    phone = documentMap['phone'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['name'] = name;
    map['auther'] = auther;
    map['details'] = details;
    map['phone'] = phone;
    map['id_user'] = _firebaseAuth.currentUser!.uid;
    return map;
  }
}