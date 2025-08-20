/*

TO DO VIEW: responsable de la UI

- usa BlocBuilder

*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_bloc_app/domain/models/todo.dart';
import 'package:to_do_bloc_app/presentation/todo_cubit.dart';

class TodoView extends StatelessWidget {
  const TodoView({super.key});

  // caja de dialogo para que el usuario escriba
  void _showAddTodoBox(BuildContext context) {

    final todoCubit = context.read<TodoCubit>();
    final textController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(controller: textController),
        actions: [

          // btn cancelar
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Cancel"),
          ),

          // btn añadir
          TextButton(
            onPressed: () {
              todoCubit.addTodo(textController.text);
              Navigator.of(context).pop();
            },
            child: const Text("Add"),
          ),
        ],
      )
    );
  }

  // construyo la UI
  @override
  Widget build(BuildContext context) {

    // cubit todo
    final todoCubit = context.read<TodoCubit>();

    // SCAFFOLD
    return Scaffold(

      // FAB
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _showAddTodoBox(context),
      ),

      // BLOC BUILDER
      body: BlocBuilder<TodoCubit, List<Todo>>(
        builder: (context, todos) {

          // list view
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {

              // obtengo los todos individuales de la lista de todos
              final todo = todos[index];

              // list tile UI
              return ListTile(

                // texto
                title: Text(todo.text),

                // check box
                leading: Checkbox(
                  value: todo.isCompleted,
                  onChanged: (value) => todoCubit.toggleCompletion(todo),
                ),

                // btn delete
                trailing: IconButton(
                  icon: const Icon(Icons.cancel),
                  onPressed: () => todoCubit.deleteTodo(todo),
                ),
              );
            }
          );
        },
      ),
    );
  }
}