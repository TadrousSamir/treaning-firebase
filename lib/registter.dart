
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'loginScreen.dart';



class register extends StatefulWidget {
  const register({super.key});

  @override
  State<register> createState() => _loginScreenState();
}

bool flag = true;

class _loginScreenState extends State<register> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: content(),
    );
  }

  Widget content() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Color(0xff3C49B2),
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.elliptical(81, 81),
                    bottomLeft: Radius.elliptical(81, 81))),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 100,horizontal: 150),
              child: Text('Regester',style: TextStyle(fontSize: 25,color: Colors.white),),
            ),
          ),
          SizedBox(
            height: 70,
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(20, 50, 20, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "UserName*",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: username,
                    decoration: InputDecoration(
                      hintText: "User Name",

                      border: OutlineInputBorder(

                          borderRadius: BorderRadius.circular(18)),),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Password*",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: password,
                    decoration: InputDecoration(
                        hintText: "Password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Email*",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: email,
                    decoration: InputDecoration(
                      hintText: "Enter email",

                      border: OutlineInputBorder(

                          borderRadius: BorderRadius.circular(18)),),
                  ),

                  SizedBox(
                    height: 70,
                  ),
                ],
              )),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 51,
                width: 170,
                child:ElevatedButton(
                  onPressed: ()  async {
    if (email.text.isEmpty ||
    password.text.isEmpty ||
    username.text.isEmpty )
    {
    print("please enter data");}
    else{
                    try {
                      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: email.text,
                        password: password.text,
                      );
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => loginScreen()));
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        print('The password provided is too weak.');
                      } else if (e.code == 'email-already-in-use') {
                        print('The account already exists for that email.');
                      }
                    } catch (e) {
                      print(e);
                    }


                  };},
                  child:  Text(
                    "Register",
                    style: TextStyle(fontSize: 23, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff3C49B2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
              ),

            ],
          )
        ],
      ),
    );
  }
}
