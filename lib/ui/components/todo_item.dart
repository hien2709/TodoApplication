import 'package:flutter/material.dart';
import 'package:todo_application/constant.dart';
import 'package:todo_application/main.dart';
import 'package:todo_application/models/Todo.dart';

class TodoItem extends StatefulWidget {
  const TodoItem(
      {Key key, this.animation, this.onClicked, this.item, this.onDelete})
      : super(key: key);
  final Todo item;
  final Animation<double> animation;
  final GestureTapCallback onClicked;
  final GestureTapCallback onDelete;

  @override
  _TodoItemState createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  @override
  Widget build(BuildContext context) {
    print("value of is done " +
        widget.item.id.toString() +
        "status : " +
        widget.item.isDone.toString());

    return SizeTransition(
      key: ValueKey(widget.item.isDone),
      sizeFactor: widget.animation,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.only(top: 8, bottom: 16, right: 16),
        decoration: BoxDecoration(
          border: widget.item.isDone ? Border.all(color: Colors.grey) :Border.all(color: kPrimaryColor),
          borderRadius: BorderRadius.circular(15),
          color: widget.item.isDone ?Colors.grey[100]:Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Checkbox(
                    checkColor: Colors.white,
                    value: widget.item.isDone,
                    onChanged: (bool value) => {
                      setState(() {
                        widget.item.isDone = value;
                        print("isdone : " + widget.item.isDone.toString());
                        MyApp.storage
                            .setItem("todoList", todoToJson(MyApp.todoList));
                      }),
                      widget.onClicked(),
                    },
                  ),
                ),
                Expanded(
                    child: Text(
                  widget.item.title,
                  style: TextStyle(
                      fontSize: 20,
                      decoration: widget.item.isDone
                          ? TextDecoration.lineThrough
                          : null,
                      color: widget.item.isDone ? Colors.grey : null),
                )),
                InkWell(
                  onTap: widget.onDelete,
                  child: Icon(
                    Icons.close,
                    color: Colors.redAccent,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 48),
              child: Text(
                widget.item.description,
                style: TextStyle(
                    decoration:
                        widget.item.isDone ? TextDecoration.lineThrough : null,
                    color: widget.item.isDone ? Colors.grey : null),
              ),
            )
          ],
        ),
      ),
    );
  }
}
