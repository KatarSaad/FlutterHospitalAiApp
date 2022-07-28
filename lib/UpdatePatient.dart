
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdatePatient extends StatelessWidget {
  UpdatePatient({required this.id});

  String id;

  final _emailController = TextEditingController();
  final _PassWordController = TextEditingController();
  final _nameController = TextEditingController();
  final _FamilynameController = TextEditingController();
  final _cinController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var user;
    List images = ["g.png", "t.png", "f.png"];
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
                    key: formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 14,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 20
                            ),
                            child: Text("Update Patient...", style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color:Colors.black54),),
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
                            child: TextFormField(
                              controller: _nameController,
                              decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white70, width: 1)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25)),
                                  hintText: "Nom",
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white70, width: 1))),
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
                            child: TextFormField(
                              controller: _FamilynameController,
                              decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white70, width: 1)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25)),
                                  hintText: "Prenom",
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white70, width: 1))),
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
                            child: TextFormField(
                              controller: _cinController,
                              decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white70, width: 1)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25)),
                                  hintText: "Cin",
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white70, width: 1))),
                            ),
                          ),
                          SizedBox(
                            height: 14,
                          )
                        ]),
                  )),
              SizedBox(height: 18),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {updateUser( _nameController.text.trim(), _FamilynameController.text.trim(),int.parse(_cinController.text.trim()));},
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
                      "Update",
                      style: TextStyle(
                          fontSize: 36,
                          color: Colors.white70,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: w * 0.05,
              ),
            ]),
          ]),
        ));
  }

  updateUser(

    String name,
    String familyName,
    int cin,
  ) async {
    FirebaseFirestore.instance.collection('users').doc(id).update({

      "nom": name,
      "Prenom": familyName,
      "Cin": cin,

    });
  }
}
