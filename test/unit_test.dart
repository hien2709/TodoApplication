import 'package:flutter_test/flutter_test.dart';
import 'package:todo_application/main.dart';
import 'package:todo_application/models/Todo.dart';
import 'package:todo_application/utils/utils.dart';

void main() {
  test('Given a todo list When run getDoneList Then return all done todo item',
      () async {
    //ARRANGE
    final todoList = [
      Todo(id: 1, description: "description", isDone: true, title: "title"),
      Todo(id: 2, description: "description", isDone: false, title: "title"),
      Todo(id: 3, description: "description", isDone: true, title: "title"),
      Todo(id: 4, description: "description", isDone: true, title: "title"),
      Todo(id: 5, description: "description", isDone: false, title: "title")
    ];

    //ACT
    List<Todo> actual = MyHelper().getDoneList(todoList);

    //ASSERT
    expect(actual, [todoList[0],todoList[2],todoList[3]]);
  });

  test('Given a todo list When run getOngoingList Then return all on going todo item',
          () async {
        //ARRANGE
        final todoList = [
          Todo(id: 1, description: "description", isDone: true, title: "title"),
          Todo(id: 2, description: "description", isDone: false, title: "title"),
          Todo(id: 3, description: "description", isDone: true, title: "title"),
          Todo(id: 4, description: "description", isDone: true, title: "title"),
          Todo(id: 5, description: "description", isDone: false, title: "title")
        ];

        //ACT
        List<Todo> actual = MyHelper().getOnGoingList(todoList);

        //ASSERT
        expect(actual, [todoList[1],todoList[4]]);
      });
  test('Given a todo list When run deleteItemById with an id Then remove item contains given id',
          () async {
        //ARRANGE
            MyApp.todoList = [
              Todo(id: 1, description: "description", isDone: true, title: "title"),
              Todo(id: 2, description: "description", isDone: false, title: "title"),
              Todo(id: 3, description: "description", isDone: true, title: "title"),
              Todo(id: 4, description: "description", isDone: true, title: "title"),
              Todo(id: 5, description: "description", isDone: false, title: "title")
            ];

        //ACT
            MyHelper().deleteItemById(1);

        //ASSERT
        expect(MyApp.todoList.length, 4);
        expect(MyApp.todoList[0].id, 2);
        expect(MyApp.todoList[1].id, 3);
        expect(MyApp.todoList[2].id, 4);
        expect(MyApp.todoList[3].id, 5);
      });
}
