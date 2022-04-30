import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meeting_management/logic/member/model/member.dart';
import 'package:meeting_management/logic/member/model/member_model.dart';
import 'package:meeting_management/logic/member/repository/member_repository.dart';

part 'invite_people_event.dart';
part 'invite_people_state.dart';

class InvitePeopleBloc extends Bloc<InvitePeopleEvent, InvitePeopleState> {
  final MemberRepository _memberRepository;
  InvitePeopleBloc(this._memberRepository) : super(InvitePeopleInitial()) {
    on<MemberInviteEvent>((event, emit) async {
      try {
        emit(MemberInviteLoadedState([event.props[0]]));
      } catch (exception) {
        emit(InvitePeopleDropdownErrorState(exception));
      }
    });
    on<MemberRemoveEvent>((event, emit) async {
      try {
        emit(MemberRemoveLoadedState([event.props[0]]));
      } catch (exception) {
        emit(InvitePeopleDropdownErrorState(exception));
      }
    });
    on<GroupMemberInviteEvent>((event, emit) async {
      try {
        List<MemberModel> _memberModels = await _memberRepository.members(event.props[0]);
        debugPrint('_memberModels: ${_memberModels.length}');
        List<Member> _result = [];
        for (var element in _memberModels) {
          _result.add(element.member!);
        }
        emit(MemberInviteLoadedState(_result));
      } catch (exception) {
        emit(InvitePeopleDropdownErrorState(exception));
      }
    });
  }
}
