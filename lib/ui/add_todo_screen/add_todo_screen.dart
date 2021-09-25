import 'package:flutter/material.dart';
import 'package:todo_application/constant.dart';
import 'package:todo_application/main.dart';
import 'package:todo_application/models/Todo.dart';
import 'package:another_flushbar/flushbar.dart';

class AddTodoItemScreen extends StatefulWidget {
  const AddTodoItemScreen({Key key}) : super(key: key);

  @override
  _AddTodoItemScreenState createState() => _AddTodoItemScreenState();
}

class _AddTodoItemScreenState extends State<AddTodoItemScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    final TextEditingController _titleController = TextEditingController();
    final TextEditingController _descriptionController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text("Create a new task!"),
        centerTitle: false,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: 'Task title (required)',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value){
                      if(value.isEmpty){
                        return "Task title is required";
                      }else{
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _descriptionController,
                    maxLines: 4,
                    minLines: 3,
                    decoration: InputDecoration(
                      labelText: 'Task description',
                      border: OutlineInputBorder(),
                    ),
                  ),

                ],
              ),
            ),
          ),
          Positioned.fill(
            bottom: 50,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    color: kPrimaryColor,
                    onPressed: (){
                        if(formKey.currentState.validate()) {
                          Todo newTodoItem = new Todo(title: _titleController
                              .text.trim(),
                              isDone: false,
                              description: _descriptionController.text.trim(),
                            id: MyApp.todoList.length==0?1:MyApp.todoList[MyApp.todoList.length-1].id+1,
                          );
                          MyApp.todoList.add(newTodoItem);
                          MyApp.storage.setItem("todoList", todoToJson(MyApp
                              .todoList));
                          Navigator.pop(context, newTodoItem);
                          Flushbar(
                            title: "Success",
                            message: "New task added",
                            flushbarPosition: FlushbarPosition.TOP,
                            duration: Duration(seconds: 3),
                          )
                            ..show(context);
                        }
                    },
                    child: Text(
                      "Create new task",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
