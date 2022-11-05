import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Sign_In/google_sign_in.dart';
import '../main.dart';

class UserBody extends StatefulWidget {
  const UserBody({Key? key}) : super(key: key);

  @override
  State<UserBody> createState() => _UserBodyState();
}

class _UserBodyState extends State<UserBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextButton(
            child: const Text('log out'),
            onPressed: () {
              if (FirebaseAuth.instance.currentUser != null) {
                sign_out().then((value) {
                  print('restart');
                  main();
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/home', ModalRoute.withName('/home'));
                });
              }
              // ignore: await_only_futures
            },
          ),
        ],
      ),
    );
  }
}
