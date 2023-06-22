import 'package:booklibrary/Screens/DetailsScreen.dart';
import 'package:booklibrary/models/add_book_user.dart';
import 'package:booklibrary/models/bokdemo.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Bookhome> _books = [];
  @override
  final _bookService = BookService();

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookstore'),
      ),
      body: _books != null
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
                  builder: (context) => DetailsScreen(_books[index]),
                ),
              );
            },
            child: Container(
              child: Card(
                child: Column(
                  children: [
                    Image.network(
                      _books[index].imageUrl, height: 50, width: 60,),
                    Text(_books[index].name),
                    Text(_books[index].auther),
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
    );
  }
}



//     return Scaffold(
// body: FirebaseAnimatedList(
//         query: db_Ref,
//         shrinkWrap: true,
//         itemBuilder: (context, snapshot, animation, index) {
//           Map Contact = snapshot.value as Map;
//           Contact['key'] = snapshot.key;
//           return GestureDetector(
//             onTap: () {
//               // Navigator.push(
//               //   context,
//               //   MaterialPageRoute(
//               //     builder: (_) => UpdateRecord(
//               //       Contact_Key: Contact['key'],
//               //     ),
//               //   ),
//               // );
//               // print(Contact['key']);
//             },
//             child: Container(
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: ListTile(
//                   shape: RoundedRectangleBorder(
//                     side: BorderSide(
//                       color: Colors.white,
//                     ),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   tileColor: Colors.grey[300],
//                   // trailing: IconButton(
//                   //   icon: Icon(
//                   //     Icons.delete,
//                   //     color: Colors.red[900],
//                   //   ),
//                   //   onPressed: () {
//                   //     db_Ref.child(Contact['key']).remove();
//                   //   },
//                   // ),
//                   leading: CircleAvatar(
//                     backgroundImage: NetworkImage(
//                       Contact['image'],
//                     ),
//                   ),
//                   title: Text(
//                     Contact['name'],
//                     style: TextStyle(
//                       fontSize: 25,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   subtitle: Text(
//                     Contact['name_auther'],
//                     style: TextStyle(
//                       fontSize: 25,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),

  //       backgroundColor: Colors.transparent,
  //       appBar: AppBar(
  //         backgroundColor: primarys,
  //         // backgroundColor: Colors.transparent,
  //         elevation: 0,
  //         title: Row(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           children: [
  //             // Expanded(
  //             //   child: Container(
  //             //     alignment: Alignment.centerLeft,
  //             //     child: Icon(Icons.vertical_distribute_rounded,))
  //             // ),
  //             //Icon(Icons.search_rounded),
  //             SizedBox(width: 15,),
  //             // AvatarImage(profile,
  //             //   isSVG: false, width: 27, height: 27)
  //         ],),
  //       ),
  //       body: getStackBody(),
  //     );
  // }
  //
  // getTopBlock(){
  //   return
  //     Column(
  //       children: [
  //         Container(
  //           width: double.infinity,
  //           height: 250,
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100)),
  //             color: primary1
  //           ),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               SizedBox(height: 10,),
  //                 // Container(
  //                 //   margin: EdgeInsets.only(left: 35, right:15),
  //                 //   child: Text("Hi, Sangvaleap", style: TextStyle(color: secondary,fontSize: 23, fontWeight: FontWeight.w600),),
  //                 // ),
  //                 SizedBox(height: 10,),
  //                 Container(
  //                   margin: EdgeInsets.only(left: 35, right:15),
  //                   child: Text("مرحبا بك في مكتبتك!", style: TextStyle(color: secondary,fontSize: 15, fontWeight: FontWeight.w500),),
  //                 ),
  //                 SizedBox(height: 35,),
  //                 Container(
  //                   padding: EdgeInsets.only(left: 15, right: 15, top: 10),
  //                   child: Row(
  //                     children: [
  //                       Text(
  //                         'الكتب الجديدة',
  //                         style: GoogleFonts.poppins(
  //                           fontWeight: FontWeight.w500,
  //                           color: Colors.black,
  //                           fontSize: 16.sp,
  //                         ),
  //                       ),
  //                       const Spacer(),
  //                       TextButton(
  //                         onPressed: () {},
  //                         child: Text(
  //                           'اظهار الكل',
  //                           style: GoogleFonts.poppins(
  //                             color: Colors.black,
  //                             fontWeight: FontWeight.w500,
  //                             fontSize: 16.sp,
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //                 SizedBox(height: 15,),
  //             ],
  //           ),
  //         ),
  //         Container(
  //           height: 150,
  //           color: primary1,
  //           child: Container(
  //             decoration: BoxDecoration(
  //               color: appBgColor,
  //               borderRadius: BorderRadius.only(topRight: Radius.circular(100))
  //             ),
  //           ),
  //         )
  //       ],
  //     );
  // }
  //
  // getStackBody(){
  //   return SingleChildScrollView(
  //     child: Column(
  //       children :[
  //         Container(
  //           child: Stack(
  //             clipBehavior: Clip.none,
  //             children: [
  //               Container(
  //                 child: getTopBlock(),
  //               ),
  //               Positioned(
  //                 top: 140,
  //                 left: 0, right: 0,
  //                 child: Container(
  //                   height: 260,
  //                   child: getPopularBooks(),
  //                 )
  //               ),
  //             ],
  //           ),
  //         ),
  //         SizedBox(height: 15,),
  //         Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Container(
  //               padding: EdgeInsets.only(left: 15, right: 15, top: 10),
  //               child: Row(
  //                 children: [
  //                   Text(
  //                     'الكتب الاكثر مبيعا',
  //                     style: GoogleFonts.poppins(
  //                       fontWeight: FontWeight.w500,
  //                       color: Colors.black,
  //                       fontSize: 16.sp,
  //                     ),
  //                   ),
  //                   const Spacer(),
  //                   TextButton(
  //                     onPressed: () {},
  //                     child: Text(
  //                       'اظهار الكل',
  //                       style: GoogleFonts.poppins(
  //                         fontWeight: FontWeight.w500,
  //                         color: Colors.black,
  //                         fontSize: 16.sp,
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             SizedBox(height: 15,),
  //             SizedBox(height: 25,),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }
  //
  // getPopularBooks(){
  //   return
  //     SingleChildScrollView(
  //       padding: EdgeInsets.only(bottom: 5, left: 15),
  //       scrollDirection: Axis.horizontal,
  //       child: Row(
  //           children: List.generate(popularBooks.length,
  //           (index) => BookCard(book: popularBooks[index])
  //         ),
  //       ),
  //     );
  // }
  //
  // getLatestBooks(){
  //   return
  //     SingleChildScrollView(
  //       padding: EdgeInsets.only(bottom: 5),
  //       scrollDirection: Axis.horizontal,
  //       child: Row(
  //         children: List.generate(latestBooks.length,
  //           (index) => BookCover(book: latestBooks[index])
  //         ),
  //       ),

