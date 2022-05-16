import 'package:blog_app/screens/detail_screen.dart';
import 'package:blog_app/screens/home_screen.dart';
import 'package:blog_app/widgets/home_widget.dart';
import 'package:blog_app/widgets/reusable_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class Favourite extends StatefulWidget {
  const Favourite({Key? key}) : super(key: key);

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  Color iconColor = Colors.red;
  List favorites = [];
  @override
  Widget build(BuildContext context) {
    return Container(
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
            Text('My Favorites',
                style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: darkBlue)),
          ]),
        ),
        Expanded(
          child: GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (context, index) {
              final item = numbers[index];
              return buildNumber(item);
            },
            itemCount: numbers.length,
          ),
        )
      ]),
    );
  }

  Widget buildNumber(String item) => Container(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
        child: GridTile(
            child: InkWell(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Detail()));
          },
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'images/$item.jpg',
                  width: 174,
                  height: 174,
                ),
              ),
              Positioned(
                top: 15,
                left: 145,
                child: InkWell(
                  onTap: () {},
                  child: Icon(
                    Icons.favorite,
                    color: iconColor,
                  ),
                ),
              ),
              Positioned(
                top: 130,
                child: Container(
                  width: 174,
                  height: 56,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(20))),
                  child: Center(
                      child: Text(
                    'Article: $item',
                    style: GoogleFonts.roboto(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: darkBlue),
                  )),
                ),
              )
            ],
          ),
        )),
      ));
}
