import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Book {
  late String id;
  late String name;
  late String auther;
  late String details;
  late String image;
  late String phone;

  Book(this.id, this.name, this.auther, this.details, this.image, this.phone);

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  // Book.fromMap(Map<String, dynamic> documentMap) {
  //   name = documentMap['name'];
  //   auther = documentMap['auther'];
  //   details = documentMap['details'];
  //   phone = documentMap['phone'];
  // }
  //
  // Map<String, dynamic> toMap() {
  //   Map<String, dynamic> map = <String, dynamic>{};
  //   map['name'] = name;
  //   map['auther'] = auther;
  //   map['details'] = details;
  //   map['phone'] = phone;
  //   map['id_user'] = _firebaseAuth.currentUser!.uid;
  //   return map;
  // }
}
class BookServiceUser {
  final DatabaseReference _database = FirebaseDatabase.instance.reference()
      .child('Book_user');

  Future<List<Book>> getBooks() async {
    final DatabaseEvent databaseEvent = await _database.once();
    final Map<dynamic, dynamic> data = databaseEvent.snapshot.value as Map;

    final books = data.entries.map((entry) {
      final id = entry.key;
      final title = entry.value['name'];
      final author = entry.value['auther'];
      final description = entry.value['details'];
      final image = entry.value['url'];
      final phone = entry.value['phone'];
      return Book(
          id,
          title,
          author,
          description,
          image,
          phone);
    }).toList();

    return books;
  }

}