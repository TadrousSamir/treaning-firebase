import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'homescreen.dart';
import 'loginScreen.dart';

class Splach extends StatefulWidget {
  const Splach({super.key});

  @override
  State<Splach> createState() => _SplachState();
}

class _SplachState extends State<Splach> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 4),(){
     getdate();
    });
    super.initState();

  }
  getdate() async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    if(shared.getString('email')!.isEmpty&&shared.getString('pass')!.isEmpty){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>loginScreen()));
    }else{
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Homescreen()),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff3C49B2),
      body: Column(
        children: [
          Expanded(child: Center(child: Image.asset("images/Splach.png")))
        ],
      ),
    );

  }
}
