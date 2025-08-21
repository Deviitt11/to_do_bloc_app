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
        
        // título del díalogo
        title: const Text("Add new task"),
        content: TextField(
          controller: textController,

          // estukis para texto en tema oscuro
          style: const TextStyle(color: Colors.white),
          cursorColor: Theme.of(context).colorScheme.primary,
          decoration: const InputDecoration(
            hintText: "Write your task...",
            hintStyle: TextStyle(color: Colors.white54),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white24),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white70),
            ),
          ),
        ),
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

    // tema oscuro
    final theme = Theme.of(context);

    // cubit todo
    final todoCubit = context.read<TodoCubit>();

    // SCAFFOLD
    return Scaffold(

      // AppBar con el título centrado
      appBar: AppBar(
        title: const Text("TO DO LIST"),
      ),

      // FAB
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _showAddTodoBox(context),
      ),

      // BLOC BUILDER
      body: BlocBuilder<TodoCubit, List<Todo>>(
        builder: (context, todos) {

          // estado vacío elegante si la lista está vacía
          if(todos.isEmpty) {
            return Center(
              child: Text(
                "No tasks yet",
                style: theme.textTheme.titleMedium?.copyWith(color: Colors.white54),
              ),
            );
          }

          // list view
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {

              // obtengo los todos individuales de la lista de todos
              final todo = todos[index];

              // list tile UI
              return ListTile(

                // texto
                title: Text(
                  todo.text,
                  style: TextStyle(
                    color: Colors.white,
                    decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
                    decorationColor: Colors.white54,
                  ),
                ),

                // check box
                leading: Checkbox(
                  value: todo.isCompleted,
                  onChanged: (value) => todoCubit.toggleCompletion(todo),
                ),

                // btn delete
                trailing: IconButton(
                  icon: const Icon(Icons.cancel),
                  color: Colors.white70, // icono color tenue
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