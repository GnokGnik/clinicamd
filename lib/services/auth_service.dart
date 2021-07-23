import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../screens/home_screen.dart';
import '../screens/login_screen.dart';

class AuthService {
  //Determine if the user is authenticated and redirect accordingly
  handleAuthState() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            // user is authorozed hence redirect to home screen
            return HomePage(
              title: 'ClinicaMD Home',
            );
          } else
            // user not authorized hence redirect to login page
            return LoginPage(title: 'ClinicaMD Login');
        });
  }

  signOut() {
    FirebaseAuth.instance.signOut();
  }

  signInWithFacebook() async {
    final fb = FacebookLogin();
    // Log in
    final res = await fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);

    print("Loggin in to Facebook");
    print("Result:  $res.status");
    // Check result status
    switch (res.status) {
      case FacebookLoginStatus.success:
        // The user is suceessfully logged in
        // Send access token to server for validation and auth
        final FacebookAccessToken accessToken = res.accessToken as FacebookAccessToken;
        final AuthCredential authCredential = FacebookAuthProvider.credential(accessToken.token);
        final result = await FirebaseAuth.instance.signInWithCredential(authCredential);

        // Get profile data from facebook for use in the app
        final FacebookUserProfile profile = await fb.getUserProfile() as FacebookUserProfile;
        print('Hello, ${profile.name}! You ID: ${profile.userId}');

        // Get user profile image url
        final imageUrl = await fb.getProfileImageUrl(width: 100);
        print('Your profile image: $imageUrl');

        // fetch user email
        final email = await fb.getUserEmail();
        // But user can decline permission
        if (email != null) print('And your email is $email');

        break;

      case FacebookLoginStatus.cancel:
        // In case the user cancels the login process
        break;
      case FacebookLoginStatus.error:
        // Login procedure failed
        print('Error while log in: ${res.error}');
        break;
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    // Initiate the auth procedure
    final GoogleSignInAccount googleUser = await GoogleSignIn(scopes: <String>["email"]).signIn() as GoogleSignInAccount;

    // fetch the auth details from the request made earlier
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    // Create a new credential for signing in with google
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
