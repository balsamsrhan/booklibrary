import 'package:booklibrary/Screens/Books/DetailsBookScreen.dart';
import 'package:booklibrary/Models/Books.dart';
import 'package:booklibrary/Models/Cart.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Models/Category.dart';
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
  late double width, height;
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

  void FunCategory() {
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 30.0, right: 30.0, top: 50),
            child: SizedBox(
              width: 200,
              child: Text(
                "اهلا وسهلا بك في مكتبتك ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                textAlign: TextAlign.start,
              ),
            ),
          ),
          const SizedBox(height: 20),
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
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: ImageIcon(AssetImage("images/searchicon.png"),
                        color: Colors.black),
                  ),
                  fillColor: Colors.grey[200],
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(25.7),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(25.7),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 30.0, right: 30.0, top: 10),
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
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: SizedBox(
                height: 70,
                //color: Colors.grey,
                child: _categories != null
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
                                  builder: (context) => BooksScreenCategory(
                                      idCategory:
                                          _categories[index].id.toString()),
                                ),
                              );
                            },
                            child: Card(
                              elevation: 4.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0)),
                              child: Row(
                                children: [
                                  Padding(
                                      padding: EdgeInsets.all(8),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: Image.network(
                                            _categories[index].image),
                                      )),
                                  Container(
                                    child: Text(
                                      _categories[index].name,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
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
          Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 15.0),
            child: Container(
              alignment: Alignment.bottomCenter,
            ),
          ),
          const Padding(
            padding:
                EdgeInsets.only(left: 30.0, right: 30.0, top: 10, bottom: 10),
            child: SizedBox(
              width: 200,
              child: Text(
                "الأكثر شهرة ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                textAlign: TextAlign.start,
              ),
            ),
          ),
          _books.isNotEmpty
              ? Expanded(
                  child: SingleChildScrollView(
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
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.network(
                                                _books[index].imageUrl,
                                                width: 200,
                                                height: 100,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 8.0,
                                                  horizontal: 8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(_books[index].name,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 18)),
                                                  Text(_books[index].auther,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xFFBCAAA4),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18)),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 25.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "₪" +
                                                        _books[index]
                                                            .price
                                                            .toString(),
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFF675A54),
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 16),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.all(4),
                                                    decoration: BoxDecoration(
                                                      color: Color(0xFFBCAAA4),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                    ),
                                                    child: Icon(Icons.add),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
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
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ],
      ),
    );
  }
}
