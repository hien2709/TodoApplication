import 'package:flutter/material.dart';
import 'package:todo_application/constant.dart';
import 'package:todo_application/ui/all_screen/all_screen.dart';
import 'package:todo_application/ui/done_screen/done_screen.dart';
import 'package:todo_application/ui/on_going_screen/on_going_screen.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key key}) : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int selectedIndex = 0;
  List<Widget> widgetOptions = <Widget>[
    AllTodoScreen(),
    DoneTodoScreen(),
    OnGoingTodoScreen(),
  ];

  void  onBottomNavigationItemSelect(int index){
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(MyApp.storage.getItem("token"));
    return Scaffold(
      body: Center(
        child: widgetOptions.elementAt(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type : BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.grey,
        selectedItemColor: kPrimaryColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            title: Text("All"),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.done,
            ),
            title: Text("Done"),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.description_outlined,
            ),
            title: Text("Ongoing"),
          ),

        ],
        currentIndex: selectedIndex,
        onTap: onBottomNavigationItemSelect,
      ),
    );
  }

}
