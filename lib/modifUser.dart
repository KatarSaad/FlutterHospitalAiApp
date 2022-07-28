import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled3/UpdatePatient.dart';
import 'package:untitled3/Users.dart';
import 'package:untitled3/adminPanel.dart';

class ModifUser extends StatefulWidget {
  const ModifUser({Key? key}) : super(key: key);

  @override
  State<ModifUser> createState() => _ModifUserState();
}

class _ModifUserState extends State<ModifUser> {
  TextEditingController _searchController = TextEditingController();
  String name="";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Row(
            children: [
              Expanded(
                flex: 7,
                child: Container(
                  height: 45,
                  padding: EdgeInsets.fromLTRB(25, 0, 10, 0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25)),
                    child: TextField(
                      onChanged: (val){setState(() {
                        name=val;
                      });},
                      controller: _searchController,
                      decoration: InputDecoration(

                          hoverColor: Colors.green,
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
                ),
              ),
              Expanded(
                  child: GestureDetector(
                      onTap: () { },
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(15)),
                          child: Icon(
                            Icons.search,
                            size: 45,
                          ))))
            ],
          ),
          Container(
            padding: EdgeInsets.all(5),
            child: StreamBuilder<List<Users>>(
              stream: readUsers(name),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text("Something is wrong${snapshot.error}");
                } else if (snapshot.hasData) {
                  final users = snapshot.data!;

                  // _qr="${user.email}-${user.nom}-${user.prenom}-${user.Cin}-$formattedDate";

                  return ListView(
                    shrinkWrap: true,
                    children: users.map(buildUser).toList(),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildUser(Users user) => ListTile(
          title: Container(
        decoration: BoxDecoration(
            color: Colors.blue.shade100,
            borderRadius: BorderRadius.circular(10)),
        child: Container(
          padding: EdgeInsets.all(7),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  flex: 5,
                  child: Text(
                    user.nom,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  )),
              Expanded(
                  child: GestureDetector(
                    onTap: (){
                      Get.to(Admin(id: user.id));
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.yellow.shade50,
                            borderRadius: BorderRadius.circular(5)),
                        child: Icon(
                          Icons.add,
                          color: Colors.yellow,
                          size: 30,
                        )),
                  )),
              SizedBox(width: 5,),
              Expanded(
                  child: GestureDetector(
                    onTap: (){Get.to(UpdatePatient(id: user.id));},
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.green.shade50),
                        child: Icon(
                          Icons.auto_fix_high,
                          color: Colors.greenAccent,
                          size: 30,
                        )),
                  )),
              SizedBox(
                width: 5,
              ),
              Expanded(
                  child: GestureDetector(
                    onTap: (){
                      FirebaseFirestore.instance.collection("users").doc(user.id).delete();
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            borderRadius: BorderRadius.circular(5)),
                        child: Icon(
                          Icons.delete,
                          color: Colors.red,
                          size: 30,
                        )),
                  ))
            ],
          ),
        ),
      ));

  Stream<List<Users>> readUsers(String  name) =>
     FirebaseFirestore.instance
              .collection("users")
              .where("keywords", arrayContains: name)
              .snapshots()
              .map((snapshot) => snapshot.docs
                  .map((doc) => Users.fromJason(doc.data()))
                  .toList())
         ;

  readUser() async {
    var collection = FirebaseFirestore.instance.collection("users");
    var query = await collection.get();

    for (var doc in query.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      String name = data["nom"];
      List<String> keywords = [];
      int l = name.length;

      for (var i = 0; i <= l; i++) {
        keywords.add(name.substring(0, i));
      }
      await doc.reference.update({"keywords": keywords,"last reservation":""});
      print(name);
    }
  }
}
