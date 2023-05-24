import 'package:booklibrary/models/Helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Firebase/fb_cotroller_auth.dart';
import '../widgtes/app_button.dart';
import '../widgtes/app_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with Helpers{
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool obscure = true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          children: [
            SizedBox(height: 30.h),
            Text(
              'مرحبًا',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 24.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            Text(
              'مرحبا ، سجل الدخول للمتابعة!',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade500,
              ),
            ),
            SizedBox(height: 30.h),
        AppTextField(
             textEditingController: _emailController,
             hintText: 'أدخل عنوان البريد الالكتروني',
            prefixIcon: Padding(
              padding: const EdgeInsets.all(10),
              child: SvgPicture.asset('images/email.svg'),
            ),
          keyboardType: TextInputType.emailAddress,
            // only accept letters from a to z
            //FilteringTextInputFormatter(RegExp(r'[a-zA-Z]'), allow: true)
        ),
            // AppTextField(
            //   prefixIcon: Padding(
            //     padding: const EdgeInsets.all(10),
            //     child: SvgPicture.asset('images/email.svg'),
            //   ),
            //
            //   textEditingController: _emailController,
            //   hintText: 'أدخل عنوان البريد الالكتروني',
            //   keyboardType: TextInputType.emailAddress,
            // ),
            SizedBox(height: 20.h),
            AppTextField(
              prefixIcon: Padding(
                padding: const EdgeInsets.all(10),
                child: SvgPicture.asset('images/pass.svg'),
              ),
              textEditingController: _passwordController,
              hintText: 'أدخل كلمة المرور',
              keyboardType: TextInputType.phone,
              obscure: obscure,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    obscure = !obscure;
                  });
                },
                icon: Icon(
                  obscure
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                ),
              ),
            ),
            SizedBox(height: 20.h),
            AppButton(
              onPress: ()async => await _performLogin(),
              text: 'تسجيل الدخول',
              buttonColor: const Color(0XFFC19A6B),
            ),
            SizedBox(height: 40.h),
            Text(
              'أو المتابعة بواسطة حساب التواصل الاجتماعي',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade500,
              ),
            ),
            SizedBox(height: 30.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('images/google.svg'),
                SizedBox(width: 10.w),
                Text(
                  'قم بتسجيل الدخول باستخدام جوجل',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 25.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('images/facebook.svg'),
                SizedBox(width: 10.w),
                Text(
                  'قم بتسجيل الدخول باستخدام الفيسبوك',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 40.h),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Text(
            //       'ليس لديك حساب؟',
            //       style: GoogleFonts.poppins(
            //         fontSize: 15.sp,
            //         fontWeight: FontWeight.w500,
            //         color: Colors.black,
            //       ),
            //     ),
            //     TextButton(
            //       onPressed: () {
            //         Navigator.pushReplacementNamed(context, '/register_screen');
            //       },
            //       child: Text(
            //         'إشتراك',
            //         style: GoogleFonts.poppins(
            //           fontSize: 15.sp,
            //           fontWeight: FontWeight.w500,
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
  Future<void> _performLogin() async {
    if (_checkData()) {
      await _login();
    }
  }

  bool _checkData() {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(context, message: 'يجب ادخال بيانات !', error: true);
    return false;
  }

  _login() async {
    bool response = await FBAuthController().login(context:context,email: _emailController.text,
        password: _passwordController.text);
    if(response){
      Navigator.pushReplacementNamed(context, '/bn_screen');
    }else {
      showSnackBar(
          context,
          message: "هناك خطأ ما !",
          error: true
      );
    }
  }
}
