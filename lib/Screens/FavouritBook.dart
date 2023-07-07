import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../models/cart.dart';

class Favourites extends StatefulWidget {
  const Favourites({Key? key}) : super(key: key);

  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  final database = FirebaseDatabase.instance.ref();
   List<CartBook> favouritesList = [];
  // @override
  // final _bookService = BookService2();
  //
  @override
  void initState() {
    super.initState();
_activateListeners();
  }

  void _activateListeners() {
     database.child('favourites').onValue.listen((event) {
      final map = event.snapshot.value as Map<dynamic, dynamic>;
      favouritesList.clear();
      map.forEach((key, value) {
        var cartFood = CartBook.fromJson(json.decode(json.encode(value)));
        cartFood.id = key;
        favouritesList.add(cartFood);
      });
      setState(() {
        favouritesList = favouritesList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
   // final readFavsRef = database.child('favourites');
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      appBar: AppBar(
        toolbarHeight: 70.0,
        centerTitle: true,
        title: Text(
          "المفضلة",
          style: TextStyle(
              fontWeight: FontWeight.w600, fontSize: 24, color: Colors.black),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0, bottom: 30.0),
        child: Column(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: ListView.builder(
                  itemCount: favouritesList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin:
                      EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0),
                      child: Slidable(
                        endActionPane: ActionPane(children: [
                          SlidableAction(
                            autoClose: true,
                            backgroundColor: Colors.transparent,
                            foregroundColor: Color(0xffDF2C2C),
                            icon: Icons.delete,
                            onPressed: (context) {
                              favouritesList[index].faved = false;
                              deleteFromDatabase(
                                  database, favouritesList[index]);
                            },
                          ),
                        ], motion: ScrollMotion()),
                        child: Container(
                          width: 333,
                          height: 102,
                          child: InkWell(
                            onTap: () {},
                            child: Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.r),
                              ),
                              child: Row(
                                children: [
                                  Image(
                                    image:
                                    NetworkImage(favouritesList[index].imagepath!),
                                    height: 100,
                                    width: 100,
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          favouritesList[index].name.toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20),
                                        ),
                                        Text(
                                          '₪'+ favouritesList[index].price.toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15,
                                              color: Color(0xffFA4A0C)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                 // ItemPropotion(favouritesList[index]),
                                  SizedBox(width: 10.w),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> deleteFromDatabase(
      DatabaseReference database, CartBook cartBook) async {
    final ref = database.child('favourites');
    String? key;
    database
        .child('favourites')
        .orderByChild('name')
        .equalTo(cartBook.name)
        .onChildAdded
        .listen((event) {
      setState(() {
        key = event.snapshot.key.toString();
      });
    }, onError: (Object o) {
      print(o.toString());
    });

    try {
      ref.orderByChild('name').equalTo(cartBook.name).once().then((value) => {
        if (value.snapshot.exists)
          {
            database.child('favourites').child(key!).remove(),
          }
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
