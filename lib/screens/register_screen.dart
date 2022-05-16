import 'package:blog_app/screens/home_screen.dart';
import 'package:blog_app/widgets/reusable_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _rePasswordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: SafeArea(
        child: Scaffold(
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
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
                child: Center(
                    child: Text('Sign Up',
                        style: GoogleFonts.roboto(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: darkBlue))),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: Column(
                      children: [
                        personLogoWidget(),
                        SizedBox(height: 20),
                        reusableTextField(
                            'Email', Icons.email, false, _emailTextController),
                        SizedBox(height: 15),
                        reusableTextField('Password', Icons.lock, true,
                            _passwordTextController),
                        SizedBox(height: 15),
                        reusableTextField('Re-Password', Icons.lock, true,
                            _rePasswordTextController),
                        SizedBox(height: 20),
                        loginAndRegisterButton(context, false, 'Register', () {
                          if (_passwordTextController.text ==
                              _rePasswordTextController.text) {
                            FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                    email: _emailTextController.text,
                                    password: _passwordTextController.text)
                                .then((value) {
                              print('Created New Account');
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen()));
                            }).onError((error, stackTrace) {
                              print('Error ${error.toString()}');
                            });
                          } else {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: Text('Error'),
                                      content: Text('Passwords do not match!'),
                                    ));
                          }
                        }),
                        SizedBox(height: 0),
                        loginAndRegisterButton(context, true, 'Login', () {}),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
