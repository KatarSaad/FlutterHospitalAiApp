import 'package:cloud_firestore/cloud_firestore.dart';

class Users{

  String id;
  final String nom;
  final int Cin;
  final String email;
  final String prenom;

  Users({
    this.id='',
    required this.nom,
    required this.Cin,
    required this.email,
    required this.prenom,

  });
  String  getNom(){
    return this.nom;
  }



  static Users fromJason(Map<String,dynamic> jason)=>Users
    (
    id: jason['id']??"",
    nom: jason["nom"]??"",
    prenom: jason['Prenom']??"",
    Cin: jason['Cin']??0,
    email: jason ["email"]??"",

  );

}

