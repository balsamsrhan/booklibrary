import 'package:booklibrary/models/Seconde_HandBooks.dart';
import 'package:booklibrary/models/Books.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';


class DetailsBookUser extends StatefulWidget {
  Book selectedBook;
  DetailsBookUser({Key? key, required this.selectedBook}) : super(key: key);
  @override
  _DetailsBookUserState createState() => _DetailsBookUserState();
}

class _DetailsBookUserState extends State<DetailsBookUser> {
  final database = FirebaseDatabase.instance.ref();
  bool faved = false;
  var phone = "";
  var msg = "";
  var code = "+970";
  @override
  Widget build(BuildContext context) {
    final ref = database.child('cart');
    final favRef = database.child('favourites');

    return Scaffold(
      backgroundColor: Color(0xffffffff),
      appBar: AppBar(
        backgroundColor: Color(0xffffffff),
        elevation: 0.0,
      //   actions: [
      //     Padding(
      //       padding: const EdgeInsets.only(right: 20.0),
      //       child: IconButton(
      //         onPressed: () async {
      //           try {
      //             final nextRef = <String, dynamic>{
      //               'name': widget.selectedBook.name,
      //               'price': widget.selectedBook.price,
      //               'image': widget.selectedBook.imageUrl,
      //             };
      //             String? key;
      //             await database
      //                 .child('favourites')
      //                 .orderByChild('name')
      //                 .equalTo(widget.selectedFood.name)
      //                 .onChildAdded
      //                 .listen((event) {
      //               setState(() {
      //                 key = event.snapshot.key.toString();
      //               });
      //             }, onError: (Object o) {
      //               print(o.toString());
      //             });
      //             try {
      //               favRef
      //                   .orderByChild('name')
      //                   .equalTo(widget.selectedFood.name)
      //                   .once()
      //                   .then((value) => {
      //                 if (value.snapshot.exists)
      //                   {
      //                     database
      //                         .child('favourites')
      //                         .child(key!)
      //                         .remove(),
      //                     setState(() {
      //                       widget.selectedFood.fave = false;
      //                     }),
      //                   }
      //                 else
      //                   {
      //                     database
      //                         .child('favourites')
      //                         .push()
      //                         .set(nextRef),
      //                     setState(() {
      //                       widget.selectedFood.fave = true;
      //                     }),
      //                   }
      //               });
      //             } catch (e) {
      //               print(e.toString());
      //             }
      //           } catch (e) {
      //             print(e.toString());
      //           }
      //         },
      //         icon: ImageIcon(
      //           widget.selectedFood.fave
      //               ? const AssetImage("images/favicon.png")
      //               : const AssetImage("images/notfav_icon.png"),
      //           color: Colors.black,
      //         ),
      //       ),
      //     )
      //   ],
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 40,
              width: 40,
              child: IconButton(
                // Your drawer Icon
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: ImageIcon(
                  AssetImage("images/appbar_back.png"),
                  color: Colors.black,
                ),
              ),
            ),
            // Your widgets here
          ],
        ),
      ), //CustomAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerRight,
              child: Column(
                children: [
                  Column(
                    children: [
                      Image(
                        image: NetworkImage(widget.selectedBook.image),
                        height: 241.21,
                        width: 241.21,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'اسم الكتاب: ${widget.selectedBook.name}',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 28),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed: () async {
                      // https://wa.me/1XXXXXXXXXX?text=I'm%20interested%20in%20your%20car%20for%20sale

                      if (phone.length < 10) {
                        Fluttertoast.showToast(
                            msg: "Enter a valid phone number",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 2,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            webPosition: "center",
                            fontSize: 16.0);
                      } else {
                        code = code.replaceAll("+", "");

                        var url = "https://wa.me/594884151?";
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw "Could not launch $url";
                        }
                        // print(code);
                      }
                    }, child: Text('data'),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "اسم المؤلف",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 17),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 60,
                    child: Text(
                      widget.selectedBook.auther,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      Text(
                        "الوصف",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 17),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 60,
                    child: Text(
                      widget.selectedBook.details,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  //
                  // Row(
                  //   children: [
                  //     Text(
                  //       widget.selectedFood.price.toString(),
                  //       style: TextStyle(
                  //           fontWeight: FontWeight.w500,
                  //           fontSize: 22,
                  //           color: Color(0xffefdfcf)),
                  //     ),
                  //     Container(
                  //       height: 60,
                  //       width: 200,
                  //       decoration: BoxDecoration(
                  //         color: Color(0xffFA4A0C),
                  //         borderRadius: BorderRadius.circular(25.0),
                  //       ),
                  //       child: TextButton(
                  //           onPressed: () async {
                  //             try {
                  //               final nextRef = <String, dynamic>{
                  //                 'name': widget.selectedFood.name,
                  //                 'price': widget.selectedFood.price,
                  //                 'image': widget.selectedFood.imageUrl,
                  //                 'count': 1,
                  //               };
                  //               String? key;
                  //               await database
                  //                   .child('cart')
                  //                   .orderByChild('name')
                  //                   .equalTo(widget.selectedFood.name)
                  //                   .onChildAdded
                  //                   .listen((event) {
                  //                 setState(() {
                  //                   key = event.snapshot.key.toString();
                  //                 });
                  //               }, onError: (Object o) {
                  //                 print(o.toString());
                  //               });
                  //
                  //               try {
                  //                 ref
                  //                     .orderByChild('name')
                  //                     .equalTo(widget.selectedFood.name)
                  //                     .once()
                  //                     .then((value) => {
                  //                   if (value.snapshot.exists)
                  //                     {
                  //                       database
                  //                           .child('cart')
                  //                           .child(key!)
                  //                           .child('count')
                  //                           .set(widget
                  //                           .selectedFood.book_count)
                  //                     }
                  //                   else
                  //                     {
                  //                       database
                  //                           .child('cart')
                  //                           .push()
                  //                           .set(nextRef)
                  //                     }
                  //                 });
                  //               } catch (e) {
                  //                 print(e.toString());
                  //               }
                  //             } catch (e) {
                  //               print('You got an error $e');
                  //             }
                  //
                  //             Navigator.pop(context);
                  //           },
                  //           child: Text(
                  //             "Add to chart",
                  //             style: TextStyle(color: Colors.white, fontSize: 17),
                  //           )),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

//PreferredSizeWidget CustomAppBar(BuildContext context) =>
}

/*

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../models/Books.dart';
import 'Order_Screen.dart';

class DetailsPage extends StatefulWidget {
  Boo selectedFood;
  DetailsPage({Key? key, required this.selectedFood}) : super(key: key);
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final database = FirebaseDatabase.instance.ref();
  bool faved = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffF2F2F2),
        elevation: 0.0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: IconButton(
              onPressed: () async {
                try {
                  final nextRef = <String, dynamic>{
                    'name': book.name,
                    'price': book.price,
                    'image': book.imageUrl,
                  };
                  String? key;
                  await database
                      .child('favourites')
                      .orderByChild('name')
                      .equalTo(widget.selectedFood.name)
                      .onChildAdded
                      .listen((event) {
                    setState(() {
                      key = event.snapshot.key.toString();
                    });
                  }, onError: (Object o) {
                    print(o.toString());
                  });
                  try {
                    favRef
                        .orderByChild('name')
                        .equalTo(widget.selectedFood.name)
                        .once()
                        .then((value) => {
                      if (value.snapshot.exists)
                        {
                          database
                              .child('favourites')
                              .child(key!)
                              .remove(),
                          setState(() {
                            widget.selectedFood.faved = false;
                          }),
                        }
                      else
                        {
                          database
                              .child('favourites')
                              .push()
                              .set(nextRef),
                          setState(() {
                            widget.selectedFood.faved = true;
                          }),
                        }
                    });
                  } catch (e) {
                    print(e.toString());
                  }
                } catch (e) {
                  print(e.toString());
                }
              },
              icon: ImageIcon(
                widget.selectedFood.faved
                    ? const AssetImage("lib/assets/favicon.png")
                    : const AssetImage("lib/assets/notfav_icon.png"),
                color: Colors.black,
              ),
            ),
          )
        ],
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 40,
              width: 40,
              child: IconButton(
                // Your drawer Icon
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: ImageIcon(
                  AssetImage("lib/assets/appbar_back.png"),
                  color: Colors.black,
                ),
              ),
            ),
            // Your widgets here
          ],
        ),
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
*/
