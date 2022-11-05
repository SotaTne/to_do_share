import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInDemo extends StatefulWidget {
  const SignInDemo({Key? key}) : super(key: key);

  @override
  State<SignInDemo> createState() => _SignInDemoState();
}

class _SignInDemoState extends State<SignInDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(100),
        child: Center(
          child: Column(
            children: [
              TextButton(
                child: const Text('log in with google'),
                onPressed: () {
                  try {
                    signInWithGoogle();
                  } catch (error) {
                    print(error);
                  }
                },
              ),
              TextButton(
                child: const Text('log out'),
                onPressed: () async {
                  await GoogleSignIn().disconnect();

                  FirebaseAuth.instance.signOut();
                },
              ),
              TextButton(
                child: const Text('check'),
                onPressed: () {
                  print(
                      'have user : ${FirebaseAuth.instance.currentUser != null}');
                  if (FirebaseAuth.instance.currentUser != null) {
                    print(FirebaseAuth.instance.currentUser!.uid);
                  } else {
                    print('not log in');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );
  print('accessToken : ${googleAuth?.accessToken}');
  //print('email : ${FirebaseAuth.instance.currentUser!.email}');
  //print('displayName : ${FirebaseAuth.instance.currentUser!.displayName}');
  //print('uid : ${FirebaseAuth.instance.currentUser!.uid}');
  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}

Future<void> sign_out() async {
  await GoogleSignIn().disconnect();
  FirebaseAuth.instance.signOut();
}
