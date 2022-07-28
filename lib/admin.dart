import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled3/compte.dart';
import 'package:untitled3/historic.dart';
import 'package:untitled3/modifUser.dart';
import 'package:untitled3/pridicttion.dart';
import 'package:untitled3/qr.dart';
import 'package:untitled3/stats.dart';

import 'package:glassmorphism/glassmorphism.dart';
import 'package:get/get.dart';

class MyAdmin extends StatefulWidget {
  const MyAdmin({Key? key}) : super(key: key);

  @override
  State<MyAdmin> createState() => _MyAdminState();
}

class _MyAdminState extends State<MyAdmin> {

  bool _isBlur = false;

  @override
  Widget build(BuildContext context) {
    final user=FirebaseAuth.instance.currentUser!; /// remember this is your user instance
    return Scaffold(
      extendBodyBehindAppBar: true,
      bottomNavigationBar: CurvedNavigationBar(
        height: 60,
        backgroundColor: Colors.blue.withOpacity(0.4),
        color: Colors.transparent.withOpacity(0.2),
        animationDuration: Duration(milliseconds: 300),
        onTap: (index) {},
        items: <Widget>[
          Icon(
            Icons.add,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.home,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.settings,
            size: 30,
            color: Colors.white,
          ),
        ],
      ),
      appBar: AppBar(
        toolbarHeight: 35,
        backgroundColor: Colors.transparent.withOpacity(0.1),
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(15))),
        title: Text("Home")   ,                   //Text(user.email!),
        centerTitle: true,
        leading: BackButton(),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: Icon(Icons.logout),
          )
        ],
      ),
      body: Center(
        child: Stack(
          children: [
            Image.asset("images/pawel-czerwinski-HbcfaO4m03s-unsplash.jpg", fit: BoxFit.cover,width: double.infinity,height: double.infinity,),
            Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child:

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {


                              setState(() {
                                Get.to(ModifUser());
                                _isBlur = !_isBlur;
                              });
                            },
                            child: GlassmorphicContainer(
                                width: 130,
                                height: 130,
                                borderRadius: 20,
                                blur: 5,
                                alignment: Alignment.bottomCenter,
                                border: 2,
                                linearGradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Color(0xFFffffff).withOpacity(0.1),
                                      Color(0xFFFFFFFF).withOpacity(0.05),
                                    ],
                                    stops: [
                                      0.1,
                                      1,
                                    ]),
                                borderGradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xFFffffff).withOpacity(0.5),
                                    Color((0xFFFFFFFF)).withOpacity(0.5),
                                  ],
                                ),
                                child: Image.asset("images/medical-book.png")),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                Get.to(() => Stats());
                                _isBlur = !_isBlur;
                              });
                            },
                            child: GlassmorphicContainer(
                                width: 130,
                                height: 130,
                                borderRadius: 20,
                                blur: 5,
                                alignment: Alignment.bottomCenter,
                                border: 2,
                                linearGradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Color(0xFFffffff).withOpacity(0.1),
                                      Color(0xFFFFFFFF).withOpacity(0.05),
                                    ],
                                    stops: [
                                      0.1,
                                      1,
                                    ]),
                                borderGradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xFFffffff).withOpacity(0.5),
                                    Color((0xFFFFFFFF)).withOpacity(0.5),
                                  ],
                                ),
                                child: Image.asset("images/medical-chechup.png")),
                          ),
                        ],
                      )

                  ),
                ),
          ],
        ),
      ),
    );
  }



}
