import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
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
                    SvgPicture.asset(
                      'images/person.svg',
                      height: 24.h,
                      width: 24.w,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'تغيير الاسم',
                      style: GoogleFonts.poppins(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    const Spacer(),
                    const Icon(Icons.arrow_forward_ios,
                    ),
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
                onTap: () {},
                child: Row(
                  children: [
                    Image.asset(
                      'images/location.png',
                      height: 24.h,
                      width: 24.w,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'العنوان',
                      style: GoogleFonts.poppins(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
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
                    Text(
                      'كتبي ',
                      style: GoogleFonts.poppins(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    const Spacer(),
                    const Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    Image.asset(
                      'images/logout.png',
                      height: 24.h,
                      width: 24.w,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'تسجيل خروج',
                      style: GoogleFonts.poppins(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
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
    );
  }
}
