import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TrekTempo_Appbar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'TrekTempo',
        style: TextStyle(
          fontFamily: 'ShortBaby',
          fontSize: 30,
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Container(
        padding:EdgeInsets.all(4.0),
        decoration: const BoxDecoration(
          

        ),
      
        child: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}