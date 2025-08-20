/*

DATABASE REPO

Implementa el repo de Todo y se encarga del almacenamiento, recuperación, actualización
y borrado en la bbdd de isar

*/

import 'package:isar/isar.dart';
import 'package:to_do_bloc_app/data/models/isar_todo.dart';
import 'package:to_do_bloc_app/domain/models/todo.dart';
import 'package:to_do_bloc_app/domain/repository/todo_repo.dart';

class IsarTodoRepo implements TodoRepo {

  // bbdd
  final Isar db;

  // constructor
  IsarTodoRepo(this.db);

  // obtener todos
  @override
  Future<List<Todo>> getTodos() async {
    
    // buscar en la bbdd
    final todos = await db.todoIsars.where().findAll();

    // devolver como una lista de todos y enviar a la capa domain
    return todos.map((todoIsar) => todoIsar.toDomain()).toList();
  }

  // añadir todo
  @override
  Future<void> addTodo(Todo newTodo) async {
    
    // convertir el todo a isar
    final todoIsar = TodoIsar.fromDomain(newTodo);

    // para almacenarlo en la bbdd isar
    return db.writeTxn(() => db.todoIsars.put(todoIsar));

  }

  // actualizar todo
  @override
  Future<void> updateTodo(Todo todo) {

    // convertir el todo a isar
    final todoIsar = TodoIsar.fromDomain(todo);

    // para almacenarlo en la bbdd isar
    return db.writeTxn(() => db.todoIsars.put(todoIsar));
  }

  // eliminar todo
  @override
  Future<void> deleteTodo(Todo todo) async {

    await db.writeTxn(() => db.todoIsars.delete(todo.id));  
  }
}