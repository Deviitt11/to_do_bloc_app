/*

TO DO CUBIT - manejador simple de estados

Cada cubit es una lista de todos

*/
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_bloc_app/domain/models/todo.dart';
import 'package:to_do_bloc_app/domain/repository/todo_repo.dart';

class TodoCubit extends Cubit<List<Todo>>{

  // referenciar el repo de todo
  final TodoRepo todoRepo;

  // el constructor inicializar el cubit con una lista vacía
  TodoCubit(this.todoRepo) : super([]) {
    loadTodos();
  }

  // LOAD - CARGA
  Future<void> loadTodos() async {
    
    // busco lista de todos del repo
    final todoList = await todoRepo.getTodos();

    // emito la lista encontrada como el nuevo estado
    emit(todoList);

  }

  // ADD - AÑADE
  Future<void> addTodo(String text) async {

    // crea un nuevo todo con un id único
    final newTodo = Todo(
      id: DateTime.now().millisecondsSinceEpoch,
      text: text,
    );

    // guardo el nuevo todo en el repo
    await todoRepo.addTodo(newTodo);

    // recargo
    loadTodos();
  }

  // DELETE - ELIMINAR
  Future<void> deleteTodo(Todo todo) async {

    // borro el todo enviado del repo
    await todoRepo.deleteTodo(todo);

    // recargo
    loadTodos();
  }

  // TOGGLE - CAMBIA
  Future<void> toggleCompletion(Todo todo) async {

    // cambio el estado de completado del todo enviado
    final updatedTodo = todo.toggleCompletion();

    // actualizo el todo en el repo con un nuevo estado de completado
    await todoRepo.updateTodo(updatedTodo);

    // recargo
    loadTodos();
  }
}