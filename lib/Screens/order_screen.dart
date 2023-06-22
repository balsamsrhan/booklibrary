import 'package:booklibrary/models/bokdemo.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final databaseRef = FirebaseDatabase.instance.reference().child('favorites');

  List<Bookhome> favoriteBooks = [];

  @override
  void initState() {
    super.initState();
   // fetchFavoriteBooks();
  }



  void removeFromFavorites(String bookId) {
    databaseRef.child(bookId).remove().then((_) {
      setState(() {
        favoriteBooks.removeWhere((book) => book.id == bookId);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      // body: ListView.builder(
      //   itemCount: favoriteBooks.length,
      //   itemBuilder: (BuildContext context, int index) {
      //     final booksd = favoriteBooks[index];
      //     return ListTile(
      //       leading: Image.network(booksd.imageUrl),
      //       title: Text(booksd.name),
      //       subtitle: Text(booksd.auther),
      //       trailing: IconButton(
      //         icon: Icon(Icons.favorite),
      //         onPressed: () {
      //           removeFromFavorites(booksd.id);
      //         },
      //       ),
      //     );
      //   },
      // ),
    );
  }
}
