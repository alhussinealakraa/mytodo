part of 'todo_bloc.dart';

abstract class ToDoState extends Equatable {
  const ToDoState();
}

class ToDoInitial extends ToDoState {
  @override
  List<Object> get props => [];
}

class ToDoLoading extends ToDoState {
  @override
  List<Object?> get props => [];
}

class ToDoLoaded extends ToDoState {
  late final List<TodoModel> todoList;

  ToDoLoaded({required this.todoList});
  @override
  List<Object> get props => [todoList];
}

class ToDoError extends ToDoState {
  final String? message;

  ToDoError(this.message);

  @override
  List<Object?> get props => [];
}

class CreateToDoLoading extends ToDoState {
  @override
  List<Object?> get props => [];
}

class CreateToDoLoaded extends ToDoState {

  CreateToDoLoaded();
  @override
  List<Object> get props => [];
}

class CreateToDoError extends ToDoState {
  final String? message;

  CreateToDoError(this.message);

  @override
  List<Object?> get props => [];
}

class DeleteToDoLoading extends ToDoState {
  @override
  List<Object?> get props => [];
}

class DeleteToDoLoaded extends ToDoState {

  DeleteToDoLoaded();
  @override
  List<Object> get props => [];
}

class DeleteToDoError extends ToDoState {
  final String? message;

  DeleteToDoError(this.message);

  @override
  List<Object?> get props => [];
}

class UpdateToDoLoading extends ToDoState {
  @override
  List<Object?> get props => [];
}

class UpdateToDoLoaded extends ToDoState {

  UpdateToDoLoaded();
  @override
  List<Object> get props => [];
}

class UpdateToDoError extends ToDoState {
  final String? message;

  UpdateToDoError(this.message);

  @override
  List<Object?> get props => [];
}