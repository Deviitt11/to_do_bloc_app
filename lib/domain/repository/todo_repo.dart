/*

TO DO REPOSITORY

Aquí se define lo que la app puede hacer

*/

import 'package:to_do_bloc_app/domain/models/todo.dart';

abstract class TodoRepo {

  // obtener lista de todos
  Future<List<Todo>> getTodos();

  // añadir un nuevo todo
  Future<void> addTodo(Todo newTodo);

  // actualizar un todo existente
  Future<void> updateTodo(Todo todo);

  // eliminar un todo
  Future<void> deleteTodo(Todo todo);
}

/*

Notas:

- el repo en la capa de domain destaca las operaciones que la app puede hacer, pero
no especifica los detalles de implementación. De eso se encarga la capa de data.

- independiente de cualquier tecnología o framework.

*/