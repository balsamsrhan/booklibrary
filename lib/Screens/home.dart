import 'package:booklibrary/theme/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../theme/colors.dart';
import '../widgtes/bottombar_item.dart';
import 'Home_screen.dart';
import 'Profile_Screen.dart';
import 'hom.dart';
import 'home_page.dart';
import 'image.dart';
import 'images_screen.dart';
class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int activeTab = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      bottomNavigationBar: getBottomBar(),
      body: getPage()
    );
  }

  Widget getBottomBar() {
    return Container(
      height: 65,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(100), 
        ), 
        color: bottomBarColor,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25, top: 10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    activeTab = 0;
                  });
                },
                child: BottomBarItem(Icons.home, "الرئسية", isActive: activeTab == 0, activeColor: secondary),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    activeTab = 1;
                  });
                },
                child: BottomBarItem(Icons.book, "الكتب المستعملة", isActive: activeTab == 1, activeColor: secondary),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    activeTab = 2;
                  });
                },
                child: BottomBarItem(Icons.shopping_cart_rounded, "الطلبات", isActive: activeTab == 2, activeColor: secondary),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    activeTab = 3;
                  });
                },
                child: BottomBarItem(Icons.person, "حسابك", isActive: activeTab == 3, activeColor: secondary),
              )
            ]
          )
        ),
    );
  }

  Widget getPage(){
    return 
      Container(
        decoration: BoxDecoration(
          color: bottomBarColor
        ),
        child: Container(
          decoration: BoxDecoration(
            color: appBgColor,
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(80)
            )
          ),
          child: IndexedStack(
            index: activeTab,
            children: <Widget>[
              HomePage(),
              ItemList(),
              ImagesScreen(),
              ProfileScreen()
            ],
          ),
        ),
      );
  }
}
