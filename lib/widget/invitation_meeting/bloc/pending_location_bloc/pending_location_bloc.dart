import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meeting_management/logic/location/model/location_model.dart';
import 'package:meeting_management/logic/location/repository/location_repository.dart';

part 'pending_location_event.dart';
part 'pending_location_state.dart';

class PendingLocationBloc extends Bloc<PendingLocationEvent, PendingLocationState> {
  final LocationRepository _locationRepository;
  PendingLocationBloc(this._locationRepository) : super(PendingLocationInitial()) {
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
