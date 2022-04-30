part of 'todo_bloc.dart';

abstract class TodoState extends Equatable {
  const TodoState();
}

class TodoInitial extends TodoState {
  @override
  List<Object> get props => [];
}
class NewTodoLoadedState extends TodoState {
  final bool status;
  const NewTodoLoadedState(this.status);
  @override
  List<Object?> get props => [status];
}

class CompleteTodoLoadedState extends TodoState {
  final bool status;
  const CompleteTodoLoadedState(this.status);
  @override
  List<bool?> get props => [status];
}

class UpdateTodoLoadedState extends TodoState {
  final bool status;
  const UpdateTodoLoadedState(this.status);
  @override
  List<Object?> get props => [status];
}

class DeleteTodoLoadedState extends TodoState {
  final bool status;
  const DeleteTodoLoadedState(this.status);
  @override
  List<Object?> get props => [status];
}

class RetrieveTodoLoadedState extends TodoState {
  final List<TodoModel> todos;
  const RetrieveTodoLoadedState(this.todos);
  @override
  List<Object?> get props => [todos];
}

class DailyTodoLoadedState extends TodoState {
  final List<TodoModel> todos;
  const DailyTodoLoadedState(this.todos);
  @override
  List<Object?> get props => [todos];
}

class QueryTodoLoadedState extends TodoState {
  final List<TodoModel> todos;
  const QueryTodoLoadedState(this.todos);
  @override
  List<Object?> get props => [todos];
}

class QueryCountTodoLoadedState extends TodoState {
  final List<TodoModel> todos;
  const QueryCountTodoLoadedState(this.todos);
  @override
  List<Object?> get props => [todos];
}

class TodoErrorState extends TodoState {
  final dynamic error;
  const TodoErrorState(this.error);
  @override
  List<dynamic?> get props => [error];
}