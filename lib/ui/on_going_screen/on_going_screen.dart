import 'package:flutter/material.dart';
import 'package:todo_application/main.dart';
import 'package:todo_application/ui/components/todo_item.dart';
import 'package:todo_application/utils/utils.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnGoingTodoScreen extends StatefulWidget {
  const OnGoingTodoScreen({Key key}) : super(key: key);

  @override
  _OnGoingTodoScreenState createState() => _OnGoingTodoScreenState();
}

class _OnGoingTodoScreenState extends State<OnGoingTodoScreen> {
  final listKey = GlobalKey<AnimatedListState>();
  final items = MyHelper().getOnGoingList(MyApp.todoList);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("On going tasks"),
      ),
      body: items.length == 0 ?
      Center(child: Container(
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/svg/empty_task.svg", width: 120, height: 120,),
            SizedBox(height: 15,),
            Text("You don't have any on going task", textAlign: TextAlign.center, style: TextStyle(fontSize: 20),),
          ],
        ),
      ))
          :AnimatedList(
        key: listKey,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        initialItemCount: items.length,
        itemBuilder: (context, index, animation) => TodoItem(
          item: items[index],
          animation: animation,
          onDelete: () => deleteItem(index),
          onClicked: () => removeItem(index),
        ),
      ),
    );
  }

  removeItem(int index) {
    final removedItem = items.removeAt(index);
    listKey.currentState.removeItem(
        index,
        (context, animation) => TodoItem(
              item: removedItem,
              animation: animation,
              onClicked: () {},
            ));
    setState(() {});
  }
  deleteItem(int index) {
    MyHelper().deleteItemById(items[index].id);
    items.removeAt(index);
    listKey.currentState.removeItem(
        index,
            (context, animation) => TodoItem(
          item: items[index],
          animation: animation,
          onClicked: () {},
        ));
    setState(() {});
  }
}
