/*

ISAR TO DO MODEL

Convierte el modelo Todo a modelo Isar Todo para poder almacenarlo en nuestra bbdd de isar. 

*/

import 'package:isar/isar.dart';
import 'package:to_do_bloc_app/domain/models/todo.dart';

// para generar el objeto isar todo, ejecuta: dart run build_runner build
part 'isar_todo.g.dart';

@collection
class TodoIsar {

  // atributos
  Id id = Isar.autoIncrement;
  late String text;
  late bool isCompleted;

  // convierte objeto Isar -> objeto puro Todo para usar en la app
  Todo toDomain() {
    return Todo(
      id: id,
      text: text,
      isCompleted: isCompleted,
    );
  }

  // convierte objeto puro Todo -> objeto Isar para guardar en la bbdd de isar.
  static TodoIsar fromDomain(Todo todo) {
    return TodoIsar()
      ..id = todo.id
      ..text = todo.text
      ..isCompleted = todo.isCompleted;
  }
}