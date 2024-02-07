import 'package:get_it/get_it.dart';
import 'package:my_todo/feature/home/bloc/todo_bloc.dart';
import 'package:my_todo/repository/sqlite_service.dart';
import 'package:my_todo/repository/todo/todo_repo.dart';

final sl = GetIt.instance;

void initInjection() {
  //Bloc
  sl.registerLazySingleton(() => ToDoBloc(sl()));

  //! repos
  sl.registerLazySingleton(() => ToDoRepository(sl()));

  //! data sources
  sl.registerLazySingleton(() => SQLiteService());
}
