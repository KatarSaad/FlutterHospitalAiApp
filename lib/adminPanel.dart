import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:untitled3/UpdatePatient.dart';
import 'package:untitled3/modifUser.dart';

import 'glass.dart';

class Admin extends StatefulWidget {
  String id;


  Admin({required this.id});

  @override
  State<Admin> createState() => _AdminState(id);
}

class _AdminState extends State<Admin> {
  late FToast fToast;
  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }
  String id;
  _AdminState(this.id);
  String iid=FirebaseAuth.instance.currentUser!.uid;
  String payment = "";
  String appointment = "";
  TextEditingController _appointment=TextEditingController();
  TextEditingController _payment=TextEditingController();
  String? value;
  List<String> type=["general","gastro","dermatologie","pneumologie","neurologie","ophtalmologie","endocrinologie","ORL","Urologie"];

  DropdownMenuItem<String> buidMenuItem(String item) => DropdownMenuItem(

    value: item,
    child: Text(
      item,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
    ),
  );

  _showToast() {
    Widget toast =Stack(
      children: [Container(
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
    Text("Rendez vous ajouté"),
    ],
    ),
    )],
    );


    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 4),
    );

    Timer(Duration(seconds: 3,),(){Get.to(ModifUser());}
      );

    // Custom Toast Position

  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      body: Column(
        children: [
          SizedBox(
            height: 60,
          ),
      Container(
        padding: EdgeInsets.only(left: 10),
        child: Row(
          children: [Text("Specialitées",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            SizedBox(width: 50 ,),
            Container(decoration: BoxDecoration(border: Border.all(color: Colors.black38,width: 3),borderRadius: BorderRadius.circular(15)),
              child: DropdownButton(
                  hint: Text('Choisir une  Specialité'),
                  elevation: 5,
                  icon:Icon( Icons.arrow_downward_rounded),
                  style: TextStyle(color:Colors.black),
                  dropdownColor: Colors.blueGrey.withOpacity(0.8),

                  value: value,
                  items: type.map(buidMenuItem).toList(),
                  onChanged: (value) =>
                      setState(() => this.value = value as String?)),
            ),
          ],
        ),
      ),

          SizedBox(
            height: 30,
          ),
          Container(
            padding: EdgeInsets.only(left: 10,right: 10),
            child: Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.black38,width: 3),borderRadius: BorderRadius.circular(15)),


              child: buildPayment(),
            ),
          ),

          Text(iid),
          Center(
            child: ElevatedButton(
              onPressed: () {
                addAppointment();
                _showToast();
              },
              child: Text("add"),
            ),
          )
        ],
      ),
    );
  }

  Widget buildPayment() => TextField(
    controller:_payment ,
      decoration: InputDecoration(
        labelText:"montant",
        border: OutlineInputBorder(),
      ),
  );



  Widget buildAppointment() => TextField(
    controller: _appointment,
      decoration: InputDecoration(
        labelText: "type rdv",
        border: OutlineInputBorder(),
      ),
  );

    Future  addAppointment()async{
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);
      
     CollectionReference   addIt= await FirebaseFirestore.instance.collection("users");
     addIt.doc(iid).collection("rendezVous").doc().set(
       {
         "id":iid,
         "rendezvouss":value.toString()+" : date "+formattedDate,
         "cost":_payment.text.trim(),
       }
     );


      
    }
}

