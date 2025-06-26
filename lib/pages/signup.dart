import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:online_shopping/assets/images/app_imges.dart';
import 'package:online_shopping/assets/themes/themes.dart';
import 'package:online_shopping/hotelowner/hotel_detail.dart';
import 'package:online_shopping/pages/bottom_navigator.dart';
import 'package:online_shopping/pages/login.dart';
import 'package:online_shopping/utils/database.dart';
import 'package:online_shopping/utils/shared_preferences.dart';
import 'package:random_string/random_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  String redirect;
  SignUp({required this.redirect, super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String email = "", password = "", name = "";
  TextEditingController namecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();

  registration() async {
    if (password != null &&
        namecontroller.text.trim() != "" &&
        emailcontroller.text.trim() != "") {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        String id = randomAlpha(10);
        Map<String, dynamic> userInforMap = {
          "Name": namecontroller.text,
          "Email": emailcontroller.text,
          "Password": passwordcontroller.text,
          "Id": id,
          'Role': widget.redirect == "owner" ? "owner" : "user",
        };
        await SharedPreferencesHelper().saveUserlName(namecontroller.text);
        await SharedPreferencesHelper().saveUserEmail(emailcontroller.text);
        await SharedPreferencesHelper().saveUserId(id);
        await DatabaseMethods().addUserInfor(userInforMap, id);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              "Registered Successfully!",
              style: Themes.text500(18),
            )));
        widget.redirect == "owner"
            ? Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HotelDetail()))
            : Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => BottomNavigation()));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "Password Provided is too weak",
                style: Themes.text500(18),
              )));
        } else if (e.code == "email-already-in-use") {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "Account Already exists",
                style: Themes.text500(18),
              )));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.only(top: 40),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Image(
                image: AssetImage(AppImges.SignUp),
                height: 300,
                width: 300,
                fit: BoxFit.cover,
              )),
              Center(
                child: Text(
                  "Sign Up",
                  style: Themes.normalText(25.0),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Center(
                child: Text(
                  "Please enter the details to continue...",
                  style: Themes.text500(18),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Text(
                  "Name",
                  style: Themes.normalText(18),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                    color: Color(0XFFECECF8),
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  controller: namecontroller,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.blue,
                    ),
                    hintText: "Enter your name",
                    // hintStyle:
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Text(
                  "Email",
                  style: Themes.normalText(18),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                    color: Color(0XFFECECF8),
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  controller: emailcontroller,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.blue,
                    ),
                    hintText: "Enter your email",
                    // hintStyle:
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Text(
                  "Password",
                  style: Themes.normalText(18),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                    color: Color(0XFFECECF8),
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  obscureText: true,
                  controller: passwordcontroller,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.password,
                      color: Colors.blue,
                    ),
                    hintText: "Enter your password",
                    // hintStyle:
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              GestureDetector(
                onTap: () {
                  if (namecontroller.text != "" &&
                      emailcontroller.text != "" &&
                      passwordcontroller.text != "") {
                    setState(() {
                      email = emailcontroller.text;
                      password = passwordcontroller.text;
                    });
                    registration();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.redAccent,
                      content: Text(
                        "Please fill in all fields",
                        style: Themes.whiteTextStyle(16),
                      ),
                    ));
                  }
                },
                child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 28, 146, 89),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                        child: Text(
                      'Sign Up',
                      style: Themes.whiteTextStyle(18),
                    )),
                  ),
                ),
              ),
              Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: Themes.text500(16),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LogIn(
                                      redirect: widget.redirect,
                                    )));
                      },
                      child: Text(
                        "LogIn",
                        style: Themes.normalText(18),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
