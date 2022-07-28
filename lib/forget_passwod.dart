import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Utils.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(children: [
          SizedBox(
            height: 100,
          ),
          Container(
            width: w,
            height: h,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/2.jpg"),
                  fit: BoxFit.cover //fit the container

                  ),
            ),
          ),
          Column(children: [
            Container(
                width: w,
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: Form(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 10,
                              offset: Offset(1, 1),
                            )
                          ],
                        ),
                        child: TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white70, width: 1)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              hintText: "Email",
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white70, width: 1))),
                        ),
                      ),
                      SizedBox(
                        height: 80,
                      ),
                      Center(
                          child: ElevatedButton(

                              onPressed: () {
                                resetPassword();
                              },
                              child: Text("Reset Password")))
                    ]))),
          ])
        ]),
      ),
    );
  }

  Future resetPassword() async {

    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
      Utils.showSnackBar("Password Reset Email sent");

      Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      print(e);
      print("cvcccccccccvcv");
      Utils.showSnackBar(e.message);
      Navigator.of(context).pop();
    }
  }
}
