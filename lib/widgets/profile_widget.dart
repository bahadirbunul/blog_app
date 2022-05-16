import 'dart:io';

import 'package:blog_app/screens/home_screen.dart';
import 'package:blog_app/screens/login_screen.dart';
import 'package:blog_app/widgets/reusable_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File? image;

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemp = File(image.path);

      setState(() {
        this.image = imageTemp;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  final Set<Marker> _markers = {};
  late BitmapDescriptor mapMarker;

  @override
  void initState() {
    super.initState();
    setCustomMarker();
  }

  void setCustomMarker() async {
    mapMarker = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'images/marker.png');
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _markers.add(
        Marker(
            markerId: const MarkerId('id-1'),
            position: const LatLng(40.993154155319715, 29.06738134065946),
            icon: mapMarker,
            infoWindow: const InfoWindow(
                title: 'Internative', snippet: 'Business Place')),
      );
    });
  }

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
            const Padding(padding: const EdgeInsets.symmetric(horizontal: 10)),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeScreen()));
              },
              child: const Icon(
                Icons.arrow_back_ios,
                size: 20,
              ),
            ),
            const SizedBox(
              width: 135,
            ),
            Text('Profile',
                style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: darkBlue)),
          ]),
        ),
        Expanded(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: InkWell(
                    onTap: (() {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) => Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: Container(
                                      height: 275,
                                      width: 275,
                                      child: ClipRRect(
                                        child: image != null
                                            ? Image.file(
                                                image!,
                                                width: 174,
                                                height: 174,
                                                fit: BoxFit.cover,
                                              )
                                            : Image.asset(
                                                'images/person.png',
                                                width: 174,
                                                height: 174,
                                                fit: BoxFit.cover,
                                              ),
                                      ),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        15, 10, 10, 15),
                                    child: Row(
                                      children: [
                                        ElevatedButton.icon(
                                          icon: const Icon(Icons.logout),
                                          label: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                35, 20, 35, 20),
                                            child: Text(
                                              'Select',
                                              style: GoogleFonts.roboto(
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (context) => AlertDialog(
                                                          elevation: 0,
                                                          contentPadding:
                                                              const EdgeInsets
                                                                  .all(0),
                                                          content: Container(
                                                            height: 210,
                                                            width: 200,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20)),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(25),
                                                                  child: const Text(
                                                                      'Select a Picture'),
                                                                ),
                                                                // camera button
                                                                ElevatedButton
                                                                    .icon(
                                                                        onPressed:
                                                                            () {
                                                                          pickImage(
                                                                              ImageSource.camera);
                                                                        },
                                                                        style: ButtonStyle(
                                                                            shape:
                                                                                MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(16), side: BorderSide(width: 1, color: darkBlue))),
                                                                            backgroundColor: MaterialStateProperty.resolveWith((states) => darkBlue)),
                                                                        icon: const Icon(
                                                                          Icons
                                                                              .camera_alt,
                                                                          color:
                                                                              Colors.white,
                                                                          size:
                                                                              20,
                                                                        ),
                                                                        label: Padding(
                                                                          padding: const EdgeInsets.fromLTRB(
                                                                              60,
                                                                              20,
                                                                              80,
                                                                              20),
                                                                          child:
                                                                              Text(
                                                                            'Camera',
                                                                            style: GoogleFonts.roboto(
                                                                                fontSize: 16,
                                                                                color: Colors.white,
                                                                                fontWeight: FontWeight.bold),
                                                                          ),
                                                                        )),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                //gallery button
                                                                ElevatedButton
                                                                    .icon(
                                                                  onPressed:
                                                                      () {
                                                                    pickImage(
                                                                        ImageSource
                                                                            .gallery);
                                                                  },
                                                                  style: ButtonStyle(
                                                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                                                          borderRadius: BorderRadius.circular(
                                                                              16),
                                                                          side: BorderSide(
                                                                              width:
                                                                                  1,
                                                                              color:
                                                                                  darkBlue))),
                                                                      backgroundColor:
                                                                          MaterialStateProperty.resolveWith((states) =>
                                                                              Colors.white)),
                                                                  icon: Icon(
                                                                    Icons
                                                                        .browse_gallery,
                                                                    color:
                                                                        darkBlue,
                                                                    size: 20,
                                                                  ),
                                                                  label:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.fromLTRB(
                                                                            60,
                                                                            20,
                                                                            80,
                                                                            20),
                                                                    child: Text(
                                                                      'Gallery',
                                                                      style: GoogleFonts.roboto(
                                                                          fontSize:
                                                                              16,
                                                                          color:
                                                                              darkBlue,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ));
                                          },
                                          style: ButtonStyle(
                                              shape: MaterialStateProperty.all<
                                                      RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                      borderRadius: BorderRadius
                                                          .circular(16),
                                                      side: BorderSide(
                                                          width: 1,
                                                          color: darkBlue))),
                                              backgroundColor:
                                                  MaterialStateProperty
                                                      .resolveWith((states) =>
                                                          darkBlue)),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        ElevatedButton.icon(
                                          onPressed: () {
                                            setState(() {
                                              image = null;
                                            });
                                          },
                                          icon: const Icon(Icons.logout),
                                          label: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                35, 20, 32, 20),
                                            child: Text(
                                              'Remove',
                                              style: GoogleFonts.roboto(
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          style: ButtonStyle(
                                              shape: MaterialStateProperty.all<
                                                      RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                      borderRadius: BorderRadius
                                                          .circular(16),
                                                      side: BorderSide(
                                                          width: 1,
                                                          color: darkBlue))),
                                              backgroundColor:
                                                  MaterialStateProperty
                                                      .resolveWith((states) =>
                                                          darkBlue)),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ));
                    }),
                    child: Stack(children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(90),
                        child: image != null
                            ? Image.file(
                                image!,
                                width: 174,
                                height: 174,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                'images/person.png',
                                width: 174,
                                height: 174,
                                fit: BoxFit.cover,
                              ),
                      ),
                      Positioned(
                          right: 10,
                          top: 135,
                          child: Icon(
                            Icons.camera_alt,
                            size: 40,
                            color: darkBlue,
                          ))
                    ])),
              ),
              Container(
                width: 360,
                height: 150,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(16)),
                child: GoogleMap(
                    onMapCreated: _onMapCreated,
                    markers: _markers,
                    initialCameraPosition: const CameraPosition(
                        target: LatLng(40.993154155319715, 29.06738134065946),
                        zoom: 10)),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()));
                  },
                  icon: Icon(
                    Icons.logout,
                    color: darkBlue,
                  ),
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                              side: BorderSide(width: 1, color: darkBlue))),
                      backgroundColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.white)),
                  label: Padding(
                    padding: const EdgeInsets.fromLTRB(115, 20, 145, 20),
                    child: Text('Save',
                        style: GoogleFonts.roboto(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: darkBlue)),
                  )),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                  },
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                              side: BorderSide(width: 1, color: darkBlue))),
                      backgroundColor: MaterialStateProperty.resolveWith(
                          (states) => darkBlue)),
                  label: Padding(
                    padding: const EdgeInsets.fromLTRB(100, 20, 140, 20),
                    child: Text('Log Out',
                        style: GoogleFonts.roboto(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ))
            ],
          ),
        )
      ]),
    );
  }
}
