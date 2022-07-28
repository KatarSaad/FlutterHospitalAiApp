import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:untitled3/add_user.dart';
import 'package:untitled3/get_user_data.dart';
import 'Users.dart';
import 'add_user.dart';


class Qr extends StatefulWidget {
  const Qr({Key? key}) : super(key: key);

  @override
  State<Qr> createState() => _QrState();
}

class _QrState extends State<Qr> {
  String docIDs="";
  final _qrController = TextEditingController();
  final user=FirebaseAuth.instance.currentUser!;
  String  _qr="";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();




    //generateQr();
  }

  @override
  Widget build(BuildContext context) {

    Future<Users?> users=readUser();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(

          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(

            children: [
              QrImage(data:GetUserData(documentId: docIDs).toStringShallow()),
              TextField(


                controller: _qrController,
                decoration: InputDecoration(
                  hintText: GetUserData(documentId: docIDs).toStringShallow(),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9),
                    borderSide: BorderSide(color: Colors.blueGrey, width: 3),
                  ),
                  suffixIcon: IconButton(

                    onPressed: () => setState(() {
                     // addQR();

                     //   var s=storeNewQr(docIDs);
                      funcThatMakesAsyncCall();






                    }),
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
    );
    ;
  }
  Future generateQr() async  {


    print(user.email.toString());
    final query=
    FirebaseFirestore.instance
        .collection("users").where("email",isEqualTo: user.email.toString())

        .get()
        .then((snapshot) =>snapshot.docs.forEach((document) {
      docIDs=document.reference.id ;
      print('okkkkkkkkkkkkkkk'+document.reference.id);
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);
      print(formattedDate);
    }));
  }

  addQR()async{
    CollectionReference qr = FirebaseFirestore.instance.collection('qr');

   qr.add({
      'qruser':GetUserData(documentId: docIDs),



    });
   print("done");
  }
  Future<Users?> readUser()async{
    final docUser=FirebaseFirestore.instance.collection("users").doc();
    final snapshot=await docUser.get();
    if (snapshot.exists){
      return Users.fromJason(snapshot.data()!);
    }

  }
  Future funcThatMakesAsyncCall() async {
    var result = await readUser();
    print(result);
    setState(() {
      _qr = result!.email;
      print(_qr);
    });
  }



}
