
import 'package:flutter/material.dart';
import '/theme/colors/light_colors.dart';

class MyTextField extends StatelessWidget {
  final String label;
  final int maxLines;
  final int minLines;
  final Icon icon;
  MyTextField({required this.label, this.maxLines = 1, this.minLines = 1,   required this.icon});

  @override
  Widget build(BuildContext context) {
    return TextField(
      
      style: TextStyle(color: Colors.black),
      minLines: minLines,
      maxLines: maxLines,
      decoration: InputDecoration(
        suffixIcon: icon == null ? null: icon,
          labelText: label,
          labelStyle: TextStyle(color: LightColors.kDarkBlue,fontWeight: FontWeight.bold),
          
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          border:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.black))),
    );
  }
}
