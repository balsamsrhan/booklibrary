import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';

class Categ {
  final dynamic id;
  final dynamic name;

  Categ({required this.id, required this.name});
}

class CategService {
  final DatabaseReference _database =
  FirebaseDatabase.instance.reference().child('category_book');

  Future<List<Categ>> getCategories() async {
    final DatabaseEvent databaseEvent = await _database.once();
    print("databaseEvent: ${databaseEvent.snapshot.value}");

    final List<dynamic> dataList =
    databaseEvent.snapshot.value as List<dynamic>;

    final categories = dataList
        .where((data) => data != null) // Filter out null entries
        .map((data) {
      final id = data['id'];
      final name = data['name'];

      return Categ(
        id: id,
        name: name,
      );
    }).toList();

    return categories;
  }
}
