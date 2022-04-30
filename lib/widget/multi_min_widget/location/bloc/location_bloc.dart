import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meeting_management/logic/location/model/location_model.dart';
import 'package:meeting_management/logic/location/repository/location_repository.dart';


part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationRepository _locationRepository;
  LocationBloc(this._locationRepository) : super(LocationInitial()) {
    on<AddLocationEvent>((event, emit) async {
      try {
        final bool _result = await _locationRepository.addLocation(event.props[0]);
        emit(NewLocationLoadedState(_result));
      } catch (exception) {
        emit(LocationErrorState(exception));
      }
    });
    on<UpdateLocationEvent>((event, emit) async {
      try {
        final bool _result = await _locationRepository.updateLocation(event.props[0]);
        emit(UpdateLocationLoadedState(_result));
      } catch (exception) {
        emit(LocationErrorState(exception));
      }
    });
    on<DeleteLocationEvent>((event, emit) async {
      try {
        final bool _result = await _locationRepository.deleteLocation(event.props[0]);
        emit(DeleteLocationLoadedState(_result));
      } catch (exception) {
        emit(LocationErrorState(exception));
      }
    });
    on<RetrieveLocationEvent>((event, emit) async {
      try {
        final List<LocationModel> _result = await _locationRepository.retrieveLocation(event.props[0],searchText: event.props[1]);
        emit(RetrieveLocationLoadedState(_result));
      } catch (exception) {
        emit(LocationErrorState(exception));
      }
    });
    on<ShowLocationEvent>((event, emit) async {
      try {
        emit(ShowLocationState(event.props[0]));
      } catch (exception) {
        emit(LocationErrorState(exception));
      }
    });
  }
}
