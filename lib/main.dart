import 'package:booklibrary/Screens/addBook.dart';
import 'package:booklibrary/Screens/Order_Screen.dart';
import 'package:booklibrary/Start_Screen/onboarding_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'Screens/OtpPhoneScreen.dart';
import 'Screens/bottom_navigation.dart';
import 'Shared_Pref/Shard_Pref_Controller.dart';
import 'Start_Screen/splash_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'Start_Screen/welcome_screen.dart';
import 'auth/PhoneAuth.dart';
import 'auth/login_screen.dart';
import 'auth/register_screen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPrefController().initSharedPreferances();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('ar'),
            ],
            locale: const Locale('ar'),
            initialRoute: '/splash_screen',
            routes: {
              '/splash_screen': (context) => const SplashScreen(),
               '/onboarding_screen': (context) =>  OnboardingScreen(),
               '/welcom_screen': (context) =>  WelcomeScreen(),
                '/register_screen': (context) => RegisterScreen(),
               '/login_screen': (context) =>  LoginScreen(),
               '/home_screen': (context) => AddItem(),
              '/bn_screen': (context) => const BottomNavigationScreen(),
              '/upload_image_screen': (context) => Cart(),
              // '/book_screen': (context) => const BookScreen(),
            },
          );
        });
  }
}
