
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meeting_management/logic/meeting/model/Invitees_model.dart';
import 'package:meeting_management/logic/meeting/model/meeting_model.dart';
import 'package:meeting_management/logic/meeting/repository/meetting_api_repository.dart';

part 'invitees_event.dart';
part 'invitees_state.dart';


class InviteesBloc extends Bloc<InviteesEvent, InviteesState> {
  final MeetingApiRepository _meetingApiRepository;
  InviteesBloc(this._meetingApiRepository) : super(InviteesInitial()) {
    on<InviteesMeetingEvent>((event, emit) async {
      try {
        List<InviteesModel> _result = await _meetingApiRepository.invitees(event.props[0] as int);
        emit(InviteesRetrieve(_result));
      }catch (exception) {
        emit(InviteesError(exception));
      }
    });
  }
}
