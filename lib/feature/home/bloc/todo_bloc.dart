import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_todo/core/feature/model/response/todo_model.dart';

import '../../../core/feature/model/params/todo_filter_params.dart';
import '../../../repository/todo/todo_repo.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class ToDoBloc extends Bloc<ToDoEvent, ToDoState> {
  final ToDoRepository toDoRepository;
  ToDoBloc(this.toDoRepository) : super(ToDoInitial()) {
    on<GetToDoLisLtEvent>((event, emit) async {
      emit(ToDoLoading());

      var res =
      await toDoRepository.getToDoList(event.params);
      print('=====');
      print(res);
      emit(res.fold((l) => ToDoError(l.errorMessage),
              (r) => ToDoLoaded(todoList: r)));
    });

    on<CreateToDoEvent>((event, emit) async {
      emit(CreateToDoLoading());

      var res =
      await toDoRepository.createToDo(event.todoModel);
      emit(res.fold((l) => CreateToDoError(l.errorMessage),
              (r) => CreateToDoLoaded()));
    });

    on<DeleteToDoEvent>((event, emit) async {
      emit(DeleteToDoLoading());

      var res =
      await toDoRepository.deleteToDo(event.todoModel);
      emit(res.fold((l) => DeleteToDoError(l.errorMessage),
              (r) => DeleteToDoLoaded()));
    });

    on<UpdateToDoEvent>((event, emit) async {
      emit(UpdateToDoLoading());

      var res =
      await toDoRepository.updateToDo(event.todoModel);
      emit(res.fold((l) => UpdateToDoError(l.errorMessage),
              (r) => UpdateToDoLoaded()));
    });
  }
}
