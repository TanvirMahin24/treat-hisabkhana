import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:treat_hisabkhana/main.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({Key? key}) : super(key: key);

  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordController2 = TextEditingController();
  String emailErrorText = "";
  String passwordError = "";
  String passwordError2 = "";
  String nameError = "";
  String usernameError = "";
  var showImg = "";

  @override
  void initState() {
    super.initState();
    //EXTRA CODE
  }

  googleLogin() async {
    //GOOGLE LOGIN
    final GoogleSignInAccount googleUser = await googleSignin.signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    //CREATE USER IN FIREBASE
    await usersRef.doc(userCredential.user!.uid).get().then((doc) {
      if (!doc.exists) {
        doc.reference.set({
          "username":
              userCredential.user!.displayName!.replaceAll(RegExp(r"\s+"), ""),
          "photoUrl": userCredential.user!.photoURL,
          "email": userCredential.user!.email,
          "name": userCredential.user!.displayName,
          "bio": '',
          "timestamp": DateTime.now(),
        });
      }
    });
  }

  // fbLogin() async {
  //   final LoginResult result = await FacebookAuth.instance.login();
  // if(result.status == LoginStatus.success){
  //   // Create a credential from the access token
  //   final OAuthCredential credential = FacebookAuthProvider.credential(result.accessToken!.token);
  //   // Once signed in, return the UserCredential
  //   print("::::::LOGIN FB DONE:::::");
  //   return await FirebaseAuth.instance.signInWithCredential(credential);

  // }

  // print("::::::LOGIN FB ${result.status.toString()}:::::");
  // print("::::::LOGIN FB FAIL:::::");
  // return null;
  // }

  // twitterLogin() {}

  submitForm() async {
    // Validation Logic
    bool isValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(emailController.text);
    bool isPassValid = passwordController.text.length >= 6;
    bool isNameValid = nameController.text.length >= 4;
    bool isUsernameValid =
        RegExp(r"^(?=[a-zA-Z0-9._]{8,20}$)(?!.*[_.]{2})[^_.].*[^_.]$")
            .hasMatch(usernameController.text);
    bool isPasswordMatched =
        passwordController.text == passwordController2.text;

    // Set state accroding to validation
    setState(() {
      emailErrorText = isValid ? "" : "Please Enter valid Email address!";
      passwordError = isPassValid ? "" : "Weak Password!";
      nameError = isNameValid ? "" : "Name must be at least 4 charecters!";
      usernameError = isUsernameValid ? "" : "Invalid Username!";
      passwordError2 = isPasswordMatched ? "" : "Password do not match!";
    });

    // Returning on validation fail
    if (!isValid ||
        !isPassValid ||
        !isNameValid ||
        !isUsernameValid ||
        !isPasswordMatched) {
      return;
    }

    // AUTHENTICATION FIREBASE
    try {
      await auth.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      // LOGIN
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // GET DEFAULT IMAGE
      var defaultImgUrl =
          await storageRef.child('default.jpg').getDownloadURL();

      // CREATE USER IN FIREBASE
      await usersRef.doc(userCredential.user!.uid).set({
        "username": usernameController.text,
        "photoUrl": defaultImgUrl,
        "email": emailController.text,
        "name": nameController.text,
        "bio": "",
        "timestamp": DateTime.now(),
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        setState(() {
          passwordError =
              isPassValid ? "" : "The password provided is too weak.";
        });
        return;
      } else if (e.code == 'email-already-in-use') {
        setState(() {
          emailErrorText =
              isValid ? "" : "The account already exists for that email.";
        });
        return;
      }
      return;
    } catch (e) {
      print(e);
    }
    //print("::::::::::::::::::SUBMIT:::::::::::::::");
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              "Welcome",
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
              "Create a new account",
              style: TextStyle(
                color: Color.fromRGBO(45, 67, 121, 1),
                fontSize: 18,
                fontWeight: FontWeight.normal,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            TextField(
              controller: nameController,
              cursorColor: const Color.fromRGBO(24, 67, 121, 1),
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Name",
                errorText: nameError == "" ? null : nameError,
                labelStyle: const TextStyle(
                  color: Color.fromRGBO(24, 67, 121, 1),
                  fontSize: 16,
                ),
              ),
            ),
            TextField(
              controller: usernameController,
              cursorColor: const Color.fromRGBO(24, 67, 121, 1),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "Username",
                errorText: usernameError == "" ? null : usernameError,
                labelStyle: const TextStyle(
                  color: Color.fromRGBO(24, 67, 121, 1),
                  fontSize: 16,
                ),
              ),
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
                errorText: passwordError == "" ? null : passwordError,
                labelStyle: const TextStyle(
                  color: Color.fromRGBO(24, 67, 121, 1),
                  fontSize: 16,
                ),
              ),
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
            ),
            TextField(
              keyboardType: TextInputType.visiblePassword,
              controller: passwordController2,
              cursorColor: const Color.fromRGBO(24, 67, 121, 1),
              decoration: InputDecoration(
                labelText: "Re-type Password",
                errorText: passwordError2 == "" ? null : passwordError2,
                labelStyle: const TextStyle(
                  color: Color.fromRGBO(24, 67, 121, 1),
                  fontSize: 16,
                ),
              ),
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
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
              onPressed: () => submitForm(),
              child: const Text(
                "Sign Up",
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            const Center(
              child: Text(
                'OR SIGN UP WITH',
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
                  onTap: googleLogin,
                  child: SvgPicture.asset(
                    'images/social/Google.svg',
                  ),
                ),
                // SizedBox(
                //   width: MediaQuery.of(context).size.width * 0.07,
                // ),
                // GestureDetector(
                //   onTap: ()=> fbLogin(),
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
      ),
    );
  }
}
