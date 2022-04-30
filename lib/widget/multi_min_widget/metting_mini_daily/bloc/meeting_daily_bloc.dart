import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meeting_management/logic/meeting/model/meeting_model.dart';
import 'package:meeting_management/logic/meeting/repository/meetting_api_repository.dart';

part 'meeting_daily_event.dart';
part 'meeting_daily_state.dart';

class MeetingDailyBloc extends Bloc<MeetingDailyEvent, MeetingDailyState> {
  final MeetingApiRepository _meetingApiRepository;
  MeetingDailyBloc(this._meetingApiRepository) : super(MeetingDailyInitial()) {
    on<RetrieveMeetingDailyEvent>((event, emit) async {
      try {
        late List<MeetingModel> _result;
        if(event.props[0] != null && event.props[1] != null ){
          _result = await _meetingApiRepository.retrieveDaily(event.props[0]! as DateTime,to: event.props[1]! as DateTime);
        }else{
          _result = await _meetingApiRepository.retrieve();
        }
        emit(MeetingDailyRetrieve(_result,event.props[0]! as DateTime));
      }catch (exception) {
        emit(MeetingDailyError(exception));
      }
    });
  }
}
