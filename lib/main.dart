import 'package:flutter/material.dart';
import 'package:sqfliteinflutter/Insert.dart';
import 'package:sqfliteinflutter/ReadData.dart';
import 'package:sqfliteinflutter/RunPage.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(


      initialRoute: "runpage",
      routes: {
        "runpage": (context)=> RunPage(),
        "insert": (context)=> Insert(),
        "readdata": (context)=> ReadData(),
      },

    );
  }
}
