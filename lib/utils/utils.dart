import 'package:todo_application/main.dart';
import 'package:todo_application/models/Todo.dart';

class MyHelper{

  List<Todo> getDoneList(List<Todo> todoList){
    List<Todo> doneList = new List<Todo>();
    for(int i=0; i<todoList.length ; i++){
      if(todoList[i].isDone){
        doneList.add(todoList[i]);
      }
    }
    return doneList;
  }

  List<Todo> getOnGoingList(List<Todo> todoList){
    List<Todo> onGoingList = new List<Todo>();
    for(int i=0; i<todoList.length ; i++){
      if(!todoList[i].isDone){
        onGoingList.add(todoList[i]);
      }
    }
    return onGoingList;
  }

  void deleteItemById(int id){
    for(int i = 0; i<MyApp.todoList.length ; i++){
      if(MyApp.todoList[i].id == id){
        MyApp.todoList.removeAt(i);
        MyApp.storage.setItem("todoList", todoToJson(MyApp.todoList));
      }
    }
  }
}