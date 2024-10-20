import 'package:flutter/material.dart';

class Customdialg extends StatelessWidget {
   Customdialg({super.key});


  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(decoration: BoxDecoration(
        color: Color(0xffF8F8F8),
        borderRadius: BorderRadius.circular(15),

      ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Alert",style: TextStyle(fontSize: 30),),
            Text("Chose image and write title",style: TextStyle(color: Colors.grey),),
            SizedBox(height: 20,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 20,),
                SizedBox(
                  height: 40,
                  width: 120,
                  child: ElevatedButton(

                    onPressed: () {
                     Navigator.pop(context);

                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.check,color: Colors.white,),
                        Text('Done',style: TextStyle(color: Colors.white,fontSize: 13),),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5), // <-- Radius
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20),

              ],),
            SizedBox(height: 20,)

          ],),
      ),
    ) ;

  }

}
