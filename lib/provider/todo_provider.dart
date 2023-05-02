import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutternew/models/todo.dart';



// class A {
//   final int a;
//   A(this.a);
// }
//
// class B extends A{
//   B(super.a);
//
// }
// final b = B(90);

List<Todo> todos = [
  Todo(dateTime: DateTime.now().toString(), label: 'reading a book'),
  Todo(dateTime: DateTime.now().toString(), label: 'watching a movie'),

];

final todoProvider = StateNotifierProvider<TodoProvider, List<Todo>>((ref) => TodoProvider(todos));


class TodoProvider extends StateNotifier<List<Todo>>{
  TodoProvider(super.state);



}