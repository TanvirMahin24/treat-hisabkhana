import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:treat_hisabkhana/main.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String emailErrorText = "";
  bool passwordError = true;


  googleLogin(BuildContext context) async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
        Navigator.of(context).pop();
  }

  // fbLogin() async {
  //   final LoginResult loginResult = await fbSignin.login();

  //   // Create a credential from the access token
  //   final OAuthCredential facebookAuthCredential =
  //       FacebookAuthProvider.credential(loginResult.accessToken!.token);

  //   // Once signed in, return the UserCredential
  //   UserCredential userCredential = FirebaseAuth.instance
  //       .signInWithCredential(facebookAuthCredential) as UserCredential;
  //   return;
  // }

  // twitterLogin() {}

  submitForm(BuildContext context) {
    //Validation Logic
    bool isValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(emailController.text);
    bool isPassValid = passwordController.text.length >= 6;
    setState(() {
      emailErrorText = isValid ? "" : "Please Enter valid Email address!";
      passwordError = isPassValid;
    });
    if (!isValid || !isPassValid) {
      return;
    }

    Navigator.of(context).pop();

    //print("::::::::::::::::::SUBMIT:::::::::::::::");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          const Text(
            "Welcome back",
            style: TextStyle(
              color: Color.fromRGBO(13, 37, 60, 1),
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          const Text(
            "Login with your account",
            style: TextStyle(
              color: Color.fromRGBO(45, 67, 121, 1),
              fontSize: 18,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          TextField(
            controller: emailController,
            cursorColor: const Color.fromRGBO(24, 67, 121, 1),
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: "Email",
              errorText: emailErrorText == "" ? null : emailErrorText,
              labelStyle: const TextStyle(
                color: Color.fromRGBO(24, 67, 121, 1),
                fontSize: 16,
              ),
            ),
          ),
          TextField(
            keyboardType: TextInputType.visiblePassword,
            controller: passwordController,
            cursorColor: const Color.fromRGBO(24, 67, 121, 1),
            decoration: InputDecoration(
              labelText: "Password",
              errorText: passwordError ? null : "Password too short!",
              labelStyle: const TextStyle(
                color: Color.fromRGBO(24, 67, 121, 1),
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: 50,
                vertical: 5,
              ),
              primary: Theme.of(context).primaryColor,
            ),
            onPressed: () => submitForm(context),
            child: const Text(
              "Login",
              style: TextStyle(fontSize: 18),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.06,
          ),
          const Center(
            child: Text(
              'OR LOGIN WITH',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w200,
                color: Color.fromRGBO(24, 67, 121, 1),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap:()=> googleLogin(context),
                child: SvgPicture.asset(
                  'images/social/Google.svg',
                ),
              ),
              // SizedBox(
              //   width: MediaQuery.of(context).size.width * 0.07,
              // ),
              // GestureDetector(
              //   onTap: fbLogin,
              //   child: SvgPicture.asset(
              //     'images/social/Facebook.svg',
              //   ),
              // ),
              // SizedBox(
              //   width: MediaQuery.of(context).size.width * 0.07,
              // ),
              // GestureDetector(
              //   onTap: twitterLogin,
              //   child: SvgPicture.asset(
              //     'images/social/Twitter.svg',
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
