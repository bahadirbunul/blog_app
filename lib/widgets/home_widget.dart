import 'package:blog_app/screens/detail_screen.dart';
import 'package:blog_app/widgets/categories_item.dart';
import 'package:blog_app/widgets/reusable_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final numbers = List.generate(10, (index) => '$index');

  Color iconColor = darkBlue;

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
            FaIcon(
              FontAwesomeIcons.solidComment,
              size: 16,
            ),
            SizedBox(
              width: 137,
            ),
            Text('Home',
                style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: darkBlue)),
          ]),
        ),
        Container(
          height: 145,
          width: double.infinity,
          child: ListView(
            padding: EdgeInsets.all(10),
            scrollDirection: Axis.horizontal,
            children: [
              categories('food', 'Food'),
              SizedBox(width: 10),
              categories('travel', 'Travel'),
              SizedBox(width: 10),
              categories('health', 'Health'),
              SizedBox(width: 10),
              categories('photo', 'Photography'),
              SizedBox(width: 10),
              categories('life', 'Lifestyle'),
              SizedBox(width: 10),
              categories('fashion', 'Fashion'),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(left: 10),
          child: Text(
            'Blog',
            style: GoogleFonts.roboto(
                color: darkBlue, fontSize: 16, fontWeight: FontWeight.bold),
            textAlign: TextAlign.start,
          ),
        ),
        SizedBox(
          height: 15,
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
