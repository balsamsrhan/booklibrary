import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    Key? key,
    required this.textEditingController,
     this.hintText,
    required this.keyboardType,
    this.labelText,
    this.obscure = false,
    this.suffixIcon,
    this.prefixIcon,
    this.onChange,
    this.maxline = 1,
    this.borderColor = const Color(0XFFF4F2F2),
     this.shap,
  }) : super(key: key);

  final TextEditingController textEditingController;
  final int? maxline;
  final String? hintText;
  final String? labelText;
  final TextInputType keyboardType;
  final bool obscure;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final void Function(String x)? onChange;
  final Color borderColor;
  final RoundedRectangleBorder? shap;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: maxline,
      onChanged: onChange,
      obscureText: obscure,
      controller: textEditingController,
      keyboardType: keyboardType,
      style: GoogleFonts.poppins(),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0XFFF4F2F2),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        label: labelText != null ? Text(labelText!) : null,
        labelStyle: GoogleFonts.poppins(
          fontSize: 15.sp,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
        hintText: hintText,
        hintStyle: GoogleFonts.poppins(
          fontSize: 13.sp,
          fontWeight: FontWeight.w300,
          color: Colors.black,
        ),
        helperStyle: GoogleFonts.poppins(fontSize: 15.sp),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.r),
          borderSide: BorderSide(color: Colors.black, width: 1.0.w),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.r),
          borderSide: BorderSide(color:  Colors.black, width: 1.0.w),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.r),
          borderSide: BorderSide(color:  Colors.black, width: 1.0.w),
        ),
      ),
    );
  }
}
