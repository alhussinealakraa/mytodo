import 'package:dartz/dartz.dart';
import 'package:my_todo/core/feature/model/response/todo_model.dart';

import '../../core/feature/model/params/todo_filter_params.dart';
import '../../core/feature/model/response/error_model.dart';

abstract class IToDoRepository{
  Future<Either<ErrorModel, List<TodoModel>>> getToDoList(ToDoFilterParams params);
  Future<Either<ErrorModel, int>> createToDo(
      TodoModel params
      );
  Future<Either<ErrorModel, int>> deleteToDo(
      TodoModel params
      );
  Future<Either<ErrorModel, int>> updateToDo(
      TodoModel params
      );
}
