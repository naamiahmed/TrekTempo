import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TrekTempo_Appbar extends StatelessWidget implements PreferredSizeWidget {
  final bool showBackButton; // Add this line

  const TrekTempo_Appbar({super.key, this.showBackButton = true}); // Modify constructor

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
      leading: showBackButton // Modify this line
        ? IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        : null,
    );
  }
}