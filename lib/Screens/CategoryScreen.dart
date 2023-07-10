import 'package:booklibrary/Screens/DetailsScreen.dart';
import 'package:flutter/material.dart';

import '../models/bokdemo.dart';

class BooksScreenCategory extends StatefulWidget {
  final String idCategory;
  const BooksScreenCategory({super.key, required this.idCategory});

  @override
  State<BooksScreenCategory> createState() => _BooksScreenCategoryState();
}

class _BooksScreenCategoryState extends State<BooksScreenCategory> {
  List<Bookhome> _books = [];
  final _bookService = BookService();

  @override
  void initState() {
    super.initState();

    _bookService.getBooks().then((books) {
      final filteredBooks =
      books.where((book) => book.book_category == widget.idCategory).toList();
      setState(() {
        _books = filteredBooks;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('متجر الكتب'),
          elevation: 0.0,
        ),
        body: _books != null
            ? GridView.builder(
          padding: const EdgeInsets.all(10.0),
          itemCount: _books.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.9,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsPage(selectedBook: _books[index]),
                  ),
                );
              },
              child: Card(
                child: Column(
                  children: [
                    Image.network(
                      _books[index].imageUrl,
                      height: 50,
                      width: 60,
                    ),
                    Text(_books[index].name),
                    Text(_books[index].auther),
                  ],
                ),
              ),
            );
          },
        )
            : const Center(
          child: CircularProgressIndicator(),
        ));
  }
}

/*

Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailsScreen(_books[index]),
                        ),
                      );
*/