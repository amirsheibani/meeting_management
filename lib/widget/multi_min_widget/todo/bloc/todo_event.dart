part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();
}

class AddTodoEvent extends TodoEvent {
  final TodoModel todoModel;

  const AddTodoEvent({required this.todoModel});
  @override
  List<TodoModel> get props => [todoModel];
}

class CompleteTodoEvent extends TodoEvent {
  final int id;
  final bool done;

  const CompleteTodoEvent({required this.id,required this.done});
  @override
  List<dynamic> get props => [id,done];
}

class UpdateTodoEvent extends TodoEvent {
  final TodoModel todoModel;

  const UpdateTodoEvent({required this.todoModel});
  @override
  List<TodoModel> get props => [todoModel];
}

class DeleteTodoEvent extends TodoEvent {
  final int id;

  const DeleteTodoEvent({required this.id});
  @override
  List<int> get props => [id];
}

class RetrieveTodoEvent extends TodoEvent {
  final int? id;

  const RetrieveTodoEvent({this.id});
  @override
  List<dynamic> get props => [id];
}

class DailyTodoEvent extends TodoEvent {
  final DateTime dateTime;
  final String? searchText;

  const DailyTodoEvent({required this.dateTime, this.searchText,});
  @override
  List<dynamic> get props => [dateTime,searchText];
}

class QueryCountTodoEvent extends TodoEvent {
  final String? searchText;
  const QueryCountTodoEvent({required this.searchText,});
  @override
  List<dynamic> get props => [searchText];
}

class QueryTodoEvent extends TodoEvent {
  final String? searchText;
  final String pageNumber;
  final String count;

  const QueryTodoEvent({required this.pageNumber,required this.count, this.searchText,});
  @override
  List<dynamic> get props => [pageNumber,count,searchText];
}
