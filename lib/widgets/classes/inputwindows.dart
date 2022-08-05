// ignore_for_file: must_be_immutable
import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginInput extends StatelessWidget {
  LoginInput({
    Key? key,
    required this.myController,
    required this.myHintText,
    required this.myPrefixIcon,
    required this.myKeyboardType,
    this.isTextObscured = false,
    this.mySuffIcon,
  }) : super(key: key);

  TextEditingController myController = TextEditingController();
  String myHintText;
  Icon myPrefixIcon;
  TextInputType myKeyboardType;
  AnimatedIconButton? mySuffIcon;
  bool isTextObscured;

//////////////////////////////////

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: TextField(
          obscureText: isTextObscured,
          textInputAction: TextInputAction.next,
          style: GoogleFonts.overpass(fontWeight: FontWeight.bold),
          keyboardType: myKeyboardType,
          controller: myController,
          decoration: InputDecoration(
            suffixIcon: mySuffIcon,
            prefixIcon: myPrefixIcon,
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            filled: true,
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            hintText: myHintText,
            hintStyle: GoogleFonts.overpass(fontWeight: FontWeight.bold),
          ),
        ));
  }
}
