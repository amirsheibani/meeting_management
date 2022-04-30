
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meeting_management/widget/notes/model/note_model.dart';
import 'package:meeting_management/widget/notes/repository/note_reository.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final NoteRepository _noteRepository;
  NoteBloc(this._noteRepository) : super(NoteInitial()) {
    on<AddNoteEvent>((event, emit) async {
      try {
        final bool _result = await _noteRepository.addNote(event.props[0]);
        emit(NewNoteLoadedState(_result));
      }catch (exception) {
        emit(NoteErrorState(exception));
      }
    });
    on<UpdateNoteEvent>((event, emit) async {
      try {
        final bool _result = await _noteRepository.updateNote(event.props[0]);
        emit(UpdateNoteLoadedState(_result));
      }catch (exception) {
        emit(NoteErrorState(exception));
      }
    });
    on<DeleteNoteEvent>((event, emit) async {
      try {
        final bool _result = await _noteRepository.deleteNote(event.props[0]);
        emit(DeleteNoteLoadedState(_result));
      }catch (exception) {
        emit(NoteErrorState(exception));
      }
    });
    on<RetrieveNoteEvent>((event, emit) async {
      try {
        final List<NoteModel> _result = await _noteRepository.retrieveNote(id:event.props[0]);
        emit(RetrieveNoteLoadedState(_result));
      }catch (exception) {
        emit(NoteErrorState(exception));
      }
    });
    on<DailyNoteEvent>((event, emit) async {
      try {
        final List<NoteModel> _result = await _noteRepository.dailyNote(event.props[0]);
        emit(DailyNoteLoadedState(_result));
      }catch (exception) {
        emit(NoteErrorState(exception));
      }
    });
    on<QueryNoteEvent>((event, emit) async {
      try {
        final List<NoteModel> _result = await _noteRepository.queryNote(event.props[0],event.props[1],searchText: event.props[2]);
        emit(QueryNoteLoadedState(_result));
      }catch (exception) {
        emit(NoteErrorState(exception));
      }
    });
    on<QueryCountNoteEvent>((event, emit) async {
      try {
        final List<NoteModel> _result = await _noteRepository.queryCountNote(event.props[0]);
        emit(QueryCountNoteLoadedState(_result));
      }catch (exception) {
        emit(NoteErrorState(exception));
      }
    });
  }
}
