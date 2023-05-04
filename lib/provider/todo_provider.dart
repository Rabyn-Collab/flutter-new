import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutternew/models/todo.dart';





List<Todo> todos = [
  Todo(dateTime: DateTime.now().toString(), label: 'reading a book'),
  Todo(dateTime: DateTime.now().toString(), label: 'watching a movie'),

];

final todoProvider = StateNotifierProvider<TodoProvider, List<Todo>>((ref) => TodoProvider(todos));


class TodoProvider extends StateNotifier<List<Todo>>{
  TodoProvider(super.state);



  void addTodo(Todo todo){
     state = [...state, todo];
  }

  void removeTodo(Todo todo){
   state.remove(todo);
   state = [...state];
  }


  void updateTodo(Todo newTodo){
    state = [
      for(final t in state) t.dateTime == newTodo.dateTime ? newTodo : t
    ];
  }





}