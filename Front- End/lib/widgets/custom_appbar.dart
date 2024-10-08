import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final bool isLeading;
  final bool isAction;
  final IconData leadingIcon;
  final IconData actionIcon;
  final Function() leadingOnPressed;
  final Function() actionOnPressed;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.isLeading,
    required this.isAction,
    required this.leadingIcon,
    required this.actionIcon,
    required this.leadingOnPressed,
    required this.actionOnPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      leading: isLeading
          ? IconButton(
              icon: Icon(leadingIcon, color: Colors.black),
              onPressed: leadingOnPressed,
            )
          : null,
      actions: isAction
          ? [
              IconButton(
                icon: Icon(actionIcon, color: Colors.black),
                onPressed: actionOnPressed,
              ),
            ]
          : null,
    );
  }
}