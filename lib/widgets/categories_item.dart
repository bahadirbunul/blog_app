import 'package:blog_app/widgets/reusable_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

Widget categories(String imgName, String name) {
  return Column(
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(
          'images/$imgName.jpg',
          fit: BoxFit.contain,
          width: 164,
          height: 92,
        ),
      ),
      SizedBox(height: 5),
      Text(
        '$name',
        style: GoogleFonts.roboto(color: darkBlue, fontSize: 12),
      )
    ],
  );
}