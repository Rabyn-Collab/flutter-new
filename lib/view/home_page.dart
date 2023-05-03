import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutternew/models/todo.dart';
import 'package:flutternew/provider/todo_provider.dart';



class HomePage extends StatelessWidget {
final todoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer(
            builder: (context, ref, child) {
              final todos = ref.watch(todoProvider);
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                     TextFormField(
                       controller: todoController,
                       onFieldSubmitted: (val){
                         final newTodo = Todo(
                             dateTime: DateTime.now().toString(),
                             label: val
                         );
                         ref.read(todoProvider.notifier).addTodo(newTodo);
                         todoController.clear();
                       },
                      keyboardType: TextInputType.text,
                       decoration: InputDecoration(
                         hintText: 'add some todo',
                       ),
                     ),
                      Expanded(
                          child: ListView.builder(
                              itemCount: todos.length,
                              itemBuilder:(context, index){
                                final todo = todos[index];
                                return Card(
                                  child: ListTile(
                                    leading: Icon(Icons.person),
                                    title: Text(todo.label),
                                    subtitle: Text(todo.dateTime),
                                    trailing: Container(
                                      width: 96,
                                      child: Row(
                                        children: [
                                          IconButton(onPressed: (){}, icon: Icon(Icons.edit)),
                                          IconButton(onPressed: (){
                                            ref.read(todoProvider.notifier).removeTodo(todo);
                                          }, icon: Icon(Icons.delete)),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }
                          )
                      )
                    ],
                  ),
                ),
              );
            }
    )
    );
  }
}
