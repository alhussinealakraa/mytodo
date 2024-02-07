part of 'todo_bloc.dart';

abstract class ToDoEvent extends Equatable {
  const ToDoEvent();
}

class GetToDoLisLtEvent extends ToDoEvent {
  final ToDoFilterParams params;

  GetToDoLisLtEvent({required this.params});

  @override
  List<Object?> get props => [];
}

class CreateToDoEvent extends ToDoEvent {
  final TodoModel todoModel;

  const CreateToDoEvent({required this.todoModel});

  @override
  List<Object?> get props => [todoModel];
}

class DeleteToDoEvent extends ToDoEvent {
  final TodoModel todoModel;

  const DeleteToDoEvent({required this.todoModel});

  @override
  List<Object?> get props => [todoModel];
}

class UpdateToDoEvent extends ToDoEvent {
  final TodoModel todoModel;

  const UpdateToDoEvent({required this.todoModel});

  @override
  List<Object?> get props => [todoModel];
}