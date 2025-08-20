/*

TO DO PAGE: responsable de enviar el cubit a view (UI)

- usa BlocProvider

*/

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_bloc_app/domain/repository/todo_repo.dart';
import 'package:to_do_bloc_app/presentation/todo_cubit.dart';
import 'package:to_do_bloc_app/presentation/todo_view.dart';

class TodoPage extends StatelessWidget {
  final TodoRepo todoRepo;

  const TodoPage({super.key, required this.todoRepo});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoCubit(todoRepo),
      child: const TodoView(),
    );
  }
}