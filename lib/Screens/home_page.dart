
import 'dart:ui';
import 'package:booklibrary/data/json.dart';
import 'package:booklibrary/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgtes/app_text_field.dart';
import '../widgtes/avatar_image.dart';
import '../widgtes/book_card.dart';
import '../widgtes/book_cover.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController _searchController;
  @override
  Widget build(BuildContext context) {
    return 
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: primarys,
          // backgroundColor: Colors.transparent,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Expanded(
              //   child: Container(
              //     alignment: Alignment.centerLeft,
              //     child: Icon(Icons.vertical_distribute_rounded,))
              // ),
              //Icon(Icons.search_rounded),
              SizedBox(width: 15,),
              // AvatarImage(profile,
              //   isSVG: false, width: 27, height: 27)
          ],),
        ),
        body: getStackBody(),
      );
  }

  getTopBlock(){
    return 
      Column(
        children: [
          Container(
            width: double.infinity,
            height: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100)),
              color: primary1
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10,),
                  // Container(
                  //   margin: EdgeInsets.only(left: 35, right:15),
                  //   child: Text("Hi, Sangvaleap", style: TextStyle(color: secondary,fontSize: 23, fontWeight: FontWeight.w600),),
                  // ),
                  SizedBox(height: 10,),
                  Container(
                    margin: EdgeInsets.only(left: 35, right:15),
                    child: Text("مرحبا بك في مكتبتك!", style: TextStyle(color: secondary,fontSize: 15, fontWeight: FontWeight.w500),),
                  ),
                  SizedBox(height: 35,),
                  Container(
                    padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                    child: Row(
                      children: [
                        Text(
                          'الكتب الجديدة',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontSize: 16.sp,
                          ),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'اظهار الكل',
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15,),
              ],
            ),
          ),
          Container(
            height: 150,
            color: primary1,
            child: Container(
              decoration: BoxDecoration(
                color: appBgColor,
                borderRadius: BorderRadius.only(topRight: Radius.circular(100))
              ),
            ),
          )
        ],
      );
  }

  getStackBody(){
    return SingleChildScrollView(
      child: Column(
        children :[ 
          Container(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  child: getTopBlock(),
                ),
                Positioned(
                  top: 140,
                  left: 0, right: 0,
                  child: Container(
                    height: 260,
                    child: getPopularBooks(),
                  )
                ),
              ],
            ),
          ),
          SizedBox(height: 15,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                child: Row(
                  children: [
                    Text(
                      'الكتب الاكثر مبيعا',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: 16.sp,
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'اظهار الكل',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15,),
              Container(
                margin: EdgeInsets.only(left: 15),
                child: getLatestBooks(),
              ),
              SizedBox(height: 25,),
            ],
          ),
        ],
      ),
    );
  }

  getPopularBooks(){
    return
      SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 5, left: 15),
        scrollDirection: Axis.horizontal,
        child: Row(
            children: List.generate(popularBooks.length, 
            (index) => BookCard(book: popularBooks[index])
          ),
        ),
      );
  }

  getLatestBooks(){
    return
      SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 5),
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(latestBooks.length, 
            (index) => BookCover(book: latestBooks[index])
          ),
        ),
      );
  }

}