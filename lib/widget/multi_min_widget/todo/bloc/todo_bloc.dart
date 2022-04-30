
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meeting_management/widget/multi_min_widget/todo/model/todo_model.dart';
import 'package:meeting_management/widget/multi_min_widget/todo/repository/todo_reository.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository _todoRepository;
  TodoBloc(this._todoRepository) : super(TodoInitial()) {
    on<AddTodoEvent>((event, emit) async {
      try {
        final bool _result = await _todoRepository.addTodo(event.props[0]);
        emit(NewTodoLoadedState(_result));
      }catch (exception) {
        emit(TodoErrorState(exception));
      }
    });
    on<CompleteTodoEvent>((event, emit) async {
      try {
        final bool _result = await _todoRepository.completeTodo(event.props[0],event.props[1]);
        emit(CompleteTodoLoadedState(_result));
      }catch (exception) {
        emit(TodoErrorState(exception));
      }
    });
    on<UpdateTodoEvent>((event, emit) async {
      try {
        final bool _result = await _todoRepository.updateTodo(event.props[0]);
        emit(UpdateTodoLoadedState(_result));
      }catch (exception) {
        emit(TodoErrorState(exception));
      }
    });
    on<DeleteTodoEvent>((event, emit) async {
      try {
        final bool _result = await _todoRepository.deleteTodo(event.props[0]);
        emit(DeleteTodoLoadedState(_result));
      }catch (exception) {
        emit(TodoErrorState(exception));
      }
    });
    on<RetrieveTodoEvent>((event, emit) async {
      try {
        final List<TodoModel> _result = await _todoRepository.retrieveTodo(id:event.props[0]);
        emit(RetrieveTodoLoadedState(_result));
      }catch (exception) {
        emit(TodoErrorState(exception));
      }
    });
    on<DailyTodoEvent>((event, emit) async {
      try {
        final List<TodoModel> _result = await _todoRepository.dailyTodo(event.props[0]);
        emit(DailyTodoLoadedState(_result));
      }catch (exception) {
        emit(TodoErrorState(exception));
      }
    });
    on<QueryTodoEvent>((event, emit) async {
      try {
        final List<TodoModel> _result = await _todoRepository.queryTodo(event.props[0],event.props[1],searchText: event.props[2]);
        emit(QueryTodoLoadedState(_result));
      }catch (exception) {
        emit(TodoErrorState(exception));
      }
    });
    on<QueryCountTodoEvent>((event, emit) async {
      try {
        final List<TodoModel> _result = await _todoRepository.queryCountTodo(event.props[0]);
        emit(QueryCountTodoLoadedState(_result));
      }catch (exception) {
        emit(TodoErrorState(exception));
      }
    });
  }
}
