part of 'note_bloc.dart';

abstract class NoteState extends Equatable {
  const NoteState();
}

class NoteInitial extends NoteState {
  @override
  List<Object> get props => [];
}

class NewNoteLoadedState extends NoteState {
  final bool status;
  const NewNoteLoadedState(this.status);
  @override
  List<Object?> get props => [status];
}

class UpdateNoteLoadedState extends NoteState {
  final bool status;
  const UpdateNoteLoadedState(this.status);
  @override
  List<Object?> get props => [status];
}

class DeleteNoteLoadedState extends NoteState {
  final bool status;
  const DeleteNoteLoadedState(this.status);
  @override
  List<Object?> get props => [status];
}

class RetrieveNoteLoadedState extends NoteState {
  final List<NoteModel> notes;
  const RetrieveNoteLoadedState(this.notes);
  @override
  List<Object?> get props => [notes];
}

class DailyNoteLoadedState extends NoteState {
  final List<NoteModel> notes;
  const DailyNoteLoadedState(this.notes);
  @override
  List<Object?> get props => [notes];
}

class QueryNoteLoadedState extends NoteState {
  final List<NoteModel> notes;
  const QueryNoteLoadedState(this.notes);
  @override
  List<Object?> get props => [notes];
}

class QueryCountNoteLoadedState extends NoteState {
  final List<NoteModel> notes;
  const QueryCountNoteLoadedState(this.notes);
  @override
  List<Object?> get props => [notes];
}

class NoteErrorState extends NoteState {
  final dynamic error;
  const NoteErrorState(this.error);
  @override
  List<dynamic?> get props => [error];
}