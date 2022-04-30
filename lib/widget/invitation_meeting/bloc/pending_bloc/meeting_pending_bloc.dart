import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meeting_management/logic/meeting/model/meeting_model.dart';
import 'package:meeting_management/logic/meeting/repository/meetting_api_repository.dart';

part 'meeting_pending_event.dart';
part 'meeting_pending_state.dart';

class MeetingPendingBloc extends Bloc<MeetingPendingEvent, MeetingPendingState> {
  final MeetingApiRepository _meetingApiRepository;
  MeetingPendingBloc(this._meetingApiRepository) : super(MeetingPendingInitial()) {
    on<PendingMeetingEvent>((event, emit) async {
      try {
        List<MeetingModel> _result = await _meetingApiRepository.pending(from: event.props[0],to: event.props[1]);
        emit(PendingRetrieve(_result));
      }catch (exception) {
        emit(PendingMeetingError(exception));
      }
    });
    on<UpdatePendingMeetingEvent>((event, emit) async {
      try {
        bool _result = await _meetingApiRepository.update(event.props[0]);
        emit(UpdatePendingMeeting(_result));
      }catch (exception) {
        emit(PendingMeetingError(exception));
      }
    });
  }
}
