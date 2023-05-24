/*
import 'package:booklibrary/Screens/addBook.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  CollectionReference _referenceShoppingList =
  FirebaseFirestore.instance.collection('book_user');
  late Stream<QuerySnapshot> _streamShoppingItems;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  initState() {
    super.initState();

    _streamShoppingItems = _referenceShoppingList.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   // Here we take the value from the MyHomePage object that was created by
      //   // the App.build method, and use it to set our appbar title.
      //   title: Text(widget.title),
      //   actions: [
      //     IconButton(
      //         onPressed: () async {
      //           await GoogleSignIn().signOut();
      //           FirebaseAuth.instance.signOut();
      //         },
      //         icon: Icon(Icons.power_settings_new))
      //   ],
      // ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _streamShoppingItems,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          if (snapshot.connectionState == ConnectionState.active) {
            QuerySnapshot querySnapshot = snapshot.data;
            List<QueryDocumentSnapshot> listQueryDocumentSnapshot =
                querySnapshot.docs;

            return ListView.builder(
                itemCount: listQueryDocumentSnapshot.length,
                itemBuilder: (context, index) {
                  QueryDocumentSnapshot document =
                  listQueryDocumentSnapshot[index];
                  return ShoppingListItem(document: document);
                });
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddBook()));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class ShoppingListItem extends StatefulWidget {
  const ShoppingListItem({
    Key? key,
    required this.document,
  }) : super(key: key);

  final QueryDocumentSnapshot<Object?> document;

  @override
  State<ShoppingListItem> createState() => _ShoppingListItemState();
}

class _ShoppingListItemState extends State<ShoppingListItem> {
  bool _purchased = false;

  @override
  Widget build(BuildContext context) {
    return GridView(
      // onTap: () {
      //   Navigator.of(context).push(MaterialPageRoute(
      //       builder: (context) => ItemDetails(widget.document.id)));
      // },
      title: Text(widget.document['name']),
      subtitle: Text(widget.document['details']),
      trailing: Checkbox(
        onChanged: (value) {
          setState(() {
            _purchased = value ?? false;
          });
        },
        value: _purchased,
      ),
    );
  }
}*/
