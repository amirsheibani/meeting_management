import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meeting_management/logic/meeting/model/Invitees_model.dart';
import 'package:meeting_management/logic/meeting/model/meeting_model.dart';
import 'package:meeting_management/logic/meeting/repository/meetting_api_repository.dart';
import 'package:meeting_management/logic/member/repository/member_repository.dart';

part 'pending_invitees_event.dart';
part 'pending_invitees_state.dart';

class PendingInviteesBloc extends Bloc<PendingInviteesEvent, PendingInviteesState> {
  final MeetingApiRepository _meetingApiRepository;
  PendingInviteesBloc(this._meetingApiRepository) : super(PendingInviteesInitial()) {
    on<InviteesPendingMeetingEvent>((event, emit) async {
      try {
        List<InviteesModel> _result = await _meetingApiRepository.invitees(event.props[0]);
        emit(PendingInviteesRetrieve(_result));
      }catch (exception) {
        emit(PendingInviteesError(exception));
      }
    });
  }
}
