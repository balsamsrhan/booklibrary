import 'package:booklibrary/auth/PhoneAuth.dart';
import 'package:booklibrary/models/Helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Firebase/fb_cotroller_auth.dart';
import '../Screens/constants.dart';
import '../Screens/phone.dart';
import '../widgtes/app_button.dart';
import '../widgtes/app_text_field.dart';
import '../widgtes/components/custom_surfix_icon.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with Helpers {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    createPrefs();
  }

  Future<void> createPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('user_id');
    await prefs.setString('user_id', _firebaseAuth.currentUser!.uid);
    print("login: ${prefs.getString('user_id')}");
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  String? conform_password;
  bool remember = false;
  final List<String?> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFDFCF),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 30.h),
                  Text(
                    'مرحبًا',
                    style: GoogleFonts.poppins(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'مرحبا ، سجل الدخول للمتابعة!',
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

                //  focusColor: Colors.white,
                    //add prefix icon
                    prefixIcon: Icon(
                      Icons.person_outline_rounded,
                      color: Colors.grey,
                    ),


                    hintText: "البريد الالكتروني",

                    //make hint text
                    // hintStyle: TextStyle(
                    //   color: Colors.grey,
                    //   fontSize: 16,
                    //   fontFamily: "verdana_regular",
                    //   fontWeight: FontWeight.w400,
                    // ),
                  keyboardType: TextInputType.emailAddress,
                  textEditingController: _emailController,
                    //create lable
                    labelText: 'البريد الالكتروني',
                    //lable style
                    // labelStyle: TextStyle(
                    //   color: Colors.grey,
                    //   fontSize: 16,
                    //   fontFamily: "verdana_regular",
                    //   fontWeight: FontWeight.w400,
                    // ),
                  ),

                    SizedBox(height: 20.h),
                    AppTextField(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(10),
                        child: SvgPicture.asset('images/pass.svg'),
                      ),
                      textEditingController: _passwordController,
                      hintText: 'أدخل كلمة المرور',
                      labelText: 'كلمة المرور',
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
                      onPress: () async => await _performLogin(),
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => LoginPage(),
                                ),
                              );
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
                    SizedBox(height: 40.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'ليس لديك حساب؟',
                          style: GoogleFonts.poppins(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, '/register_screen');
                          },
                          child: Text(
                            'إشتراك',
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
    bool response = await FBAuthController().login(
        context: context,
        email: _emailController.text,
        password: _passwordController.text);
    if (response) {
      Navigator.pushReplacementNamed(context, '/bn_screen');
    } else {
      showSnackBar(context, message: "هناك خطأ ما !", error: true);
    }
  }
}
