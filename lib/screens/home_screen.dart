import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  final User firebaseUser = FirebaseAuth.instance.currentUser as User;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 100,
              height: 100,
              child: CircleAvatar(
                radius: 50.0,
                backgroundColor: Colors.transparent,
                //display the user profile image
                backgroundImage: NetworkImage(firebaseUser.photoURL as String),
              ),
            ),
            Text(
              // Obtaine display name of the current auth instance
              firebaseUser.displayName as String,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            MaterialButton(
              padding: EdgeInsets.all(10),
              color: Colors.green,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              child: Text(
                'LOG OUT',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              onPressed: () {
                // 	log out the current user upon pressing the logoun button
                AuthService().signOut();
              },
            ),
          ],
        ),
      ),
    );
  }
}
