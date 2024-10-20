import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:traningfirebase/uploadimage.dart';

import 'loginScreen.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  List<Map<String, dynamic>> titlesAndImages = [];
  bool _isFetching = false;
  bool flag=false;
  @override
  void initState() {
    super.initState();
    //fetchArrayFromFirestore();
    Timer.periodic(Duration(seconds: 1), (Timer t) => fetchArrayFromFirestore(),);
    Future.delayed(Duration(seconds: 3),(){
      flag=true;
      setState(() {

      });
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
        backgroundColor: Color(0xff3C49B2),
        centerTitle: true,
      actions: [IconButton(
        icon: const Icon(
          Icons.logout,
          color: Colors.white,
        ),
        tooltip: 'Menu Icon',
        onPressed: () async {
          SharedPreferences shared=await SharedPreferences.getInstance();
          shared.remove('email');
          shared.remove('pass');
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => loginScreen()));

        },
      ),],
        title: const Text(
          'Home Screen',
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child:flag==false?Padding(
            padding: const EdgeInsets.only(top: 370),
            child: Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.indigo))),
          ): Column(
            children: [
              SizedBox(height: 20,),
              Container(
                height: 500, // You can adjust this height if necessary
                child: GridView.builder(
                  shrinkWrap: true, // Ensure the GridView takes only the space it needs
                  physics: NeverScrollableScrollPhysics(), // Disable scrolling for GridView to let the parent ScrollView handle it
                  itemCount: titlesAndImages.length,
                  clipBehavior: Clip.none,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.5,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10, // Adjust spacing as needed
                  ),
                  itemBuilder: (context, index) {
                    return  Container(
                      height: 100,
                      width: 100,
                      child: Column(
                        children: [
                          Container(
                            height: 70,
                            width: 100,
                            child: Image.network(
                              titlesAndImages[index]['imageUrl'],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            height: 50,
                            child: Text(
                              titlesAndImages[index]['title'],
                              textAlign: TextAlign.center, // Center the text if needed
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 8,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(width: 0),

        ),
        backgroundColor: Color(0xff3C49B2),
        foregroundColor: Colors.white,
        
        onPressed: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => Uploadimage()));
        },
        child: const Icon(Icons.add), // You can change the icon as needed
      ),

    );
  }

  Future<void> fetchArrayFromFirestore() async {
    if (_isFetching) return; // Prevent multiple calls
    _isFetching = true; // Indicate that fetch is in progress

    try {
      User? user = FirebaseAuth.instance.currentUser;
      final uid = user?.uid;
      if (uid == null) {
        print("User not authenticated");
        return;
      }

      DocumentSnapshot<Map<String, dynamic>> docSnapshot =
      await FirebaseFirestore.instance.collection("user").doc(uid).get();

      if (docSnapshot.exists) {
        List<dynamic>? arrayData = docSnapshot.data()?['titlesAndImages'];
        if (arrayData != null) {
          titlesAndImages = arrayData.map((e) => Map<String, dynamic>.from(e)).toList();
        }

        // Check if the widget is still mounted before calling setState
        if (mounted) {
          setState(() {});
        }
      } else {
        print("Document does not exist");
      }
    } on FirebaseException catch (e) {
      print('Error fetching array: $e');
    } finally {
      _isFetching = false; // Reset fetch indicator
    }
  }




}
