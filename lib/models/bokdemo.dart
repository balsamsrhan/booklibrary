import 'package:firebase_database/firebase_database.dart';

class Bookhome {
  final String id;
   String name;
  final String auther;
  final String description;
  final double price;
 final String book_category;
  final int book_count;
  final String imageUrl;

  Bookhome(this.id, this.name, this.auther ,this.imageUrl, this.description, this.price, this.book_category, this.book_count);
  //Bookhome({required this.id, required this.name, required this.auther,required this.description,required this.price,required this.book_category,required this.book_count, required this.imageUrl});

}

class BookService {
  final DatabaseReference _database = FirebaseDatabase.instance.reference().child('Books');

  Future<List<Bookhome>> getBooks() async {
    final DatabaseEvent databaseEvent = await _database.once();
    final Map<dynamic, dynamic> data =  databaseEvent.snapshot.value as Map;

    final books = data.entries.map((entry) {
      final id = entry.key;
      final title = entry.value['name'];
      final author = entry.value['name_auther'];
      final description = entry.value['description'];
      final price = entry.value['price'];
      final book_caterg = entry.value['cat_book'];
      final book_count = entry.value['count'];
      final image = entry.value['image'];
      return Bookhome(id, title, author , description,price,book_caterg,book_count,image,);
    }).toList();

    return books;
  }

  Future<void> addBook(String title, String author) async {
    final bookRef = _database.push();
    await bookRef.set({'name': title, 'name_auther': author});
  }

  Future<void> updateBook(String id, String title, String author) async {
    final bookRef = _database.child(id);
    await bookRef.update({'name': title, 'name_auther': author});
  }

  Future<void> deleteBook(String id) async {
    final bookRef = _database.child(id);
    await bookRef.remove();
  }
}
