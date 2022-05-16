import 'dart:math';

import 'package:blog_app/screens/home_screen.dart';
import 'package:blog_app/widgets/reusable_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Detail extends StatefulWidget {
  const Detail({Key? key}) : super(key: key);

  @override
  State<Detail> createState() => _DetailState();
}

final numbers = List.generate(10, (index) => '$index');

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(children: [
            Container(
              height: 48,
              width: double.infinity,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      offset: const Offset(0, 10),
                      blurRadius: 5.0,
                      spreadRadius: 0)
                ],
              ),
              child: Row(children: [
                Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 20,
                  ),
                ),
                SizedBox(
                  width: 110,
                ),
                Text('Article Details',
                    style: GoogleFonts.roboto(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: darkBlue)),
              ]),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                ),
                itemBuilder: (context, index) {
                  final item = numbers[index];
                  return buildNumber(item);
                },
                itemCount: 1,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

Widget buildNumber(String item) => Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              'images/$item.jpg',
              width: 250,
              height: 250,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 20),
          child: Text('Article $item',
              style: GoogleFonts.roboto(
                  fontSize: 16, fontWeight: FontWeight.bold, color: darkBlue)),
        )
      ],
    );
