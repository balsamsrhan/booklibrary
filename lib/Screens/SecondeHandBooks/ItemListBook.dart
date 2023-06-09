import 'package:booklibrary/Screens/SecondeHandBooks/DetailesSecondeHandBook.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Models/Seconde_HandBooks.dart';
import 'AddSecondHandeBooks.dart';

class ItemList extends StatefulWidget {
  const ItemList({Key? key}) : super(key: key);
   // _stream = _reference.snapshots();

 @override
 _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  List<Book> _books = [];
  @override
  final _bookService = BookServiceUser();

  @override
  void initState() {
    super.initState();
    _bookService.getBooks().then((books) {
      setState(() {
        _books = books;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    DatabaseReference db_Ref =
    FirebaseDatabase.instance.ref().child('Second_HandBook');
    print(db_Ref);
    // if(action  == ){
    //
    // }
    return Scaffold(
backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.brown[400],
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddItem(),
            ),
          );
        },
        child: Icon(
          Icons.add,
        ),
      ),
      // appBar: AppBar(
      //   title: Text(
      //     'Contacts',
      //     style: TextStyle(
      //       fontSize: 30,
      //     ),
      //   ),
      //   backgroundColor: Colors.indigo[900],
      // ),
        body:Container(
          child:
           _books != null
              ? GridView.builder(
            padding: EdgeInsets.all(10.0),
            itemCount: _books.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.9,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsBookUser(selectedBook: _books[index]),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: Colors.grey[200],
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child:  ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(_books[index].image,width: 150,),
                          ),
                        ),
                        Text(_books[index].name, textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18)),
                        Text(_books[index].auther,  style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Color(0xFFBCAAA4),
              fontSize: 18)),
                        SizedBox(height: 10.h),
                      ],
                    ),
                  ),
                ),
              );
            },
          )
              : Center(
            child: CircularProgressIndicator(),
          ),


          // _books != null
          //     ? GridView.builder(
          //   padding: EdgeInsets.all(10.0),
          //   itemCount: _books.length,
          //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //     crossAxisCount: 2,
          //     childAspectRatio: 0.9,
          //   ),
          //   itemBuilder: (context, index) {
          //     return GestureDetector(
          //       onTap: () {
          //         Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //             builder: (context) => DetailsBookUser(selectedBook: _books[index]),
          //           ),
          //         );
          //       },
          //       child: Container(
          //         child: Card(
          //           child: Column(
          //             children: [
          //               Image.network(
          //                 _books[index].image, height: 50, width: 60,),
          //               Text(_books[index].name),
          //               Text(_books[index].auther),
          //             ],
          //           ),
          //         ),
          //       ),
          //     );
          //   },
          // )
          //     : Center(
          //   child: CircularProgressIndicator(),
          // ),
        )

    );
  }
}

  //     body: FirebaseAnimatedList(
  //       query: db_Ref,
  //       shrinkWrap: true,
  //       itemBuilder: (context, snapshot, animation, index) {
  //         Map Contact = snapshot.value as Map;
  //         Contact['key'] = snapshot.key;
  //         return GestureDetector(
  //           onTap: () {
  //             Navigator.push(
  //               context,
  //               MaterialPageRoute(
  //                 builder: (_) => UpdateRecord(
  //                   Contact_Key: Contact['key'],
  //                 ),
  //               ),
  //             );
  //             print(Contact['key']);
  //           },
  //
  //           child: Container(
  //             child: Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: ListTile(
  //                 shape: RoundedRectangleBorder(
  //                   side: BorderSide(
  //                     color: Colors.white,
  //                   ),
  //                   borderRadius: BorderRadius.circular(10),
  //                 ),
  //                 tileColor: Colors.grey[300],
  //                 // trailing: IconButton(
  //                 //   icon: Icon(
  //                 //     Icons.delete,
  //                 //     color: Colors.red[900],
  //                 //   ),
  //                 //   onPressed: () {
  //                 //     db_Ref.child(Contact['key']).remove();
  //                 //   },
  //                 // ),
  //                 leading: CircleAvatar(
  //                   backgroundImage: NetworkImage(
  //                     Contact['url'],
  //                   ),
  //                 ),
  //                 title: Text(
  //                   Contact['name'],
  //                   style: TextStyle(
  //                     fontSize: 25,
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                 ),
  //                 subtitle: Text(
  //                   Contact['auther'],
  //                   style: TextStyle(
  //                     fontSize: 25,
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         );
  //       },
  //
  //     ),
  //
  //   );
  // }
  // }
    /*return Scaffold(
      appBar: AppBar(
        title: Text('Items'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _stream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          //Check error
          if (snapshot.hasError) {
            return Center(child: Text('Some error occurred ${snapshot.error}'));
          }

          //Check if data arrived
          if (snapshot.hasData) {
            //get the data
            QuerySnapshot querySnapshot = snapshot.data;
            List<QueryDocumentSnapshot> documents = querySnapshot.docs;

            //Convert the documents to Maps
            List<Map> items = documents.map((e) => e.data() as Map).toList();

            //Display the list
            return ListView.builder(
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  //Get the item at this index
                  Map thisItem = items[index];
                  //REturn the widget for the list items
                  return ListTile(
                    title: Text('${thisItem['name']}'),
                    subtitle: Text('${thisItem['detiles']}'),
                    leading: Container(
                      height: 80,
                      width: 80,
                      child: thisItem.containsKey('image') ? Image.network(
                          '${thisItem['image']}') : Container(),
                    ),
                    // onTap: () {
                    //   Navigator.of(context).push(MaterialPageRoute(
                    //       builder: (context) => ItemDetails(thisItem['id'])));
                    // },
                  );
                });
          }

          //Show loader
          return Center(child: CircularProgressIndicator());
        },
      ), //Display a list // Add a FutureBuilder
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddItem()));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
        backgroundColor: Color(0xFFBCAAA4),
      ),
    );
  }
}
*//*
import 'package:booklibrary/Screens/AddSecondHandeBooks.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ItemList extends StatelessWidget {

   ItemList({Key? key}) : super(key: key){

    _stream = _reference.snapshots();
  }

  CollectionReference _reference =
  FirebaseFirestore.instance.collection('book_user');

  //_reference.get()  ---> returns Future<QuerySnapshot>
  //_reference.snapshots()--> Stream<QuerySnapshot> -- realtime updates
  late Stream<QuerySnapshot> _stream;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Items'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _stream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          //Check error
          if (snapshot.hasError) {
            return Center(child: Text('Some error occurred ${snapshot.error}'));
          }

          //Check if data arrived
          if (snapshot.hasData) {
            //get the data
            QuerySnapshot querySnapshot = snapshot.data;
            List<QueryDocumentSnapshot> documents = querySnapshot.docs;

            //Convert the documents to Maps
            List<Map> items = documents.map((e) => e.data() as Map).toList();

            //Display the list
            return ListView.builder(
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  //Get the item at this index
                  Map thisItem = items[index];
                  //REturn the widget for the list items
                  return ListTile(
                    title: Text('${thisItem['name']}'),
                    subtitle: Text('${thisItem['details']}'),
                    leading: Container(
                      height: 80,
                      width: 80,
                      // child: thisItem.containsKey('image') ? Image.network(
                      //     '${thisItem['image']}') : Container(),
                    ),
                    // onTap: () {
                    //   Navigator.of(context).push(MaterialPageRoute(
                    //       builder: (context) => ItemDetails(thisItem['id'])));
                    // },
                  );
                });
          }

          //Show loader
          return Center(child: CircularProgressIndicator());
        },
      ), //Display a list // Add a FutureBuilder
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddBook()));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}*//*
*/