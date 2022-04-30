import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meeting_management/widget/multi_min_widget/people/model/unit_model.dart';
import 'package:meeting_management/widget/multi_min_widget/people/repository/unit_repository.dart';

part 'people_unit_event.dart';
part 'people_unit_state.dart';

class PeopleUnitBloc extends Bloc<PeopleUnitEvent, PeopleUnitState> {
  final UnitRepository _unitRepository;
  PeopleUnitBloc(this._unitRepository) : super(PeopleUnitInitial()) {
    on<AddUnitEvent>((event, emit) async {
      try {
        final UnitModel _result = await _unitRepository.addUnit(event.props[0]);
        emit(NewPeopleUnitLoadedState(_result));
      } catch (exception) {
        emit(PeopleUnitErrorState(exception));
      }
    });
    on<UpdateUnitEvent>((event, emit) async {
      try {
        final bool _result = await _unitRepository.updateUnit(event.props[0]);
        emit(UpdatePeopleUnitLoadedState(_result));
      } catch (exception) {
        emit(PeopleUnitErrorState(exception));
      }
    });
    on<DeleteUnitEvent>((event, emit) async {
      try {
        final bool _result = await _unitRepository.deleteUnit(event.props[0]);
        emit(DeletePeopleUnitLoadedState(_result));
      } catch (exception) {
        emit(PeopleUnitErrorState(exception));
      }
    });
    on<RetrieveUnitEvent>((event, emit) async {
      try {
        final List<UnitModel> _result = await _unitRepository.retrieveUnit(id:event.props[0],searchText: event.props[1]);
        emit(RetrievePeopleUnitLoadedState(_result));
      } catch (exception) {
        emit(PeopleUnitErrorState(exception));
      }
    });
    on<QueryCountUnitEvent>((event, emit) async {
      try {
        final List<UnitModel> _result = await _unitRepository.queryCountUnit(event.props[0]);
        emit(QueryPeopleUnitLoadedState(_result));
      } catch (exception) {
        emit(PeopleUnitErrorState(exception));
      }
    });
    on<QueryUnitEvent>((event, emit) async {
      try {
        final List<UnitModel> _result = await _unitRepository.queryUnit(event.props[0],event.props[1],searchText: event.props[2]);
        emit(QueryCountPeopleUnitLoadedState(_result));
      } catch (exception) {
        emit(PeopleUnitErrorState(exception));
      }
    });
  }
}
