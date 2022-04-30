
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meeting_management/widget/multi_min_widget/people_group/model/group_type_model.dart';
import 'package:meeting_management/widget/multi_min_widget/people_group/model/people_group_model.dart';
import 'package:meeting_management/widget/multi_min_widget/people_group/repository/people_group_repository.dart';

part 'people_group_event.dart';
part 'people_group_state.dart';

class PeopleGroupBloc extends Bloc<PeopleGroupEvent, PeopleGroupState> {
  final PeopleGroupRepository _peopleGroupRepository;
  PeopleGroupBloc(this._peopleGroupRepository) : super(PeopleGroupInitial()) {
    on<AddPeopleGroupEvent>((event, emit) async {
      try {
        final bool _result = await _peopleGroupRepository.addPeopleGroup(event.props[0]);
        emit(NewPeopleGroupLoadedState(_result));
      } catch (exception) {
        emit(PeopleGroupErrorState(exception));
      }
    });
    on<UpdatePeopleGroupEvent>((event, emit) async {
      try {
        final bool _result = await _peopleGroupRepository.updatePeopleGroup(event.props[0]);
        emit(UpdatePeopleGroupLoadedState(_result));
      } catch (exception) {
        emit(PeopleGroupErrorState(exception));
      }
    });
    on<DeletePeopleGroupEvent>((event, emit) async {
      try {
        final bool _result = await _peopleGroupRepository.deletePeopleGroup(event.props[0]);
        emit(DeletePeopleGroupLoadedState(_result));
      } catch (exception) {
        emit(PeopleGroupErrorState(exception));
      }
    });
    on<RetrievePeopleGroupEvent>((event, emit) async {
      try {
        final List<PeopleGroupModel> _result = await _peopleGroupRepository.retrievePeopleGroup(id:event.props[0],searchText: event.props[1]);
        emit(RetrievePeopleGroupLoadedState(_result));
      } catch (exception) {
        emit(PeopleGroupErrorState(exception));
      }
    });

    on<RetrievePeopleGroupTypeEvent>((event, emit) async {
      try {
        final List<GroupTypeModel> _result = await _peopleGroupRepository.retrievePeopleGroupType(id:event.props[0]);
        emit(RetrievePeopleGroupTypeLoadedState(_result));
      } catch (exception) {
        emit(PeopleGroupErrorState(exception));
      }
    });

    on<ShowPeopleGroupEvent>((event, emit) async {
      try {
        emit(ShowPeopleGroupLoadedState(event.props[0]));
      } catch (exception) {
        emit(PeopleGroupErrorState(exception));
      }
    });

  }
}
