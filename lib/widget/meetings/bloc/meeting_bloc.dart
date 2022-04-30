import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meeting_management/logic/meeting/model/meeting_model.dart';
import 'package:meeting_management/logic/meeting/repository/meetting_api_repository.dart';

part 'meeting_event.dart';
part 'meeting_state.dart';

class MeetingBloc extends Bloc<MeetingEvent, MeetingState> {
  final MeetingApiRepository _meetingApiRepository;
  MeetingBloc(this._meetingApiRepository) : super(MeetingInitial()) {
    on<RetrieveMeetingEvent>((event, emit) async {
      try {
        late List<MeetingModel> _result;
        if(event.props[0] != null && event.props[1] != null ){
          _result = await _meetingApiRepository.retrieveDaily(event.props[0]! as DateTime,to: event.props[1]! as DateTime);
        }else{
          _result = await _meetingApiRepository.retrieve();
        }
        emit(MeetingRetrieve(_result));
      }catch (exception) {
        emit(MeetingError(exception));
      }
    });
  }
}
