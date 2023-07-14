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
/*      appBar: AppBar(
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
      ), *///CustomAppBar(context),
      body:getBody()
/*      Padding(
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
      ),*/
    );
  }

  Widget getBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Center(child: Image.network(widget.selectedBook.image,width: 250,height: 360,)),
              Padding(
                padding: const EdgeInsets.only(top: 30,left: 10,right: 10),
                child: SafeArea(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                          icon: Icon(Icons.arrow_forward_ios_outlined),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                    ],
                  ),
                ),
              )
            ],
          ),

          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(widget.selectedBook.name, style: TextStyle(
                    fontWeight: FontWeight.bold
                ),),
                SizedBox(height: 8,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(widget.selectedBook.auther, style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22
                    ),),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)
                          ),
                          // child: Center(
                          //   child: Text("-", style: TextStyle(
                          //       color: Colors.white
                          //   ),),
                          // ),
                          // child: IconButton(
                          //   onPressed: () async {
                          //     try {
                          //       final nextRef = <String, dynamic>{
                          //         'name': widget.selectedBook.name,
                          //         'price': widget.selectedBook.price,
                          //         'image': widget.selectedBook.imageUrl,
                          //         'id_user' : _firebaseAuth.currentUser!.uid
                          //       };
                          //       String? key;
                          //       await database
                          //           .child('favourites')
                          //           .orderByChild('name')
                          //           .equalTo(widget.selectedBook.name)
                          //           .onChildAdded
                          //           .listen((event) {
                          //         setState(() {
                          //           key = event.snapshot.key.toString();
                          //         });
                          //       }, onError: (Object o) {
                          //         print(o.toString());
                          //       });
                          //       try {
                          //         favRef
                          //             .orderByChild('name')
                          //             .equalTo(widget.selectedBook.name)
                          //             .once()
                          //             .then((value) => {
                          //           if (value.snapshot.exists)
                          //             {
                          //               database
                          //                   .child('favourites')
                          //                   .child(key!)
                          //                   .remove(),
                          //               setState(() {
                          //                 widget.selectedBook.fave =
                          //                 false;
                          //               }),
                          //             }
                          //           else
                          //             {
                          //               database
                          //                   .child('favourites')
                          //                   .push()
                          //                   .set(nextRef),
                          //               setState(() {
                          //                 widget.selectedBook.fave = true;
                          //               }),
                          //             }
                          //         });
                          //       } catch (e) {
                          //         print(e.toString());
                          //       }
                          //     } catch (e) {
                          //       print(e.toString());
                          //     }
                          //   },
                          //   icon: ImageIcon(
                          //     widget.selectedBook.fave
                          //         ? const AssetImage("images/save.png")
                          //         : const AssetImage("images/notfav_icon.png"),
                          //     color: Colors.red,
                          //   ),
                          // ),
                          // SizedBox(width: 15,),
                          // Text("1", style: TextStyle(
                          //     fontSize: 12,
                          //     fontWeight: FontWeight.bold
                          // ),),
                          // SizedBox(width: 15,),
                          // Container(
                          //   width: 20,
                          //   height: 20,
                          //   decoration: BoxDecoration(
                          //       color: Colors.black,
                          //       borderRadius: BorderRadius.circular(5)
                          //   ),
                          //   child: Center(
                          //     child: Text("+", style: TextStyle(
                          //         color: Colors.white
                          //     ),),
                          //   ),
                          // ),
                        ),
                      ],
                    ),

                  ],
                ),
                SizedBox(height: 20,),
                Text(
                  widget.selectedBook.details,
                  style: TextStyle(
                      fontSize: 15,
                      height: 1.3,
                      fontWeight: FontWeight.w500
                  ),),
                SizedBox(height: 50,),
                Center(
                  child: Container(
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[200]
                    ),
                    child: Center(
                      child: Text(
                        widget.selectedBook.phone,
                        style: TextStyle(

                        ),
                      ),
                    ),
                  ),
                ),
                // Row(
                //   children: <Widget>[
                //     Icon(Icons.access_time),
                //     SizedBox(width: 8,),
                //     Text(widget.selectedBook.phone,
                //       style: TextStyle(
                //           fontWeight: FontWeight.w700,
                //           fontSize: 20,
                //           color: Colors.grey
                //       ),
                //     ),
                //     SizedBox(width: 30,),
                //
                //   ],
                // ),
               // SizedBox(height: 30,),
               //  Row(
               //    mainAxisAlignment: MainAxisAlignment.spaceBetween,
               //    children: <Widget>[
               //      Stack(
               //        children: <Widget>[
               //          Container(
               //            width: 200,
               //            height: 50,
               //            decoration: BoxDecoration(
               //                color: Colors.grey,
               //                borderRadius: BorderRadius.circular(25)
               //            ),
               //            child: TextButton(
               //              onPressed: () async {
               //                try {
               //                  final nextRef = <String, dynamic>{
               //                    'name': widget.selectedBook.name,
               //                    'price': widget.selectedBook.price,
               //                    'image': widget.selectedBook.imageUrl,
               //                    'count': 1,
               //                    'id_user' : _firebaseAuth.currentUser!.uid
               //                  };
               //                  String? key;
               //                  await database
               //                      .child('cart')
               //                      .orderByChild('name')
               //                      .equalTo(widget.selectedBook.name)
               //                      .onChildAdded
               //                      .listen((event) {
               //                    setState(() {
               //                      key = event.snapshot.key.toString();
               //                    });
               //                  }, onError: (Object o) {
               //                    print(o.toString());
               //                  });
               //
               //                  try {
               //                    ref
               //                        .orderByChild('name')
               //                        .equalTo(widget.selectedBook.name)
               //                        .once()
               //                        .then((value) => {
               //                      if (value.snapshot.exists)
               //                        {
               //                          database
               //                              .child('cart')
               //                              .child(key!)
               //                              .child('count')
               //                              .set(widget
               //                              .selectedBook
               //                              .book_count)
               //                        }
               //                      else
               //                        {
               //                          database
               //                              .child('cart')
               //                              .push()
               //                              .set(nextRef)
               //                        }
               //                    });
               //                  } catch (e) {
               //                    print(e.toString());
               //                  }
               //                } catch (e) {
               //                  print('You got an error $e');
               //                }
               //
               //                Navigator.pop(context);
               //              },
               //              child: Text(
               //                'أضف الى السلة',
               //                style: TextStyle(
               //                    color: Colors.white,
               //                    fontWeight: FontWeight.w600,
               //                    fontSize: 18
               //                ),
               //              ),
               //              // child:Positioned(
               //              //   top: 20,
               //              //   left: 18,
               //              //   child: Container(
               //              //     width: 35,
               //              //     height: 35,
               //              //     child: Stack(
               //              //       children: <Widget>[
               //              //         Icon(Icons.shopping_cart, color: Colors.white,
               //              //           size: 30,),
               //              //         Positioned(
               //              //           right: 0,
               //              //           child: Container(
               //              //             width: 18,
               //              //             height: 18,
               //              //             decoration: BoxDecoration(
               //              //                 shape: BoxShape.circle,
               //              //                 color: Colors.red
               //              //             ),
               //              //             child: Center(
               //              //               child: Text("1", style: TextStyle(
               //              //                   fontSize: 12,
               //              //                   fontWeight: FontWeight.bold,
               //              //                   color: Colors.white
               //              //               ),),
               //              //             ),
               //              //           ),
               //              //         )
               //              //       ],
               //              //     ),
               //              //   ),
               //              // ) ,
               //              // child: Text(
               //              //   "اضف الى السلة",
               //              //   style: TextStyle(
               //              //       color: Colors.white, fontSize: 17),
               //              // )
               //            ),
               //          ),
               //
               //
               //
               //
               //        ],
               //      ),
               //      Column(
               //        crossAxisAlignment: CrossAxisAlignment.start,
               //        children: <Widget>[
               //          SizedBox(height: 8),
               //          Padding(
               //            padding: const EdgeInsets.only(left: 30),
               //            child: Text(widget.selectedBook.price.toString(),
               //              style: TextStyle(
               //                  fontSize: 23,
               //                  color: Colors.grey,
               //                  fontWeight: FontWeight.bold
               //
               //              ),),
               //          )
               //        ],
               //      ),
               //    ],
               //  ),
                SizedBox(height: 30,)
              ],
            ),
          )
        ],
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
