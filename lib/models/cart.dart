
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class CartBook {
  String? id;
  String? imagepath;
  String? name;
  int? price;
  int? count;
  bool? faved = false;


  CartBook(
      this.id, this.imagepath, this.name, this.price, this.count, this.faved);
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  CartBook.fromJson(Map<String, dynamic> json) {
    id = json['key'];
    imagepath = json['image'];
    name = json['name'];
    price = json['price'];
    count = json['count'];
    faved = json['faved'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = id;
    data['id-user'] = _firebaseAuth.currentUser!.uid;
    data['image'] = imagepath;
    data['name'] = name;
    data['price'] = price;
    data['count'] = count;
    data['faved'] = faved;
    throw (0);
  }


}
class BookService2 {
  final DatabaseReference _database = FirebaseDatabase.instance.reference()
      .child('favourites');

  Future<List<CartBook>> getBooks() async {
    final DatabaseEvent databaseEvent = await _database.once();
    final Map<dynamic, dynamic> data = databaseEvent.snapshot.value as Map;

    final books = data.entries.map((entry) {
      final id = entry.value['key'];
      final image = entry.value['image'];
      final name = entry.value['name'];
      final price = entry.value['price'];
      final count = entry.value['count'];
      final faved = entry.value['faved'];
      return CartBook(
          id,
          image,
          name,
          price,
          count,
          faved,

      );
    }).toList();

    return books;
  }
}