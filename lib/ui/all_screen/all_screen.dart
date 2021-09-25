import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_application/constant.dart';
import 'package:todo_application/main.dart';
import 'package:todo_application/models/Todo.dart';
import 'package:todo_application/ui/add_todo_screen/add_todo_screen.dart';
import 'package:todo_application/ui/components/todo_item.dart';
import 'package:todo_application/utils/utils.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AllTodoScreen extends StatefulWidget {
  const AllTodoScreen({Key key}) : super(key: key);

  @override
  _AllTodoScreenState createState() => _AllTodoScreenState();
}

class _AllTodoScreenState extends State<AllTodoScreen> {
  var listKey = GlobalKey<AnimatedListState>();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: MyApp.storage.ready,
      builder: (BuildContext context, snapshot){
        if (snapshot.data == true) {
          MyApp.storage.getItem("todoList") == null ? MyApp.storage.setItem("todoList", todoToJson(new List<Todo>())) :  MyApp.todoList = todoFromJson(MyApp.storage.getItem("todoList"));
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: kPrimaryColor,
              child: Icon(Icons.add),
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddTodoItemScreen()),
                ).then((value) => setState(() {listKey = GlobalKey<AnimatedListState>();}));
              },
            ),
            appBar: AppBar(
              centerTitle: true,
              title: Text("All tasks"),
            ),
            body:
            MyApp.todoList.length == 0 ?
            Center(child: Container(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/svg/find_task.svg", width: 120, height: 120,),
                  SizedBox(height: 15,),
                  Text("You don't have any task", textAlign: TextAlign.center, style: TextStyle(fontSize: 20),),
                  SizedBox(height: 10,),
                  Text("Click + button at the corner to create new task!", textAlign: TextAlign.center,),
                ],
              ),
            ))
            :AnimatedList(
              key: listKey,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              initialItemCount: MyApp.todoList.length,
              itemBuilder: (context, index, animation) => TodoItem(
                item: MyApp.todoList[index],
                animation: animation,
                onDelete: () => deleteItem(index),
              ),
            ),
          );
        } else {
          return Center(
            child: Container(
              width: 200,
              height: 200,
              child: Lottie.asset("assets/lottie/loading-animation.json"),
            ),
          );
        }
      },

    );
  }
  deleteItem(int index) {
    Todo removedItem = MyApp.todoList[index];
    MyHelper().deleteItemById(MyApp.todoList[index].id);
    listKey.currentState.removeItem(
        index,
            (context, animation) => TodoItem(
          item: removedItem,
          animation: animation,
          onClicked: () {},
        ));
    setState(() {});
  }
}
