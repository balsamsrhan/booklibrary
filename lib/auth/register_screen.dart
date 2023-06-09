import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Models/Helpers.dart';
import '../Firebase/fb_cotroller_auth.dart';
import '../widgtes/app_button.dart';
import '../widgtes/app_text_field.dart';
import 'PhoneAuth.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with Helpers{
  DatabaseReference? dbRef;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    dbRef = FirebaseDatabase.instance.ref().child('Users');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  bool obscure = true;
  bool obscure2 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                    'مرحبا ، قم بالتسجيل للمتابعة!',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 40.h),
                ],
              ),
            ),
            Expanded(
              child: Container(
                // decoration: BoxDecoration(
                //   color: Colors.white,
                //   borderRadius: BorderRadius.only(
                //     topLeft: Radius.circular(50.r),
                //     topRight: Radius.circular(50.r),
                //   ),
                // ),
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  children: [
                    SizedBox(height: 40.h),
                    AppTextField(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(10),
                        child: SvgPicture.asset('images/profile.svg'),
                      ),
                      textEditingController: _nameController,
                      hintText: "ادخل اسمك بالكامل ",
                      keyboardType: TextInputType.text,
                    ),
                    SizedBox(height: 20.h),
                    AppTextField(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(10),
                        child: SvgPicture.asset('images/email.svg'),
                      ),
                      textEditingController: _emailController,
                      hintText: 'أدخل عنوان البريد الالكتروني',
                      keyboardType: TextInputType.emailAddress,
                    ),
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
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    AppTextField(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(10),
                        child: SvgPicture.asset('images/pass.svg'),
                      ),
                      textEditingController: _confirmPasswordController,
                      hintText: 'تأكيد كلمة المرور',
                      keyboardType: TextInputType.phone,
                      obscure: obscure2,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            obscure2 = !obscure2;
                          });
                        },
                        icon: Icon(
                          obscure2
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    AppButton(
                      onPress: () async => await _performRegister(),
                      //Navigator.pushReplacementNamed(context, '/bn_screen');
                      text: 'الاشتراك',
                      buttonColor: const Color(0XFFC19A6B),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'أو المتابعة بواسطة :',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    SizedBox(height: 30.h),
                    Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('images/google.svg'),
                          SizedBox(width: 15.w , height: 10.h),
                          TextButton(
                            onPressed: () {
                              /*  Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => LoginPage(),
                                ),
                              );*/
                            },
                            child: Text(
                              'قم بتسجيل الدخول باستخدام جوجل',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 25.h),
                    Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('images/call.svg'),
                          SizedBox(width: 10.w),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Phones()));
                            },
                            child:Text(
                              'قم بتسجيل الدخول باستخدام رقم الهاتف',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'لديك حساب؟',
                          style: GoogleFonts.poppins(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 30.h,),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/login_screen');
                          },
                          child: Text(
                            'سجل الدخول',
                            style: GoogleFonts.poppins(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> _performRegister() async {
    if (_checkData()) {
      await _register();
    }
  }

  bool _checkData() {
    if (_nameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty
    ) {
      return true;
    }
    showSnackBar(context, message: 'يجب ادخال بيانات !', error: true);
    return false;
  }

  _register() async {
    bool response = await FBAuthController().newAccount(email: _emailController.text,password: _passwordController.text);
    if(response){
      Navigator.pushReplacementNamed(context, '/login_screen');
      Map<String,String> dataSave = {
        'id' : _firebaseAuth.currentUser!.uid,
        'name' : _nameController.text,
        'email' : _emailController.text,
        'password' : _passwordController.text,
      };
      dbRef!.push().set(dataSave);
    }else {
      showSnackBar(
          context,
          message: "هناك خطأ ما !",
          error: true
      );
    }
  }
}
