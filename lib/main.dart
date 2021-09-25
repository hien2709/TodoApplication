import 'package:flutter/material.dart';
import 'package:todo_application/constant.dart';
import 'package:localstorage/localstorage.dart';
import 'package:todo_application/models/Todo.dart';
import 'package:todo_application/ui/bottom_navigation/bottom_navigation.dart';

void main() async{
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  static final LocalStorage storage = new LocalStorage('localstorage_app');
  static List<Todo> todoList = new List<Todo>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo Application',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          color: kPrimaryColor
        )
      ),
      home: BottomNavigation(),
    );
  }


}

