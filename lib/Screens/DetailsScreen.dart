
import 'package:flutter/material.dart';

import '../models/bokdemo.dart';
import 'order_screen.dart';

class DetailsScreen extends StatelessWidget {
  final Bookhome book;

  const DetailsScreen(this.book);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            IconButton(onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoritesScreen(),
                ),
              );
            },
                icon:  Icon(Icons.favorite_border)),

            Image.network(book.imageUrl),
            Text(
              'اسم الكتاب: ${book.name}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'المؤلف: ${book.auther}',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
