import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  User? _user;

  @override
  void initState() {
    super.initState();
    _auth.authStateChanges().listen((User? user) {
      setState(() {
        _user = user;
      });
    });
  }

  Future<void> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return; // User cancelled the sign-in

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);
    } catch (e) {
      print(e);
    }
  }

  Future<void> _signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Sign-In Example'),
      ),
      body: Center(
        child: _user == null
            ? ElevatedButton(
          onPressed: _signInWithGoogle,
          child: Text('Sign in with Google'),
        )
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_user!.photoURL != null)
              CircleAvatar(
                backgroundImage: NetworkImage(_user!.photoURL!),
                radius: 1,
              ),
            SizedBox(height: 20),
            Text('Hello, ${_user!.displayName}!'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _signOut,
              child: Text('Sign out'),
            ),
          ],
        ),
      ),
    );
  }
}
