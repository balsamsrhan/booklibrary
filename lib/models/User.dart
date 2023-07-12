
import 'package:firebase_database/firebase_database.dart';

class Users {
  late String id;
  late String name;
  late String email;
  late String password;


  Users();

  //Users(this.id, this.name, this.email, this.password);
  final DatabaseReference _database = FirebaseDatabase.instance.reference().child('Users');
  Users.fromMap(Map<String, dynamic> documentMap) {
    name = documentMap['name'];
    email = documentMap['email'];
    password = documentMap['password'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['name'] = name;
    map['email'] = email;
    map['password'] = password;
    return map;
  }
  Future<void> updateBook(String id, String title, String author ,String pass) async {
    final bookRef = _database.child(id);
    await bookRef.update({'name': title, 'email': author , 'password': pass});
  }
  // final DatabaseReference _database = FirebaseDatabase.instance.reference().child('Users');
  // Future<List<Users>> getBooks() async {
  //   final DatabaseEvent databaseEvent = await _database.once();
  //   final Map<dynamic, dynamic> data =  databaseEvent.snapshot.value as Map;
  //
  //   final books = data.entries.map((entry) {
  //     final id = entry.key;
  //     final name = entry.value['name'];
  //     final email = entry.value['email'];
  //     final pass = entry.value['password'];
  //     return Users(id, name, email , password);
  //   }).toList();
  //
  //   return books;
  // }
}