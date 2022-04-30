import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meeting_management/widget/multi_min_widget/people/model/people_model.dart';
import 'package:meeting_management/widget/multi_min_widget/people/repository/people_repository.dart';

part 'people_event.dart';
part 'people_state.dart';

class PeopleBloc extends Bloc<PeopleEvent, PeopleState> {
  final PeopleRepository _peopleRepository;
  PeopleBloc(this._peopleRepository) : super(PeopleInitial()) {
    on<AddPeopleEvent>((event, emit) async {
      try {
        final bool _result = await _peopleRepository.addPeople(event.props[0]);
        emit(NewPeopleLoadedState(_result));
      } catch (exception) {
        emit(PeopleErrorState(exception));
      }
    });
    on<UpdatePeopleEvent>((event, emit) async {
      try {
        final bool _result = await _peopleRepository.updatePeople(event.props[0]);
        emit(UpdatePeopleLoadedState(_result));
      } catch (exception) {
        emit(PeopleErrorState(exception));
      }
    });
    on<DeletePeopleEvent>((event, emit) async {
      try {
        final bool _result = await _peopleRepository.deletePeople(event.props[0]);
        emit(DeletePeopleLoadedState(_result));
      } catch (exception) {
        emit(PeopleErrorState(exception));
      }
    });
    on<RetrievePeopleEvent>((event, emit) async {
      try {
        final List<PeopleModel> _result = await _peopleRepository.retrievePeople(id:event.props[0]);
        emit(RetrievePeopleLoadedState(_result));
      } catch (exception) {
        emit(PeopleErrorState(exception));
      }
    });
    on<QueryCountPeopleEvent>((event, emit) async {
      try {
        final List<PeopleModel> _result = await _peopleRepository.queryCountPeople(event.props[0]);
        emit(QueryCountPeopleLoadedState(_result));
      } catch (exception) {
        emit(PeopleErrorState(exception));
      }
    });
    on<QueryPeopleEvent>((event, emit) async {
      try {
        final List<PeopleModel> _result = await _peopleRepository.queryPeople(event.props[0],event.props[1],searchText: event.props[2]);
        emit(QueryPeopleLoadedState(_result));
      } catch (exception) {
        emit(PeopleErrorState(exception));
      }
    });
    on<ShowPeopleEvent>((event, emit) async {
      try {
        emit(ShowPeopleLoadedState(event.props[0]));
      } catch (exception) {
        emit(PeopleErrorState(exception));
      }
    });
  }
}
