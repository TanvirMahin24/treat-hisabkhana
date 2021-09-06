import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:treat_hisabkhana/main.dart';
import 'package:treat_hisabkhana/pages/homepage.dart';
import 'package:treat_hisabkhana/pages/profile.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late String userImg = "";
  @override
  void initState() {
    super.initState();
    getUserData();
  }

  getUserData() async {
    var res = await usersRef.doc(currentUser!.uid).get();

    setState(() {
      userImg = res['photoUrl'];
    });
  }

  logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.push(context, MaterialPageRoute(builder: (ctx) => Home()));
  }

  profilePage(BuildContext context) {
    FirebaseAuth.instance.signOut();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => Profile.fromProfile(
          profileId: currentUser!.uid,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 100),
        child: Column(
          children: [
            IconButton(
              onPressed: () => logout(),
              icon: Icon(Icons.logout),
            ),
            userImg == ""
                ? Text("")
                : GestureDetector(
                    onTap: () => profilePage(context),
                    child: Image(
                      image: NetworkImage(userImg),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
