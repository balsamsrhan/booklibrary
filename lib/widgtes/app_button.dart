
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppButton extends StatelessWidget {
  final void Function() onPress;
  final String text;
  final Color? textColor;
  final Color? buttonColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Image? img;
  const AppButton({
    required this.onPress,
    required this.text,
    this.textColor,
    this.buttonColor,
    this.fontSize,
    this.fontWeight,
    this.img,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
        backgroundColor: HexColor("C19A6B"),
        padding: EdgeInsets.zero,
        maximumSize: Size(double.infinity, 55.h),
        minimumSize: Size(double.infinity, 55.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.r),
        ),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: fontSize ?? 15.sp,
          fontWeight: fontWeight ?? FontWeight.w400,
          color: textColor ?? Colors.white,
        ),
      ),
    );
  }
}
class HexColor extends Color {
  static int _getColor(String hex) {
    String formattedHex =  "FF" + hex.toUpperCase().replaceAll("#", "");
    return int.parse(formattedHex, radix: 16);
  }
  HexColor(final String hex) : super(_getColor(hex));
}