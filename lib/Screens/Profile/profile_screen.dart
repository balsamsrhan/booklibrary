import 'package:flutter/material.dart';
import 'components/body.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}
class _ProfileScreenState extends State<ProfileScreen> {
  static String routeName = "/profile";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}

