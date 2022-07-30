// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginInput extends StatelessWidget {
  LoginInput({
    Key? key,
    required this.myController,
    required this.myHintText,
    required this.myIcon,
    required this.myKeyboardType,
  }) : super(key: key);

  TextEditingController myController = TextEditingController();
  String myHintText;
  Icon myIcon;
  TextInputType myKeyboardType;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: TextField(
          cursorColor: Colors.white,
          keyboardType: myKeyboardType,
          controller: myController,
          decoration: InputDecoration(
            prefixIcon: myIcon,
            focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                borderSide: BorderSide(color: Colors.white)),
            filled: true,
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25))),
            hintText: myHintText,
            hintStyle: GoogleFonts.overpass(
                fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ));
  }
}
