import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meeting_management/logic/meeting/model/meeting_model.dart';
import 'package:meeting_management/logic/meeting/repository/meetting_api_repository.dart';

part 'set_meeting_event.dart';
part 'set_meeting_state.dart';

class SetMeetingBloc extends Bloc<SetMeetingEvent, SetMeetingState> {
  final MeetingApiRepository _meetingApiRepository;
  SetMeetingBloc(this._meetingApiRepository) : super(SetMeetingInitial()) {
    on<AddNewMeetingEvent>((event, emit) async {
      try {
        final bool _result = await _meetingApiRepository.add(event.props[0]);

        emit(MeetingAddNew(_result));
      }catch (exception) {
        emit(MeetingError(exception));
      }
    });
    on<UpdateMeetingEvent>((event, emit) async {
      try {
        final bool _result = await _meetingApiRepository.update(event.props[0]);
        emit(MeetingRemove(_result));
      }catch (exception) {
        emit(MeetingError(exception));
      }
    });
    on<RemoveMeetingEvent>((event, emit) async {
      try {
        final bool _result = await _meetingApiRepository.delete(event.props[0]);
        emit(MeetingRemove(_result));
      }catch (exception) {
        emit(MeetingError(exception));
      }
    });
    on<CancelMeetingEvent>((event, emit) async {
      try {
        final bool _result = await _meetingApiRepository.cancel(event.props[0]);
        emit(MeetingCancel(_result));
      }catch (exception) {
        emit(MeetingError(exception));
      }
    });
    on<ResumeMeetingEvent>((event, emit) async {
      try {
        final bool _result = await _meetingApiRepository.resume(event.props[0]);
        emit(MeetingResume(_result));
      }catch (exception) {
        emit(MeetingError(exception));
      }
    });
    on<StartMeetingEvent>((event, emit) async {
      try {
        final bool _result = await _meetingApiRepository.start(event.props[0]);
        emit(MeetingStart(_result));
      }catch (exception) {
        emit(MeetingError(exception));
      }
    });
    on<CompleteMeetingEvent>((event, emit) async {
      try {
        final bool _result = await _meetingApiRepository.complete(event.props[0]);
        emit(MeetingComplete(_result));
      }catch (exception) {
        emit(MeetingError(exception));
      }
    });
  }
}
