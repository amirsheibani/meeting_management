import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meeting_management/logic/location/model/location_model.dart';
import 'package:meeting_management/logic/location/repository/location_repository.dart';

part 'location_meeting_event.dart';
part 'location_meeting_state.dart';

class LocationMeetingBloc extends Bloc<LocationMeetingEvent, LocationMeetingState> {
  final LocationRepository _locationRepository;
  LocationMeetingBloc(this._locationRepository) : super(LocationMeetingInitial()) {
    on<RetrieveLocationMeetingEvent>((event, emit) async {
      try {
        List<LocationModel> _result = await _locationRepository.retrieveLocation(event.props[0]);
        emit(LocationMeetingRetrieve(_result));
      }catch (exception) {
        emit(LocationMeetingError(exception));
      }
    });
  }
}
