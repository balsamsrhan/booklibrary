import 'package:booklibrary/Screens/addBook.dart';
import 'package:booklibrary/Screens/order_screen.dart';
import 'package:booklibrary/Start_Screen/onboarding_screen.dart';
import 'package:booklibrary/Start_Screen/welcome_screen.dart';
import 'package:booklibrary/auth/login_screen.dart';
import 'package:booklibrary/auth/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'Screens/bottom_navigation.dart';
import 'Start_Screen/splash_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
               '/onboarding_screen': (context) => const OnboardingScreen(),
               '/welcome_screen': (context) =>  WelcomeScreen(),
                '/register_screen': (context) => RegisterScreen(),
               '/login_screen': (context) =>  LoginScreen(),
               '/home_screen': (context) => AddItem(),
              '/bn_screen': (context) => const BottomNavigationScreen(),
              '/upload_image_screen': (context) => OrderScreen(),
              // '/book_screen': (context) => const BookScreen(),
            },
          );
        });
  }
}
