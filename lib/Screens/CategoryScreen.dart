import 'package:booklibrary/Screens/DetailsScreen.dart';
import 'package:booklibrary/models/add_book_user.dart';
import 'package:booklibrary/models/bokdemo.dart';
import 'package:booklibrary/models/category.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import 'DetailsBookCategory.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
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
        body: _categories != null
            ? GridView.builder(
          padding: const EdgeInsets.all(10.0),
          itemCount: _categories.length,
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
                    builder: (context) => BooksScreen(
                        idCategory: _categories[index].id.toString()),
                  ),
                );
              },
              child: Card(
                child: Center(child: Text(_categories[index].name)),
              ),
            );
          },
        )
            : const Center(
          child: CircularProgressIndicator(),
        ));
  }

// SizedBox(
//   height: 100,
//   child: ListView.builder(
//     scrollDirection: Axis.horizontal,
//     itemCount: _categories.length,
//     itemBuilder: ((context, index) {
//       return Padding(
//         padding: const EdgeInsets.only(left: 8.0),
//         child: Chip(label: Text("${_categories[index].name}")),
//       );
//     }),
//   ),
// ),
}
