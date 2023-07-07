import 'package:booklibrary/models/bokdemo.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailsPage extends StatefulWidget {
  Bookhome selectedBook;

  DetailsPage({Key? key, required this.selectedBook}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final database = FirebaseDatabase.instance.ref();
  bool faved = false;

  @override
  Widget build(BuildContext context) {
    final ref = database.child('cart');
    final favRef = database.child('favourites');

    return Scaffold(
      backgroundColor: Color(0xFFEFDFCF),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Column(
                  children: [
                    Row(
                      children: <Widget>[
                        SizedBox(
                          height: 40,
                          width: 40,
                          child: IconButton(
                            // Your drawer Icon
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const Spacer(),
                      //FAVOURIT ICON
                /*        IconButton(
                          onPressed: () async {
                            try {
                              final nextRef = <String, dynamic>{
                                'name': widget.selectedBook.name,
                                'price': widget.selectedBook.price,
                                'image': widget.selectedBook.imageUrl,
                              };
                              String? key;
                              await database
                                  .child('favourites')
                                  .orderByChild('name')
                                  .equalTo(widget.selectedBook.name)
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
                                    .equalTo(widget.selectedBook.name)
                                    .once()
                                    .then((value) => {
                                  if (value.snapshot.exists)
                                    {
                                      database
                                          .child('favourites')
                                          .child(key!)
                                          .remove(),
                                      setState(() {
                                        widget.selectedBook.fave =
                                        false;
                                      }),
                                    }
                                  else
                                    {
                                      database
                                          .child('favourites')
                                          .push()
                                          .set(nextRef),
                                      setState(() {
                                        widget.selectedBook.fave = true;
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
                            widget.selectedBook.fave
                                ? const AssetImage("images/favicon.png")
                                : const AssetImage("images/notfav_icon.png"),
                            color: Colors.black,
                          ),
                        ),*/

                        // Your widgets here
                      ],
                    ),
                    SizedBox(height: 150.h),
                  ],
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50.r),
                        topRight: Radius.circular(50.r),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32.w),
                      child: ListView(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 100.h),
                          Text(
                            'اسم الكتاب: ${widget.selectedBook.name}',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500, fontSize: 28),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            widget.selectedBook.price.toString(),
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 22,
                                color: Color(0xffFA4A0C)),
                          ),
                          SizedBox(height: 10.h),
                          Row(
                            children: [
                              Text(
                                "اسم المؤلف",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600, fontSize: 17),
                              ),
                              Text(
                                widget.selectedBook.auther,
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "الوصف",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600, fontSize: 17),
                              ),
                              Expanded(
                                child: Text(
                                  widget.selectedBook.description,
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 60,
                                width: 200,
                                decoration: BoxDecoration(
                                  color: Color(0xffFA4A0C),
                                  borderRadius: BorderRadius.circular(25.0),
                                ),

                           //CART
                           /*     child: TextButton(
                                    onPressed: () async {
                                      try {
                                        final nextRef = <String, dynamic>{
                                          'name': widget.selectedBook.name,
                                          'price': widget.selectedBook.price,
                                          'image': widget.selectedBook.imageUrl,
                                          'count': 1,
                                        };
                                        String? key;
                                        await database
                                            .child('cart')
                                            .orderByChild('name')
                                            .equalTo(widget.selectedBook.name)
                                            .onChildAdded
                                            .listen((event) {
                                          setState(() {
                                            key = event.snapshot.key.toString();
                                          });
                                        }, onError: (Object o) {
                                          print(o.toString());
                                        });

                                        try {
                                          ref
                                              .orderByChild('name')
                                              .equalTo(widget.selectedBook.name)
                                              .once()
                                              .then((value) => {
                                            if (value.snapshot.exists)
                                              {
                                                database
                                                    .child('cart')
                                                    .child(key!)
                                                    .child('count')
                                                    .set(widget
                                                    .selectedBook
                                                    .book_count)
                                              }
                                            else
                                              {
                                                database
                                                    .child('cart')
                                                    .push()
                                                    .set(nextRef)
                                              }
                                          });
                                        } catch (e) {
                                          print(e.toString());
                                        }
                                      } catch (e) {
                                        print('You got an error $e');
                                      }

                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      "Add to chart",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 17),
                                    )),*/
                              ),
                              SizedBox(width: 10.w),
                              Text(
                                widget.selectedBook.price.toString(),
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 22,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h,),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  SizedBox(height: 50.h),
                  Image(
                    image: NetworkImage(widget.selectedBook.imageUrl),
                    height: 241.21,
                    width: 241.21,
                  ),
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

import '../models/bokdemo.dart';
import 'order_screen.dart';

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
