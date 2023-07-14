/*
import 'package:booklibrary/auth/login_screen.dart';
import 'package:booklibrary/auth/register_screen.dart';
import 'package:booklibrary/widgtes/app_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TabBarPage extends StatefulWidget {
  const TabBarPage({Key? key}) : super(key: key);

  @override
  _TabBarPageState createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
          Text(
            'مرحبا ، سجل الدخول للمتابعة!',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade800,
            ),
          ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),

        child: Column(

          children: [
            const Spacer(),
            SizedBox(width: 20.w),
            Expanded(
              flex: 2,
              child: AppButton(
                onPress: () {
                  Navigator.pushReplacementNamed(context, '/login_screen');
                },
                text: 'تسجيل الدخول',
              ),
            ),
            SizedBox(width: 20.w),
            Expanded(
              flex: 2,
              child: AppButton(
                onPress: () {
                  Navigator.pushReplacementNamed(context, '/register_screen');
                },
                text: 'اشتراك',
                textColor: Colors.black,
                buttonColor: Colors.white,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
      // Container(
      //   child: Padding(
      //     padding: EdgeInsets.symmetric(horizontal: 10),
      //     child: Container(
      //       height: MediaQuery.of(context).size.height,
      //       child: Column(
      //         children: [
      //           SizedBox(height: 20),
      //           Container(
      //             // height: 50,
      //             width: MediaQuery.of(context).size.height,
      //             decoration: BoxDecoration(
      //                 color: HexColor("C19A6B"),
      //                 borderRadius: BorderRadius.circular(8)),
      //             child: Column(
      //               children: [
      //                 Padding(
      //                   padding: EdgeInsets.all(5),
      //                   child: TabBar(
      //                     unselectedLabelColor: Colors.white,
      //                     labelColor: Colors.black,
      //                     indicatorColor: Colors.white,
      //                     indicatorWeight: 2,
      //                     indicator: BoxDecoration(
      //                       color: Colors.white,
      //                       borderRadius: BorderRadius.circular(5),
      //                     ),
      //                     controller: tabController,
      //                     tabs: [
      //                       Tab(
      //                         text: 'تسجيل دخول',
      //                       ),
      //                       Tab(
      //                         text: 'اشتراك',
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ),
      //           Expanded(
      //             child: TabBarView(
      //               controller: tabController,
      //               children: [
      //                 LoginScreen(),
      //                 RegisterScreen(),
      //               ],
      //             ),
      //           )
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}*/

// class HexColor extends Color {
//   static int _getColor(String hex) {
//     String formattedHex =  "FF" + hex.toUpperCase().replaceAll("#", "");
//     return int.parse(formattedHex, radix: 16);
//   }
//   HexColor(final String hex) : super(_getColor(hex));
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgtes/app_button.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Image.asset('images/splach.png'),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50.r),
                  topRight: Radius.circular(50.r),
                ),
                color: Colors.grey[200],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),
                    Text(
                      'مرحباً',
                      style: GoogleFonts.poppins(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'أسرع خدمة توصيل للكتب لك.',
                      style: GoogleFonts.poppins(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 40.h),
                    Row(
                      children: [
                        const Spacer(),
                        Expanded(
                          flex: 2,
                          child: AppButton(
                            onPress: () {
                              Navigator.pushReplacementNamed(
                                  context, '/login_screen');
                            },
                            text: 'تسجيل الدخول',
                            buttonColor: Colors.white,
                            textColor: Colors.black,
                          ),
                        ),
                        SizedBox(width: 20.w),
                        Expanded(
                          flex: 2,
                          child: AppButton(
                            onPress: () {
                              Navigator.pushReplacementNamed(
                                  context, '/register_screen');
                            },
                            text: 'اشتراك',
                            textColor: Colors.white,
                            buttonColor: Colors.black,
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
