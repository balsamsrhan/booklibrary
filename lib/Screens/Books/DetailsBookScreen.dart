import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/Books.dart';
class Detailsf extends StatefulWidget {
  Bookhome selectedBook;
  late String uuid;
  Detailsf({Key? key, required this.selectedBook}) : super(key: key);

  @override
  _DetailsfState createState() => _DetailsfState();
}


class _DetailsfState extends State<Detailsf> {
  final database = FirebaseDatabase.instance.ref();
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  bool faved = false;

@override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final ref = database.child('cart');
    final favRef = database.child('favourites');
return Scaffold(
  body: SingleChildScrollView(
    child: SafeArea(
      child: Padding(
        padding: EdgeInsets.only(top: 30,bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:[
            Padding(padding: EdgeInsets.only(left: 25),
            child: InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
              ),
            ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                //color: Colors.black38,
                borderRadius: BorderRadius.circular(18),
              ),
              child: IconButton(
                onPressed: () async {
                  try {
                    final nextRef = <String, dynamic>{
                      'name': widget.selectedBook.name,
                      'price': widget.selectedBook.price,
                      'image': widget.selectedBook.imageUrl,
                      'id_user' : _firebaseAuth.currentUser!.uid
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
              ),
            ),
            ],
            ),
            SizedBox(height: 50),
            Center(
              child: Image.network(widget.selectedBook.imageUrl,
              width: MediaQuery.of(context).size.width/1.2,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(padding: EdgeInsets.only(left:25 , right: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                  children: [
                    Text(
                      "اسم الكتاب :",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600, fontSize: 17),
                    ),
                    Text(
                      widget.selectedBook.name,
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                      ),
                    ),
                  ],
                  ),

                  SizedBox(height: 25),
               /*   Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.all(15),
                          width: 120,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black.withOpacity(0.2),
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                CupertinoIcons.minus,
                                size: 15,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text("2"),
                              SizedBox(
                                width: 15,
                              ),
                              Icon(
                                CupertinoIcons.add,
                                size: 15,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),*/
                  SizedBox(height: 20,),
                  Column(
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
                  SizedBox(height: 20,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        " الوصف :",
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
                  SizedBox(height: 30,),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 50),
                      decoration: BoxDecoration(
                        color: Colors.black45,
                        borderRadius: BorderRadius.circular(18),
                      ),
                        child: TextButton(
                            onPressed: () async {
                              try {
                                final nextRef = <String, dynamic>{
                                  'name': widget.selectedBook.name,
                                  'price': widget.selectedBook.price,
                                  'image': widget.selectedBook.imageUrl,
                                  'count': 1,
                                  'id_user' : _firebaseAuth.currentUser!.uid
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
                              "اضف الى السلة",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 17),
                            )),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20,right: 20),
                    child:Text(
                      ' ₪ ${widget.selectedBook.price}',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 25,
                          color: Color(0xffFA4A0C)),
                    ),
                    ),
                  ],
                ),
              )
                ],
              ),
            )
          ],
        ),
      ),
    ),
  ),
);
  }
}