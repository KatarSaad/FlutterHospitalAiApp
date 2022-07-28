import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddUser {




}
Future storeNewQr(String documentId) async {
  CollectionReference qr = FirebaseFirestore.instance.collection("qr");

  final user = await FirebaseFirestore.instance.collection("qr").doc(documentId).get().then((data)=>{qr.add("${data["email"]}-${data["nom"]}-${data['Prenom']}-${data['Cin']}-") });


}
