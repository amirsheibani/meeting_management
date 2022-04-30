import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meeting_management/logic/member/model/member.dart';
import 'package:meeting_management/logic/member/repository/member_repository.dart';

part 'person_dropdown_event.dart';
part 'person_dropdown_state.dart';

class PersonDropdownBloc extends Bloc<PersonDropdownEvent, PersonDropdownState> {
  final MemberRepository _memberRepository;
  PersonDropdownBloc(this._memberRepository) : super(PersonDropdownInitial()) {
    on<GetAllPersonEvent>((event,emit) async {
      try{
        List<Member> members = await _memberRepository.allPerson();
        emit(GetAllPersonState(members));
      }on Exception catch (e){
        emit(PersonDropdownErrorState(e));
      }
    });
  }
}
