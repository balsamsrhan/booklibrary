import 'package:booklibrary/Screens/DetailsScreen.dart';
import 'package:booklibrary/models/add_book_user.dart';
import 'package:booklibrary/models/bokdemo.dart';
import 'package:booklibrary/models/category.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import 'CategoryScreen.dart';

class BookCategory extends StatefulWidget {
  const BookCategory({Key? key}) : super(key: key);

  @override
  _BookCategoryState createState() => _BookCategoryState();
}

class _BookCategoryState extends State<BookCategory> {
  List<Categ> _categories = [];

  final _categoriesService = CategService();

  @override
  void initState() {
    super.initState();
    _categoriesService.getCategories().then((categories) {
      setState(() {
        _categories = categories;
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
        body:Container(
         height: 70,


       //color: Colors.grey,
       child : _categories != null
            ? ListView.builder(
          padding: const EdgeInsets.all(10.0),
          itemCount: _categories.length,
          // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //   crossAxisCount: 2,
          //   childAspectRatio: 0.9,
          // ),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        BooksScreenCategory(
                            idCategory: _categories[index].id.toString()),
                  ),
                );
              },
              child: Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(30.0)),
                child: Container(child: Text(_categories[index].name,
style: TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.bold
),
                ),
                width: 100,
                  margin: EdgeInsets.all(10),
                  alignment: Alignment.center,
                ),
                color: Colors.grey[200],
              ),
            );
          },
        )
            : const Center(
          child: CircularProgressIndicator(),
        )),
    );


  }
}