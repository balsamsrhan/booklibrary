import 'package:booklibrary/Screens/AddressScreen.dart';
import 'package:booklibrary/Screens/MyBookUser.dart';
import 'package:booklibrary/Screens/UpdateProfile.dart';
import 'package:booklibrary/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../auth/login_screen.dart';
import 'RestPassword.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body : ListView(
      children: [
        SizedBox(height: 20.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Text(
            'الملف الشخصي',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(height: 60.h),
        CircleAvatar(
          radius: 50.r,
          backgroundColor: const Color(0XFFE6E6E6),
          child: Text(
            'ب',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          'بلسم سرحان',
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    Image.asset(
                      'images/person.svg',
                      height: 24.h,
                      width: 24.w,
                    ),
                    SizedBox(width: 8.w),
                    TextButton(onPressed: (){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
                        return  UpdateProfileScreen(studentKey: 'id');
                      }));
                    }, child:
                    Text(
                      'تحديث بياناتي',
                      style: GoogleFonts.poppins(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    ),
                    const Spacer(),
                    const Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              InkWell(
                onTap: () {
                },
                child: Row(
                  children: [
                    Image.asset(
                      'images/reset.png',
                      height: 24.h,
                      width: 24.w,
                    ),
                    SizedBox(width: 8.w),
                    TextButton(onPressed: (){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
                        return  ResetScreen();
                      }));
                    }, child:
                    Text(
                      'اعادة كلمة المرور',
                      style: GoogleFonts.poppins(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    ),
                    const Spacer(),
                    const Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              InkWell(
                onTap: () {
                },
                child: Row(
                  children: [
                    Image.asset(
                      'images/location.png',
                      height: 24.h,
                      width: 24.w,
                    ),
                    SizedBox(width: 8.w),
                    TextButton(onPressed: (){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
                        return  MyAdress();
                      }));
                    }, child:
                    Text(
                      'العنوان',
                      style: GoogleFonts.poppins(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    ),
                    const Spacer(),
                    const Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              InkWell(
                onTap: () {
                },
                child: Row(
                  children: [
                    Image.asset(
                      'images/book.png',
                      height: 24.h,
                      width: 24.w,
                    ),
                    SizedBox(width: 8.w),
                    TextButton(onPressed: (){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
                        return  MyBookUser();
                      }));
                    }, child:
                    Text(
                      'كتبي',
                      style: GoogleFonts.poppins(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    ),
                    const Spacer(),
                    const Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              InkWell(
                onTap: () {
                },
                child: Row(
                  children: [
                    Image.asset(
                      'images/logout.png',
                      height: 24.h,
                      width: 24.w,
                    ),
                    SizedBox(width: 8.w),
                    TextButton(onPressed: (){
                      showDialog(context: context, builder: (ctx){
                        return AlertDialog(
                          title: Text('تنبيه !'),
                          content: Text('هل انت متأكد من انك تريد تسجيل خروج ؟'),
                          actions: [

                            TextButton(onPressed: (){

                              Navigator.of(ctx).pop();

                            }, child: Text('لا'),),


                            TextButton(onPressed: (){
                              Navigator.of(ctx).pop();

                              FirebaseAuth.instance.signOut().then((value){
                                Navigator.push(context,MaterialPageRoute(builder: (context){
                                  return  LoginScreen();
                                }));
                              });



                            }, child: Text('نعم'),),

                          ],
                        );
                      });
                    }, child:
                    Text(
                      'تسجيل خروج',
                      style: GoogleFonts.poppins(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    ),
                    const Spacer(),
                    const Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
    );
  }
}
