import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meeting_management/logic/meeting/model/meeting_model.dart';
import 'package:meeting_management/logic/meeting/repository/meetting_api_repository.dart';

part 'calendar_event.dart';
part 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  final MeetingApiRepository _meetingApiRepository;
  CalendarBloc(this._meetingApiRepository) : super(CalendarInitial()) {
    on<CalendarMeetingEvent>((event, emit) async {
      try {
        late List<MeetingModel> _result;
        if(event.props[0] != null && event.props[1] != null ){
          _result = await _meetingApiRepository.retrieveDaily(event.props[0]! as DateTime, to: event.props[1]! as DateTime,searchText: event.props[2]);
        }else{
          _result = await _meetingApiRepository.retrieve();
        }
        emit(CalendarRetrieve(_result));
      }catch (exception) {
        emit(CalendarError(exception));
      }
    });
    on<CalendarMeetingRemoveEvent>((event, emit) async {
      try {
        bool _result = await _meetingApiRepository.delete(event.props[0]);
        emit(CalendarRemoveMeeting(_result));
      }catch (exception) {
        emit(CalendarError(exception));
      }
    });
  }
}
