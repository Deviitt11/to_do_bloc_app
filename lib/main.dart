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

    // tema oscuro
    final baseDark = ThemeData.dark();

    final darkTheme = baseDark.copyWith(

      // fondo negro
      scaffoldBackgroundColor: Colors.black,

      // esquema de color oscuro con acento morado suave
      colorScheme: baseDark.colorScheme.copyWith(
        primary: const Color(0xFF9B87F5),
        secondary: const Color(0xFFB69DF7),
        surface: const Color(0xFF111113),
        onSurface: Colors.white,
        brightness: Brightness.dark,
      ),

      // textos en blanco por defecto
      textTheme: baseDark.textTheme.apply(
        bodyColor: Colors.white,
        displayColor: Colors.white,
      ),

      // AppBar oscura con título centrado
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 18,
          letterSpacing: 0.5,
        ),
      ),

      // FAB con texto blanco
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xFF9B87F5),
        foregroundColor: Colors.white,
      ),

      // checkbox morado + check blanco
      checkboxTheme: CheckboxThemeData(
        fillColor: const WidgetStatePropertyAll(Color(0xFF9B87F5)),
        checkColor: const WidgetStatePropertyAll(Colors.white),
      ),

      // ListTile e iconos en blanco tenue
      listTileTheme: const ListTileThemeData(
        iconColor: Colors.white70,
        textColor: Colors.white,
      ),

      // diálogos oscuros para inputs
      dialogTheme: const DialogThemeData(
        backgroundColor: Color(0xFF111113),
        surfaceTintColor: Colors.transparent,
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        contentTextStyle: TextStyle(color: Colors.white70, fontSize: 16),
      ),

      // divisor sutil
      dividerTheme: const DividerThemeData(
        color: Colors.white12,
        thickness: 0.6
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: darkTheme, // establezco el tema oscuro
      themeMode: ThemeMode.dark, // fuerzo el modo oscuro
      home: TodoPage(todoRepo: todoRepo),
    );
  }
}