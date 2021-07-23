import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: ExactAssetImage('assets/images/logo.png'),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            Text("ClinicaMD", style: Theme.of(context).textTheme.headline1!.copyWith(fontSize: 25, fontWeight: FontWeight.bold)),
            SizedBox(height: 150),
            Text("Login with",
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: 25,
                    )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Gesture detector for facebook Login
                    GestureDetector(
                      onTap: () {
                        // Call facebook login methon
                        AuthService().signInWithFacebook();
                      },
                      child: Image(width: 50, image: AssetImage('assets/images/fb_logo.png')),
                    ),
                    SizedBox(width: 50),
                    // Gesture detector for the Google icon
                    GestureDetector(
                        onTap: () {
                          // Call the a method to sign in with Google
                          AuthService().signInWithGoogle();
                        },
                        child: Image(width: 55, image: AssetImage('assets/images/google_logo.png'))),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
