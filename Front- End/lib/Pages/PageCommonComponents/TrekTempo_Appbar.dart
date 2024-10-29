import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TrekTempo_Appbar extends StatelessWidget implements PreferredSizeWidget {
  const TrekTempo_Appbar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        'TrackTempo',
        style: GoogleFonts.lobster(
            fontSize: 30,
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
      ),
      backgroundColor: Colors.black.withOpacity(0.2),
      elevation: 0,
      leading: Container(
        padding:const EdgeInsets.all(4.0),
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