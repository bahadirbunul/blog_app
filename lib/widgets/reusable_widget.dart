import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class personLogoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.asset(
        'images/person.png',
        width: 174,
        height: 174,
      ),
    );
  }
}

Color darkBlue = Color.fromARGB(255, 41, 47, 59);
Color smokeGrey = Color.fromARGB(255, 196, 201, 210);

TextField reusableTextField(String text, IconData icon, bool isPasswordType,
    TextEditingController controller) {
  bool _isObscure = true;
  return TextField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    cursorColor: darkBlue,
    style: GoogleFonts.roboto(color: darkBlue),
    decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: smokeGrey,
        ),
        suffixIcon: isPasswordType
            ? IconButton(
                onPressed: () {
                  
                  _isObscure = !_isObscure;
                },
                icon:
                    Icon(_isObscure ? Icons.visibility : Icons.visibility_off))
            : null,
        labelText: text,
        labelStyle: GoogleFonts.roboto(color: smokeGrey, fontSize: 16),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: darkBlue),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: darkBlue),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: darkBlue),
        )),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}

Container loginAndRegisterButton(
    BuildContext context, bool isLogin, String text, Function onTap) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 65,
    margin: EdgeInsets.fromLTRB(0, 5, 0, 15),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16), border: Border()),
    child: ElevatedButton.icon(
      icon: isLogin
          ? Icon(Icons.login, color: Colors.white)
          : Icon(Icons.login, color: darkBlue),
      onPressed: (() {
        onTap();
      }),
      label: Text(
        isLogin ? text : text,
        style: isLogin
            ? GoogleFonts.roboto(
                fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)
            : GoogleFonts.roboto(
                fontSize: 16, color: darkBlue, fontWeight: FontWeight.bold),
      ),
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(width: 1, color: darkBlue))),
        backgroundColor: isLogin
            ? MaterialStateProperty.resolveWith((states) => darkBlue)
            : MaterialStateProperty.resolveWith((states) => Colors.white),
      ),
    ),
  );
}