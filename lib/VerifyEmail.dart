import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled3/Utils.dart';
import 'package:untitled3/glass.dart';
import 'package:untitled3/main.dart';
import 'package:untitled3/sinup.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({Key? key}) : super(key: key);

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  bool isEmailVerified = false;

  Timer? timer;
  bool canResend = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    print(isEmailVerified);
    if (!isEmailVerified) {
      sendVerificationEmail();
      timer = Timer.periodic(Duration(seconds: 3), (_) => checkEmailVerified());
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? Glass()
      : Scaffold(
          appBar: AppBar(
            title: Text("Verify Email.....!", style: TextStyle(fontSize: 24)),
          ),
          body: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 200,
                ),
                Text("Une verification est envoyée a votre Email....!",
                    style: TextStyle(fontSize: 20)),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    if (canResend) {
                      sendVerificationEmail();
                    }
                    ;
                  },
                  label: Text(
                    "Resent ",
                    style: TextStyle(fontSize: 24),
                  ),
                  icon: Icon(Icons.email),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  },
                  label: Text(
                    "Anuller. ",
                    style: TextStyle(fontSize: 24),
                  ),
                  icon: Icon(Icons.cancel),
                )
              ],
            ),
          ),
        );

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      setState(() {
        canResend = false;
      });
      await Future.delayed(Duration(seconds: 5));
      setState(() {
        canResend = true;
      });
    } catch (e) {
      Utils.showSnackBar(e.toString());
    }
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) {
      timer?.cancel();
    }
  }
}
