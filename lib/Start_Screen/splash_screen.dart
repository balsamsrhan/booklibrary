import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, '/onboarding_screen');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children:[
        Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           Image.asset('images/splach.png'),
            Text(
          'مكتبة نون',
              style: GoogleFonts.poppins(
                fontSize: 30.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    ],
    );
  }
}
