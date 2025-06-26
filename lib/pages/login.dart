import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:online_shopping/assets/images/app_imges.dart';
import 'package:online_shopping/assets/themes/themes.dart';
import 'package:online_shopping/hotelowner/owner_home.dart';
import 'package:online_shopping/pages/bottom_navigator.dart';

import 'package:online_shopping/pages/signup.dart';
import 'package:online_shopping/utils/database.dart';
import 'package:online_shopping/utils/shared_preferences.dart';

class LogIn extends StatefulWidget {
  String redirect;
  LogIn({required this.redirect, super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  String email = "", password = "", role = "", name = "", id = "";

  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  userLogin() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email!, password: password!);

      // Future addUserInfor(Map<String, dynamic> userInforMap, String id) async {
      //   return await FirebaseFirestore.instance
      //       .collection("users")
      //       .doc(id)
      //       .set(userInforMap);
      // }

      QuerySnapshot querySnapshot =
          await DatabaseMethods().getUserByEmail(email);
      name = "${querySnapshot.docs[0]['Name']}";
      id = "${querySnapshot.docs[0]['Id']}";
      role = "${querySnapshot.docs[0]['Role']}";
      await SharedPreferencesHelper().saveUserlName(name);
      await SharedPreferencesHelper().saveUserEmail(emailcontroller.text);
      await SharedPreferencesHelper().saveUserId(id);

      if (role == "owner") {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => OwnerHome()));
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => BottomNavigation()));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "No user found for that email",
              style: Themes.text500(18),
            )));
      } else if (e.code == "wrong-password") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "Password Provided is too weak",
              style: Themes.text500(18),
            )));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.only(top: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child: Image(
              image: AssetImage(AppImges.Login),
              height: 300,
              width: 300,
              fit: BoxFit.cover,
            )),
            Center(
              child: Text(
                "Log In",
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
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
            // SizedBox(
            //   height: 20.0,
            // ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Forgot password ?",
                    style: Themes.text500(14),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                if (emailcontroller != "" && passwordcontroller != "") {
                  setState(() {
                    email = emailcontroller.text.trim();
                    password = passwordcontroller.text.trim();
                  });
                  userLogin();
                }
              },
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 29, 111, 194),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                      child: Text(
                    'Login',
                    style: Themes.whiteTextStyle(18),
                  )),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
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
                                builder: (context) => SignUp(
                                      redirect: widget.redirect,
                                    )));
                      },
                      child: Text(
                        "SignUp",
                        style: Themes.normalText(18),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
