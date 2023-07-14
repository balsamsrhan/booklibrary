import 'package:booklibrary/Screens/Books/DetailsBookScreen.dart';
import 'package:booklibrary/models/Books.dart';
import 'package:booklibrary/models/Cart.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../models/Category.dart';
import 'BookCategory.dart';
import 'DetailsCategoryScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Bookhome> _books = [];

  List<Categ> _categories = [];
  String name = '';
  final _categoriesService = CategService();
  @override
  final _bookService = BookService();
  var scaffoldkey = GlobalKey<ScaffoldState>();
  //TabController? _tabController;
  late double width , height;
  @override
  void initState() {
    // _tabController = TabController(length: 5, vsync: this);
    super.initState();
    _bookService.getBooks().then((books) {
      setState(() {
        _books = books;
      });
    });
    FunCategory();
  }
  void FunCategory(){
    _categoriesService.getCategories().then((categories) {
      setState(() {
        _categories = categories;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: scaffoldkey,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      //drawer: CustomDrawer(),
      // appBar: AppBar(
      //   titleSpacing: 0.0,
      //   backgroundColor: Color(0xffffffff),
      //   elevation: 0.0,
      //   leading: Padding(
      //     padding: const EdgeInsets.only(left: 20.0),
      //     child: IconButton(
      //         color: Colors.black,
      //         icon: Icon(Icons.access_alarm),
      //         onPressed: () => scaffoldkey.currentState?.openDrawer()), //
      //   ),
      //   actions: [
      //     Padding(
      //       padding: const EdgeInsets.only(right: 20.0 , left: 20.0),
      //       child: IconButton(
      //         onPressed: () {
      //           Navigator.push(
      //               context, MaterialPageRoute(builder: (context) => BookCategory()));
      //         },
      //         icon: Image(
      //           image: AssetImage("images/shopping-cart.png"),
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 50),
              child: SizedBox(
                width: 200,
                child: Text(
                  "اهلا وسهلا بك في مكتبتك ",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 80,
                height: 50,
                child: TextFormField(
                  cursorColor: Colors.black,
                  autofocus: false,
                  decoration: InputDecoration(
                    filled: true,
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: ImageIcon(AssetImage("images/searchicon.png"),
                          color: Colors.black),
                    ),
                    fillColor: Colors.grey[200],
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(25.7),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(25.7),
                    ),
                  ),
                  onChanged: (value){
                    setState(() {
                      name = value;
                    });

                  },
                ),
              ),
            ),

/*      Expanded(
        child: Column(
          children: [
            Expanded(
              child: CarouselSlider(
                options: CarouselOptions(
                  enlargeCenterPage: true,
                  pauseAutoPlayOnManualNavigate: true,
                  autoPlay: true,
                  viewportFraction: 0.8,
                  autoPlayInterval: const Duration(seconds: 2),
                  autoPlayAnimationDuration:
                  const Duration(milliseconds: 1000),
                  autoPlayCurve: Curves.fastOutSlowIn,
                ),
                items: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 2.0,
                      vertical: 10,
                    ),
                    child: Image.asset("images/1.png"),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5.0,
                      vertical: 20,
                    ),
                    child: Image.asset("images/2.png"),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5.0,
                      vertical: 20,
                    ),
                    child: Image.asset("images/3.png"),
                  ),
                ],
              ),
            ),
        ]
      ),
      ),*/
            Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30.0,top: 10),
              child: SizedBox(
                width: 200,
                child: Text(
                  "الفئات",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
           Padding(
             padding: const EdgeInsets.only(left: 10,right: 10),
             child: Container(
                  height: 70,
                  //color: Colors.grey,
                  child : _categories != null
                      ? ListView.builder(
                    padding: const EdgeInsets.all(10.0),
                    itemCount: _categories.length,
                    // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    //   crossAxisCount: 2,
                    //   childAspectRatio: 0.9,
                    // ),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  BooksScreenCategory(
                                      idCategory: _categories[index].id.toString()),
                            ),
                          );
                        },
                        child: Card(
                          elevation: 4.0,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(30.0)),
                          child: Row(
                            children: [
                              Padding(padding: EdgeInsets.all(8),
                             child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.network(_categories[index].image),
                              )),
                              Container(

                                child: Text(_categories[index].name,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                                margin: EdgeInsets.all(10),
                                alignment: Alignment.center,
                              ),

                            ],
                          ),
                          color: Colors.grey[200],
                        ),
                      );
                    },
                  )
                      : const Center(
                    child: CircularProgressIndicator(),
                  )),
           ),
            //Code عرض الكاتيجوري

/*     Container(
        child:  _categories != null
            ? ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.all(10.0),
          itemCount: _categories.length,
          scrollDirection: Axis.horizontal,
          physics: const ClampingScrollPhysics(),
          // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //   crossAxisCount: 2,
          //   childAspectRatio: 0.9,
          // ),
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
              child: Row(
                children: [
                  new Row(children: [
                    ElevatedButton(
                      child:  Text(_categories[index].name),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BooksScreen(
                                idCategory: _categories[index].id.toString()),
                          ),
                        );
                      },
                    ),
                  ])
                ],
              ),
              // child: Card(
              //   child: Center(child: Text(_categories[index].name)),
              // ),
            );
          },
        )  : const Center(
          child: CircularProgressIndicator(),
        )
    ),*/
            Padding(
              padding: const EdgeInsets.only(top: 15.0, left: 15.0),
              child: Container(
                alignment: Alignment.bottomCenter,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30.0,top: 10,bottom: 10),
              child: SizedBox(
                width: 200,
                child: Text(
                  "الأكثر شهرة ",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  textAlign: TextAlign.start,
                ),
              ),
            ),

           Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 7.0),
                    child: CarouselSlider.builder(
                      itemCount: 4,
                      itemBuilder: (context, index, realIndex) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Detailsf(
                                        selectedBook: _books[index])));
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
                                      BorderRadius.circular(30.0)),
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
                      options: CarouselOptions(
                          height: 270.0,
                          enableInfiniteScroll: false,
                          autoPlay: false,
                          initialPage: 0,
                          enlargeCenterPage: false,
                          viewportFraction: 0.7),
                    ),
                  ),
                ],
              ),
            ),
      ],
          ),
      ),
    );

  }
}
// return _books != null
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
//             builder: (context) => CategoryScreen(),
//           ),
//         );
//         // Navigator.push(
//         //   context,
//         //   MaterialPageRoute(
//         //     builder: (context) => DetailsPage(selectedBook: _books[index]),
//         //   ),
//         // );
//       },
//       child: Card(
//         elevation: 5,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(30.r),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Expanded(
//               child: Image.network(
//                 _books[index].imageUrl, fit: BoxFit.contain,),
//             ),
//             Text(_books[index].name,textAlign: TextAlign.center,),
//             Text(_books[index].auther),
//             SizedBox(height: 10.h),
//           ],
//         ),
//       ),
//     );
//   },
// )
//     : Center(
//   child: CircularProgressIndicator(),
// );



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
