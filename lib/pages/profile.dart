import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:treat_hisabkhana/main.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:treat_hisabkhana/widgets/loader.dart';
import 'package:timeago/timeago.dart' as timeago;

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);
  late String profileId;

  Profile.fromProfile({required this.profileId});

  @override
  _ProfileState createState() => _ProfileState(profileId: this.profileId);
}

class _ProfileState extends State<Profile> {
  late String profileId;
  late String image;
  late String username;
  late String bio;
  late String name;
  late String email;
  late Timestamp joinDate = Timestamp(0, 0);
  bool loading = false;

  _ProfileState({required this.profileId});

  @override
  void initState() {
    super.initState();
    //EXTRA CODE TO FETCH DATA OF THE USER
    getProfileData();
  }

  getProfileData() async {
    setState(() {
      loading = true;
    });
    await usersRef.doc(profileId).get().then((value) {
      setState(() {
        image = value.get('photoUrl');
        name = value.get('name');
        username = value.get('username');
        bio = value.get('bio');
        email = value.get('email');
        joinDate = value['timestamp'];
        loading = false;
      });
    });
  }

  backToDashboard(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromRGBO(230, 234, 241, 1),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // SizedBox(
                //   width: size.width * 0.03,
                // ),
                IconButton(
                  onPressed: () => backToDashboard(context),
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 30,
                  ),
                ),
                Text(
                  "Profile",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                IconButton(
                  onPressed: () => {},
                  icon: Icon(
                    Icons.settings,
                    size: 30,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 50,
                  width: 200,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 30,
                        spreadRadius: 20,
                        color: Colors.black26,
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(25),
                  padding:
                      EdgeInsets.only(top: 25, bottom: 25, left: 15, right: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          loading
                              ? circularProgress(context)
                              : Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      width: 115,
                                      height: 115,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Color.fromRGBO(55, 106, 237, 1),
                                            Color.fromRGBO(73, 176, 226, 1),
                                            Color.fromRGBO(156, 236, 251, 1),
                                          ],
                                          begin: Alignment.bottomLeft,
                                          end: Alignment.topRight,
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(42),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 110,
                                      width: 110,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(42),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image:
                                              CachedNetworkImageProvider(image),
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(42),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                          Container(
                            padding: EdgeInsets.only(left: 5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '@$username',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color.fromRGBO(45, 47, 121, 1),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  '$name',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color.fromRGBO(45, 47, 121, 1),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Joined ${timeago.format(joinDate.toDate())}',
                                  //'${joinDate.toString()}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color.fromRGBO(45, 47, 121, 1),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '$email',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color.fromRGBO(45, 47, 121, 1),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      bio != ""
                          ? Container(
                              padding: EdgeInsets.only(top: 25),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "About Me",
                                    style: TextStyle(
                                      fontSize: 22,
                                      color: Color.fromRGBO(45, 47, 121, 1),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    bio,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Color.fromRGBO(45, 47, 121, 1),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 80,
                                        width: 100,
                                        margin: EdgeInsets.only(top: 25),
                                        decoration: BoxDecoration(
                                          color: Color.fromRGBO(33, 81, 205, 1),
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(15),
                                            topLeft: Radius.circular(15),
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "25",
                                              style: TextStyle(
                                                fontSize: 30,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              "Treats",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 80,
                                        width: 100,
                                        margin: EdgeInsets.only(top: 25),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "4.5",
                                              style: TextStyle(
                                                fontSize: 30,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              "Rating",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 80,
                                        width: 100,
                                        margin: EdgeInsets.only(top: 25),
                                        decoration: BoxDecoration(
                                          color: Color.fromRGBO(33, 81, 205, 1),
                                          borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(15),
                                            topRight: Radius.circular(15),
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "130",
                                              style: TextStyle(
                                                fontSize: 30,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              "Connections",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          : Text(""),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
