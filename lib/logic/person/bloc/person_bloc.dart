import 'dart:async';

import 'package:behpardaz_flutter_custom_utility/behpardaz_flutter_custom_utility.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meeting_management/language/bloc/language_state.dart';
import 'package:meeting_management/logic/person/model/person.dart';
import 'package:meeting_management/logic/person/repository/person_api_repository.dart';

part 'person_event.dart';
part 'person_state.dart';

class PersonBloc extends Bloc<PersonEvent, PersonState> {
  final PersonApiRepository _personRepository;
  PersonBloc(this._personRepository) : super(PersonInitial()) {
    on<GetPersonData>((event,emit) async {
      try{
        Person person = await _personRepository.personInfo();
        emit(PersonDataSuccess(false,person));
      }on Exception catch (e){
        emit(PersonDataFailed(e));
      }
    });
    on<UpdateUserInformationEvent>((event,emit) async {
      try{
        await _personRepository.personInfoUpdate(event.person);
        Person person = await _personRepository.personInfo();
        emit(PersonDataSuccess(true,person));
      }on Exception catch (e){
        emit(PersonDataFailed(e));
      }
    });

  }
}
