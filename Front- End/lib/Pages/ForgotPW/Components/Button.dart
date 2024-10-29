import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final EdgeInsetsGeometry padding;
  final OutlinedBorder? shape;
  final TextStyle textStyle;

  const Button({super.key, 
    required this.text,
    required this.onPressed,
    this.backgroundColor = Colors.blue,
    this.padding = const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
    this.shape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(18)),
    ),
    this.textStyle = const TextStyle(
      color: Colors.white,
      fontSize: 18,
    ),
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: padding,
        shape: shape,
      ),
      child: Text(
        text,
        style: textStyle,
      ),
    );
  }
}