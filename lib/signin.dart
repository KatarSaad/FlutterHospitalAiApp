import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled3/forget_passwod.dart';
import 'package:untitled3/glass.dart';
import 'package:untitled3/main.dart';
import 'Utils.dart';
import 'sinup.dart';
import 'UserManagement.dart';

class SignIn extends StatefulWidget {
  final VoidCallback onClickedSignup;

  const SignIn({Key? key, required this.onClickedSignup}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _emailController = TextEditingController();
  final _PassWordController = TextEditingController();
  String _role="";
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _PassWordController.dispose();


    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Stack(children: [

              Container(
                width: w,
                height: h ,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("images/pexels-shvets-production-7194896.jpg"),
                      fit: BoxFit.cover //fit the container

                  ),
                ),
              ),
            Column(children: [

              Container(
                  width: w,
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [SizedBox(height: 25,),
                        Text(
                          "Hello",
                          style: TextStyle(
                              fontSize: 70, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Sign into your acount",
                          style:
                              TextStyle(fontSize: 20, color: Colors.grey[500]),
                        ),
                        SizedBox(
                          height: 50,
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
                          child: TextField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              hintText: "Email",
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.transparent, width: 1)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.transparent, width: 1))),
                          ),
                        ),
                        SizedBox(
                          height: 14,
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
                          child: TextField(
                            controller: _PassWordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: "Mot de passe",
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.transparent, width: 1)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.transparent, width: 1))),
                          ),
                        ),
                      ])),
              SizedBox(height: 18),
              Container(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(),
                    ),
                    Expanded(
                        flex: 2,
                        child: GestureDetector(
                          onTap: () {
                            Get.to(ResetPassword());
                          },
                          child: Container(
                            child: Text(
                              "Forget Your PassWord?",
                              style: TextStyle(
                                  color: Colors.white60,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ))
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  SignIN();

                 
                },
                child: Container(
                  width: w / 2,
                  height: h * 0.1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    image: DecorationImage(
                        image: AssetImage("images/loginbtn.png"),
                        fit: BoxFit.cover //fit the container

                        ),
                  ),
                  child: Center(
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                          fontSize: 36,
                          color: Colors.white70,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: w * 0.2,
              ),
              GestureDetector(
                child: RichText(
                  text: TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = widget.onClickedSignup,
                      text: "Dont have an acount?",
                      style: TextStyle(color: Colors.white60, fontSize: 20),
                      children: [
                        TextSpan(
                            text: "Create",
                            style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold))
                      ]),
                ),
              )
            ]),
          ]),
        ));
  }

  Future SignIN() async {
    // final isValid = formKey.currentState!.validate();

    showDialog(
        context: context,
        builder: (context) => Center(
              child: CircularProgressIndicator(),
            ));

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _PassWordController.text.trim());
      String id = "";
      final user = await FirebaseAuth.instance.currentUser!;
      var colection =
      FirebaseFirestore.instance.collection("users").doc(user.uid);
      var result = await colection.get();
      if (result.exists) {
        Map<String, dynamic>? data = result.data();

        print(
            "Donnnnnneeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
        //print(role);
        setState(() {
          _role = data?["role"];
        });

      }



    } on FirebaseAuthException catch (e) {
      print(e);
      Utils.showSnackBar(e.message);
    }
    Get.to((){MyHomePage(title: "d");});
  }

}
