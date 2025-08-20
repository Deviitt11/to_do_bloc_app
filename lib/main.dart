import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:to_do_bloc_app/data/models/isar_todo.dart';
import 'package:to_do_bloc_app/data/repository/isar_todo_repo.dart';
import 'package:to_do_bloc_app/domain/repository/todo_repo.dart';
import 'package:to_do_bloc_app/presentation/todo_page.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  // obtengo el path para almacenar los datos
  final dir = await getApplicationDocumentsDirectory();

  // abro la bbdd de isar
  final isar = await Isar.open([TodoIsarSchema], directory: dir.path);

  // inicializo el repo con la bbdd de isar
  final isarTodoRepo = IsarTodoRepo(isar);

  // ejecuto la app
  runApp(ToDoBlocApp(todoRepo: isarTodoRepo));
}

class ToDoBlocApp extends StatelessWidget {

  // inyección bbdd desde la app
  final TodoRepo todoRepo;

  const ToDoBlocApp({super.key, required this.todoRepo});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoPage(todoRepo: todoRepo),
    );
  }
}