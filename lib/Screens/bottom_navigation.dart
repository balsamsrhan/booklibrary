import 'package:booklibrary/Screens/FavouritBook.dart';
import 'package:booklibrary/Screens/Order_Screen.dart';
import 'package:booklibrary/Screens/profile/profile_screen.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../models/bn_screen.dart';
import 'ItemListBook.dart';
import 'Profile_Screen.dart';
import 'Home_Page.dart';
class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  int _selectedPageIndex = 0;
  late TextEditingController _searchController;
  bool visible = true;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<BnScreen> screens = <BnScreen>[
      const BnScreen(title: 'الرئيسية', widget: HomeScreen()),
      const BnScreen(title: 'الكتب المستعملة', widget: ItemList()),
      const BnScreen(title: 'الطلبات', widget: Cart()),
      const BnScreen(title: 'المفضلة', widget: Favourites()),
      const BnScreen(title: 'حسابك', widget: ProfileScreen()),
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 20.h),
          child: screens[_selectedPageIndex].widget,
        ),
      ),
      bottomNavigationBar: FlashyTabBar(
        selectedIndex: _selectedPageIndex,
        showElevation: true,
        onItemSelected: (index) => setState(() {
          _selectedPageIndex = index;
        }),
        items: [
          FlashyTabBarItem(
            icon: Icon(Icons.home),
            title: Text('الرئيسية'),
          ),
          FlashyTabBarItem(
            icon: Icon(Icons.book),
            title: Text('الكتب المستعملة'),
          ),
          FlashyTabBarItem(
            icon: Icon(Icons.shopping_cart),
            title: Text('الطلبات'),
          ),
          FlashyTabBarItem(
            icon: Icon(Icons.favorite),
            title: Text('المفضلة'),
          ),
          FlashyTabBarItem(
            icon: Icon(Icons.person),
            title: Text('حسابك'),
          ),
        ],
      ),
      //   child: BottomNavigationBar(
      //     onTap: (int selectedPageIndex) {
      //       setState(() => _selectedPageIndex = selectedPageIndex);
      //     },
      //     currentIndex: _selectedPageIndex,
      //     backgroundColor: const Color(0XFF95959F),
      //     type: BottomNavigationBarType.fixed,
      //     showSelectedLabels: false,
      //     showUnselectedLabels: false,
      //     selectedItemColor: Colors.white,
      //     selectedIconTheme: const IconThemeData(
      //       color: Colors.white,
      //     ),
      //     selectedLabelStyle: GoogleFonts.montserrat(
      //       fontWeight: FontWeight.bold,
      //       fontSize: 10.sp,
      //     ),
      //     selectedFontSize: 10.sp,
      //     unselectedItemColor: Colors.white,
      //     unselectedIconTheme: const IconThemeData(
      //       color: Colors.white,
      //     ),
      //     unselectedLabelStyle: GoogleFonts.cairo(
      //       fontSize: 10.sp,
      //     ),
      //     unselectedFontSize: 10.sp,
      //     iconSize: 24,
      //     elevation: 20,
      //     items: const [
      //       BottomNavigationBarItem(
      //         activeIcon: Icon(Icons.home),
      //         icon: Icon(Icons.home_outlined),
      //         label: '',
      //       ),
      //       BottomNavigationBarItem(
      //         activeIcon: Icon(Icons.shopping_bag),
      //         icon: Icon(Icons.shopping_bag_outlined),
      //         label: '',
      //       ),
      //       BottomNavigationBarItem(
      //         activeIcon: Icon(Icons.shopping_cart),
      //         icon: Icon(Icons.shopping_cart_outlined),
      //         label: '',
      //       ),
      //       // BottomNavigationBarItem(
      //       //   activeIcon: Icon(Icons.category),
      //       //   icon: Icon(Icons.category_outlined),
      //       //   label: '',
      //       // ),
      //       // BottomNavigationBarItem(
      //       //   activeIcon: Icon(Icons.access_time_filled_sharp),
      //       //   icon: Icon(Icons.access_time_outlined),
      //       //   label: '',
      //       // ),
      //       BottomNavigationBarItem(
      //         activeIcon: Icon(Icons.person),
      //         icon: Icon(Icons.person_outline),
      //         label: '',
      //       ),
      //     ],
      //   ),

    );
  }
}
