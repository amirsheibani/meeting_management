part of 'note_bloc.dart';

abstract class NoteEvent extends Equatable {
  const NoteEvent();
}
class AddNoteEvent extends NoteEvent {
  final NoteModel noteModel;

  const AddNoteEvent({required this.noteModel});
  @override
  List<NoteModel> get props => [noteModel];
}

class UpdateNoteEvent extends NoteEvent {
  final NoteModel noteModel;

  const UpdateNoteEvent({required this.noteModel});
  @override
  List<NoteModel> get props => [noteModel];
}

class DeleteNoteEvent extends NoteEvent {
  final int id;

  const DeleteNoteEvent({required this.id});
  @override
  List<int> get props => [id];
}

class RetrieveNoteEvent extends NoteEvent {
  final int? id;

  const RetrieveNoteEvent({this.id});
  @override
  List<dynamic> get props => [id];
}

class DailyNoteEvent extends NoteEvent {
  final DateTime dateTime;
  final String? searchText;

  const DailyNoteEvent({required this.dateTime, this.searchText,});
  @override
  List<dynamic> get props => [dateTime,searchText];
}

class QueryCountNoteEvent extends NoteEvent {
  final String? searchText;
  const QueryCountNoteEvent({required this.searchText,});
  @override
  List<dynamic> get props => [searchText];
}

class QueryNoteEvent extends NoteEvent {
  final String? searchText;
  final String pageNumber;
  final String count;

  const QueryNoteEvent({required this.pageNumber,required this.count, this.searchText,});
  @override
  List<dynamic> get props => [pageNumber,count,searchText];
}
