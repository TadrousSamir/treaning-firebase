import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:traningfirebase/homescreen.dart';
import 'package:traningfirebase/loginScreen.dart';

class Uploadimage extends StatefulWidget {
  const Uploadimage({super.key});

  @override
  State<Uploadimage> createState() => _UploadimageState();
}

class _UploadimageState extends State<Uploadimage> {
  List<Map<String, dynamic>> titlesAndImages = [];

  TextEditingController title = TextEditingController();

  FirebaseStorage storage = FirebaseStorage.instance;
  XFile? _image;
  String? imageUrl;
  bool flag=false;
 static bool flagdata=false;

  @override
  void initState() {
    super.initState();
    //fetchArrayFromFirestore();
    Timer.periodic(
        Duration(seconds: 1), (Timer t) => fetchArrayFromFirestore());

    Future.delayed(Duration(seconds: 4),(){
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
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          tooltip: 'Menu Icon',
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Homescreen()));
          },
        ),
        title: const Text(
          'Upload Image',
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
      ),
      body:flag==false?Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.indigo))) :Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Enter title",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            TextField(
              controller: title,
              cursorColor: Colors.indigo,

              decoration: InputDecoration(
               focusedBorder: OutlineInputBorder(
                 borderSide: BorderSide(color: Colors.grey,width: 1),
                 borderRadius: BorderRadius.circular(18),
               ),
                hintText: "title",
                border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey, width: 5),
                        borderRadius: BorderRadius.circular(18)),
              ),
            ),
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              child: SizedBox(
                height: 51,
                width: 200,
                child: ElevatedButton(
                  onPressed: pickImage,
                  child: Text(
                    "Gallery",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff3C49B2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              child: SizedBox(
                height: 51,
                width: 200,
                child: ElevatedButton(
                    child: Text(
                      "Save",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff3C49B2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    onPressed:() {
                      checkAndUpload();
                      print(flagdata);
                      if(flagdata==false){
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            content: Text("save faild :Enter title and Chosse image "),
                            duration: Duration(seconds: 1),

                          ),);
                      if(_image==null&&title.text.isNotEmpty){
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            content: Text("save faild :Chosse Image "),
                            duration:  Duration(seconds: 2),

                          ),);
                      }
                      else if(title.text.isEmpty&&_image!=null){
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            content: Text("save faild :Enter Title"),
                            duration: Duration(seconds: 2),

                          ),);
                      }
                      } else{
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.green,
                              content: Text("save sucsess "),
                              duration: Duration(seconds: 5),

                            ),);
                      }


                    }

    ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Expanded(
              child: Container(
                height: 100,
                width: double.infinity,
                child: ListView.builder(
                  itemCount: titlesAndImages.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                              children: [
                                Container(
                                    height: 70,
                                    width: 80,
                                    child: Image.network(
                                        titlesAndImages[index]['imageUrl'])),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                    width: 100,
                                    child:
                                        Text(titlesAndImages[index]['title'])),
                                SizedBox(
                                  width: 120,
                                ),
                                IconButton(
                                  iconSize: 30,
                                  icon: const Icon(
                                    Icons.delete,
                                  ),
                                  onPressed: () {
                                    removeFromFirestore(titlesAndImages[index]);
                                    setState(
                                      () {},
                                    );
                                  },
                                ),
                              ],
                            ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image; // Update the state with the selected image
    });
  }

  Future<String?> uploadFile() async {
    if (_image == null) return null; // Exit if no image is selected

    final fileName = basename(_image!.path); // Get the file name
    final destination = 'files/$fileName'; // Define the destination path

    try {
      // Create a reference to the storage location
      final ref = FirebaseStorage.instance.ref(destination);
      await ref.putFile(File(_image!.path)); // Upload the file

      // Get the download URL
      String downloadUrl = await ref.getDownloadURL();
      print('File uploaded successfully: $downloadUrl');
      return downloadUrl; // Return the download URL
    } catch (e) {
      print('Error occurred: $e'); // Print the error if upload fails
      return null; // Return null on error
    }
  }

  void checkAndUpload() async {

    if (title.text.isNotEmpty && _image != null) {
      flagdata=true;
      User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // Sign in anonymously if not logged in
      user = (await FirebaseAuth.instance.signInAnonymously()).user;
    }
    imageUrl = await uploadFile();
    await firestore(imageUrl);
    _image=null;
    title.text="";

    setState(() {

    });
    }else {
      print('nnmm');

      flagdata=false;
      setState(() {

      });

    }
    flagdata=false;
  }

  Future<void> firestore(String? imageUrl) async {
    User? user = FirebaseAuth.instance.currentUser;
    final uid = user?.uid;

    if (uid == null) {
      print("User not authenticated");
      return;
    }

    try {
      // Fetch the existing document if it exists
      DocumentReference userDoc =
          FirebaseFirestore.instance.collection("user").doc(uid);
      DocumentSnapshot docSnapshot = await userDoc.get();

      if (docSnapshot.exists) {

        // Update the existing document
        if (title.text.isNotEmpty && imageUrl != null) {

          print('Document added/updated successfully');
          await userDoc.update({
            'titlesAndImages': FieldValue.arrayUnion([
              {'title': title.text.toString(), 'imageUrl': imageUrl}
            ])
          });
          imageUrl = null;
          setState(() {
            title.text = "";
            imageUrl = null;
          });

        } else {
          flagdata=false;
          setState(() {

          });

        }

      } else {
        await userDoc.set({
          'titlesAndImages': FieldValue.arrayUnion([
            {'title': title.text.toString(), 'imageUrl': imageUrl}
          ])
        });
      }
    } on FirebaseException catch (e) {
      print('---------------Error: $e');
    } catch (e) {
      print('----------------Error: $e');
    }
  }

  Future<void> fetchArrayFromFirestore() async {
    try {
      // Replace 'userId' with the ID of the user you want to fetch data for
      User? user = FirebaseAuth.instance.currentUser;
      final uid = user?.uid;
      if (uid == null) {
        print("User not authenticated");
        return;
      }

      DocumentSnapshot<Map<String, dynamic>> docSnapshot =
          await FirebaseFirestore.instance.collection("user").doc(uid).get();

      if (docSnapshot.exists) {
        // Get the array from the Firestore document

        List<dynamic>? arrayData = docSnapshot.data()?['titlesAndImages'];

        // Convert the array data to a List<Map<String, dynamic>>
        if (arrayData != null) {
          titlesAndImages =
              arrayData.map((e) => Map<String, dynamic>.from(e)).toList();
        }

        // Refresh the UI
        if (mounted) {
          setState(() {});
        }
      } else {
        print("Document does not exist");
      }
    } on FirebaseException catch (e) {
      print('Error fetching array: $e');
    }
  }

  Future<void> removeFromFirestore(Map<String, dynamic> itemToRemove) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      final uid = user?.uid;
      if (uid == null) {
        print("User not authenticated");
        return;
      }

      // Remove the item from the Firestore array
      await FirebaseFirestore.instance.collection("user").doc(uid).update({
        'titlesAndImages': FieldValue.arrayRemove([itemToRemove])
      });

      // Remove the item from the local list and refresh the UI
      setState(() {
        titlesAndImages.removeWhere((item) =>
            item['title'] == itemToRemove['title'] &&
            item['imageUrl'] == itemToRemove['imageUrl']);
      });

      print('Item removed successfully');
    } on FirebaseException catch (e) {
      print('Error removing item: $e');
    }
  }
}
