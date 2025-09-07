import 'package:flutter/material.dart';

class UiHelper {
  static Widget customButton({
    required VoidCallback callback,
    required String buttonName,
  }) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: callback,
        style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF3B3B3B)),
        child: Text(
          buttonName,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  static Widget customText({
    required String text,
    double fontSize = 16.0,
    FontWeight? fontWeight,
    Color? color,
  }) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color ?? Color(0xFF000000),
      ),
    );
  }
}
