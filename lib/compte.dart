import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:untitled3/get_user_data.dart';
import 'package:untitled3/glass.dart';
import 'Users.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Compte extends StatefulWidget {
  const Compte({Key? key}) : super(key: key);

  @override
  State<Compte> createState() => _CompteState();
}

class _CompteState extends State<Compte> {

  //List<String> docIDs = [];
  var _qr = "";
  final user = FirebaseAuth.instance.currentUser!;
  String docIDs = "";
  late var _qrController = TextEditingController();

  late FToast fToast;

  @override
  void initState() {

    initializeDateFormatting("en-IN","");
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  _showToast(String text) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.greenAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check),
          SizedBox(
            width: 12.0,
          ),
          Text(text),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 3),
    );

    Timer(
        Duration(
          seconds: 3,
        ), () {
      Get.to(Glass());
    });

    // Custom Toast Position
  }

  @override
  Widget build(BuildContext context) {
    /// remember this is your user instance
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);

    return Scaffold(
        backgroundColor: Colors.white.withOpacity(0.95),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                  child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      QrImage(data: _qrController.text),
                      TextField(
                        controller: _qrController,
                        decoration: InputDecoration(
                          hintText: _qrController.text,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9),
                            borderSide:
                                BorderSide(color: Colors.blueGrey, width: 3),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {

                             getDocIdInfo("");
                            },
                            icon: Icon(
                              Icons.done,
                              size: 25,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )),

            ],
          ),
        ));
  }

  Future  getDocIdInfo(String aux) async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd - kk:mm').format(now);


    final query = FirebaseFirestore.instance.collection("users").doc(user.uid);
    DocumentSnapshot result=await query.get();//that help us get only one documet from the collection.....!
    Map<String,dynamic> lastQR=result.data() as Map<String,dynamic>;
     print(lastQR["last reservation"].toString()+"ccxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
    aux=lastQR["last reservation"].toString() ;

    DateTime nowTime = DateTime.now();
    var date= lastQR["last reservation"].toString() ;
    // print(date.toString()+"ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc");

    if (date.toString()=="") {
      setState(() {
        // addQR();
        print("here");



        _qrController.text = user.uid+formattedDate;
        FirebaseFirestore.instance
            .collection("qr")
            .add({
          "qruser": user.uid+formattedDate,
          "date": formattedDate,
          "id": user.uid
        });
        FirebaseFirestore.instance
            .collection("users").doc(user.uid)
            .update({

          "last reservation": formattedDate,

        });

      });
      _showToast("Premier Rendez vous validé");
    } else {
      print('else here');
      print(date.toString());
      DateFormat  f = DateFormat('yyyy-MM-dd  HH:mm');
      DateTime lastTimeDate=Intl.withLocale('en', () => DateFormat('yyyy-MM-dd - hh:mm').parse(date));

     var newDate= lastTimeDate.add(Duration(minutes: 2));
      String x = DateFormat('yyyy-MM-dd - kk:mm').format(newDate);
      print(x+'last reservation');
      print(formattedDate+'now date');
      print(lastTimeDate);
      if (newDate.isBefore(nowTime)) {
        print("heerrre");
        setState(() {
          // addQR();

          //  var s=storeNewQr(docIDs);
          //funcThatMakesAsyncCall();

          _qrController.text = user.uid;
          FirebaseFirestore.instance
              .collection("qr")
              .add({
            "qruser":user.uid+formattedDate,
            "date": formattedDate,
            "id": user.uid,
          });
          FirebaseFirestore.instance
              .collection("users").doc(user.uid)
              .update({

            "last reservation": formattedDate,

          });
        });
        _showToast("Qr generé");
      }
      else {
        print("heerreeeeeeeeeeeeeeeee else ");
        _showToast("attendez un peux");
      }
    }
    return aux;
  }

  Stream<List<Users>> readUser() => FirebaseFirestore.instance
      .collection("users")
      .where("email", isEqualTo: user.email)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Users.fromJason(doc.data())).toList());
}

Widget buildUser(Users users) => ListTile(
      leading: CircleAvatar(
        child: Text("${users.nom}"),
      ),
      title: Text(users.email),
    );

Future<Users?> readPatient() async {
  var user=await FirebaseAuth.instance.currentUser!;
  final docUser = FirebaseFirestore.instance.collection("users").doc(user.uid);
  final snapshot = await docUser.get();
  if (snapshot.exists) {
    return Users.fromJason(snapshot.data()!);
  }
}

Widget buildToast() => Container(
      color: Colors.greenAccent,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.check,
            color: Colors.black87,
          ),
          SizedBox(
            width: 15,
          ),
          Text('Qr generé')
        ],
      ),
    );

/*
FutureBuilder(

          future: getDocId(),
          builder: (context, snapshot) {
            return ListView.builder(
                itemCount: docIDs.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title:GetUserData(documentId: docIDs[index],),

                  );
                })
            ;

          }),
 */
