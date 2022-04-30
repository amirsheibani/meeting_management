import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meeting_management/logic/member/model/member.dart';
import 'package:meeting_management/logic/member/repository/member_repository.dart';
import 'package:meeting_management/widget/multi_min_widget/people_group/model/people_group_model.dart';

part 'invite_people_dropdown_event.dart';
part 'invite_people_dropdown_state.dart';

class InvitePeopleDropdownBloc extends Bloc<InvitePeopleDropdownEvent, InvitePeopleDropdownState> {
  final MemberRepository _memberRepository;
  InvitePeopleDropdownBloc(this._memberRepository) : super(InvitePeopleDropdownInitial()) {
    on<RetrievePeoplesDropdownEvent>((event, emit) async {
      try {
        List<PeopleGroupModel> groups = await _memberRepository.retrievePeopleGroup();
        List<Member> members = await _memberRepository.allPerson();
        final List<Object> _result = [];
        _result.addAll(members);
        _result.addAll(groups);
        emit(RetrieveInvitePeopleDropdownLoadedState(_result));
      } catch (exception) {
        emit(InvitePeopleDropdownErrorState(exception));
      }
    });
  }
}
