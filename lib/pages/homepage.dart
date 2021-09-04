import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:treat_hisabkhana/main.dart';
import 'package:treat_hisabkhana/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './dashboard.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isAuth = false;

  @override
  void initState() {
    super.initState();

    auth.authStateChanges().listen((User? user) {
      if (user == null) {
        setState(() {
          isAuth = false;
        });
        print('User is currently signed out!');
      } else {
        setState(() {
          isAuth = true;
        });
        currentUser = user;
        print(user.uid);
        print(user.displayName);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const Dashboard()));
      }
    });
  }

  nextClickFunc(BuildContext ctx) {
    if (isAuth) {
      //ROUTE DASHBOARD
    } else {
      //ROUTE LOGIN
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(230, 234, 241, 1),
      body: isAuth
          ? Dashboard()
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            Container(
                              margin: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(.1),
                                    blurRadius: 10,
                                    spreadRadius: 8,
                                    offset: const Offset(5, 5),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(35),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(28),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width * .2,
                                  height: 150,
                                ),
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(24),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * .2,
                                height: 150,
                                child: const Image(
                                  image: AssetImage('images/intro/2.jpg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Stack(
                          children: [
                            Container(
                              margin: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(.1),
                                    blurRadius: 10,
                                    spreadRadius: 8,
                                    offset: const Offset(5, 5),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(35),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(28),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width * .5,
                                  height: 150,
                                ),
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(24),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * .5,
                                height: 150,
                                child: const Image(
                                  image: AssetImage('images/intro/1.jpg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            Container(
                              margin: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(.1),
                                    blurRadius: 10,
                                    spreadRadius: 8,
                                    offset: const Offset(5, 5),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(35),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(28),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width * .5,
                                  height: 150,
                                ),
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(24),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * .5,
                                height: 150,
                                child: const Image(
                                  image: AssetImage('images/intro/3.jpg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Stack(
                          children: [
                            Container(
                              margin: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(.1),
                                    blurRadius: 10,
                                    spreadRadius: 8,
                                    offset: const Offset(5, 5),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(35),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(28),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width * .2,
                                  height: 150,
                                ),
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(24),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * .2,
                                height: 150,
                                child: const Image(
                                  image: AssetImage('images/intro/4.jpg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 300,
                    padding: const EdgeInsets.all(30),
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  "Treat\nHisabKhana",
                                  style: TextStyle(
                                    fontSize: 28,
                                    color: Color.fromRGBO(13, 37, 60, 1),
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                                Image(
                                  image:
                                      AssetImage('images/intro/LogoTrans.png'),
                                  height: 100,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const Text(
                              "Manage all the treats in one place.",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () => nextClickFunc(context),
                              child: const Text(
                                "Lets Start",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                  primary: Theme.of(context).primaryColor),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
