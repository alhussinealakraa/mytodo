import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:my_todo/repository/sqlite_service.dart';

import '../../core/feature/model/params/todo_filter_params.dart';
import '../../core/feature/model/response/error_model.dart';
import '../../core/feature/model/response/todo_model.dart';
import 'itodo_repo.dart';

@Injectable(as: IToDoRepository)
class ToDoRepository extends IToDoRepository {
  SQLiteService sqLiteService;

  ToDoRepository(this.sqLiteService);
  @override
  Future<Either<ErrorModel, List<TodoModel>>> getToDoList(ToDoFilterParams params) async {
    try {
      final data = await sqLiteService.getAllTodos(params);
      print('========');
      print(data);
      return Right(data);
    } on Exception catch (e) {
      return Left(ErrorModel());
    }
  }

  @override
  Future<Either<ErrorModel, int>> createToDo(
      TodoModel params
      ) async {
    try {
      final data = await sqLiteService.addTodo(params);
      return Right(data);
    } on Exception catch (e) {
      return Left(ErrorModel());
    }
  }

  @override
  Future<Either<ErrorModel, int>> deleteToDo(
      TodoModel params
      ) async {
    try {
      final data = await sqLiteService.deleteTodo(params);
      return Right(data);
    } on Exception catch (e) {
      return Left(ErrorModel());
    }
  }

  @override
  Future<Either<ErrorModel, int>> updateToDo(
      TodoModel params
      ) async {
    try {
      final data = await sqLiteService.updateTodo(params);
      return Right(data);
    } on Exception catch (e) {
      return Left(ErrorModel());
    }
  }
}