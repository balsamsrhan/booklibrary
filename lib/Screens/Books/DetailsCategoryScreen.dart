import 'package:booklibrary/Screens/Books/DetailsBookScreen.dart';
import 'package:flutter/material.dart';

import '../../models/Books.dart';

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

        body: Padding(padding: EdgeInsets.only(top: 50,left: 10,right: 10,bottom: 10),
        child:_books != null
            ? GridView.builder(
          //padding: const EdgeInsets.all(10.0),
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
                    builder: (context) => Detailsf(selectedBook: _books[index]),
                  ),
                );
              },
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    // padding: EdgeInsets.all(12),
                    height: 320,
                    width: 220,
                    child: Card(
                      color: Colors.grey[200],
                      elevation: 6.0,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(20.0)),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        //mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(_books[index].imageUrl , width: 200, height: 100,),
                          ),
                          Padding(padding: EdgeInsets.symmetric(vertical: 8.0,horizontal: 8.0),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(_books[index].name,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18)),
                                Text(_books[index].auther,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Color(0xFFBCAAA4),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18)),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "₪" +
                                      _books[index].price.toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Color(0xFF675A54),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ),
                                Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFBCAAA4),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Icon(Icons.add
                                  ),
                                )
                              ],
                            ),
                          ),
                          // SizedBox(
                          //   width: 160,
                          //   child: Text(_books[index].name,
                          //       textAlign: TextAlign.center,
                          //       style: TextStyle(
                          //           fontWeight: FontWeight.w500,
                          //           fontSize: 18)),
                          // ),

                          // Padding(padding:EdgeInsets.only(left: 20,right: 20),
                          //     child:Row(
                          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //       children: [
                          //         Text(
                          //           "₪" +
                          //               _books[index].price.toString(),
                          //           textAlign: TextAlign.center,
                          //           style: TextStyle(
                          //               color: Color(0xffFA4A0C),
                          //               fontWeight: FontWeight.w600,
                          //               fontSize: 17),
                          //         ),
                          //         Container(
                          //           padding: EdgeInsets.all(5),
                          //           decoration: BoxDecoration(
                          //             color: Colors.black45,
                          //             borderRadius: BorderRadius.circular(20),
                          //           ),
                          //           child: Icon(
                          //             CupertinoIcons.cart_badge_plus,
                          //             size: 20,
                          //           ),
                          //         )
                          //       ],
                          //     )
                          //SizedBox(
                          //   width: 70,
                          //   child: Text(
                          //     "₪" +
                          //         _books[index].price.toString(),
                          //     textAlign: TextAlign.center,
                          //     style: TextStyle(
                          //         color: Color(0xffFA4A0C),
                          //         fontWeight: FontWeight.w600,
                          //         fontSize: 17),
                          //   ),
                          // ),

                        ],
                      ),
                    ),
                  ),
                  // Positioned(
                  //    top: -30,
                  //    left: -12,
                  //    child: Image(
                  //      image: AssetImage(_books[index].imageUrl),
                  //    ),
                  //  ),
                ],
              ),
            );
          },
        )
            : const Center(
          child: CircularProgressIndicator(),
        ))
    );
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