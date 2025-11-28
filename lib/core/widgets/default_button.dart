import 'package:flutter/material.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  height = 50.0,
  @required function,
  required String text,
  bool isUpperCase = true,
  double fontSize = 14,
  double radius = 20.0}) =>
    Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius,),
        color: background,),
      child: MaterialButton(
        onPressed: function,
        child: Center(
          child: Text(
            isUpperCase ? text.toUpperCase() : text,
            style: TextStyle(
                color: Colors.white,
                fontSize: fontSize
            ),
          ),
        ),
      ),
    );


Widget defaultElevatedButton({
  double width = double.infinity,
  double height = 40.0,
  Color background = Colors.blue,
  double radius = 20.0,
  required VoidCallback function,
  required String text,
  IconData? icon, // optional icon
  bool isUpperCase = true,
  double fontSize = 14,
  Color textColor = Colors.white,
  Color iconColor = Colors.white,
}) {
  return SizedBox(
    width: width,
    height: height,
    child: ElevatedButton.icon(
      onPressed: function,
      style: ElevatedButton.styleFrom(
        backgroundColor: background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12),
      ),
      icon: icon != null
          ? Icon(icon, color: iconColor, size: fontSize + 4)
          : const SizedBox.shrink(), // empty if no icon provided
      label: Text(
        isUpperCase ? text.toUpperCase() : text,
        style: TextStyle(
          color: textColor,
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}
