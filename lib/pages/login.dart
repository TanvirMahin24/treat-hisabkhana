import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:treat_hisabkhana/widgets/login_form.dart';
import 'package:treat_hisabkhana/widgets/signup_form.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool loginSelected = true;

  selectFunc({login}) {
    setState(() {
      loginSelected = login;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(230, 234, 241, 1),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .25,
              child: const Center(
                child: Text(
                  "Treat\nHisabKhana",
                  style: TextStyle(
                    fontSize: 28,
                    color: Color.fromRGBO(13, 37, 60, 1),
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * .75,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.08,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                          ),
                          child: GestureDetector(
                            onTap: () => selectFunc(login: true),
                            child: Text(
                              "LOGIN",
                              style: TextStyle(
                                color: Colors.white
                                    .withOpacity(loginSelected ? 1 : 0.3),
                                fontSize: 24,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                          ),
                          child: GestureDetector(
                            onTap: () => selectFunc(login: false),
                            child: Text(
                              "SIGN UP",
                              style: TextStyle(
                                color: Colors.white
                                    .withOpacity(loginSelected ? 0.3 : 1),
                                fontSize: 24,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * .67,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(35),
                      ),
                    ),
                    child:
                        loginSelected ? const LoginForm() : const SignupForm(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
