import 'package:flutter/material.dart';

class RunPage extends StatelessWidget {
  const RunPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("CRUD Operation in Sqflite"),),
      body:
        Container(
          child:
              Column(
                children: [
                  SizedBox(width: 10,height: 200,),
                  Center(
                  child: ElevatedButton(onPressed: (){
                    Navigator.pushNamed(context, "insert");
                  }, child: Text("Register")),
                ),

                  SizedBox(width: 10,height: 10,),

                  Center(
                    child: ElevatedButton(onPressed: (){
                      Navigator.pushNamed(context, "readdata");
                    }, child: Text("View All")),
                  ),
                  SizedBox(width: 10,height: 10,),




                ],

              )

        ),

    );
  }
}
