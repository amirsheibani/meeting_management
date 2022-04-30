import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meeting_management/logic/member/repository/member_repository.dart';
import 'package:meeting_management/logic/person/model/person.dart';
import 'package:meeting_management/logic/member/model/member_model.dart';

part 'member_event.dart';
part 'member_state.dart';


class MemberBloc extends Bloc<MemberEvent, MemberState> {

  final MemberRepository _memberRepository;
  MemberBloc(this._memberRepository) : super(MemberInitial()) {

    on<AddMemberEvent>((event, emit) async {
      try {
        final bool _result = await _memberRepository.addMember(event.props[0]);
        emit(NewMemberLoadedState(_result));
      } catch (exception) {
        emit(MemberErrorState(exception));
      }
    });
    on<UpdateMemberEvent>((event, emit) async {
      try {
        final bool _result = await _memberRepository.updateMember(event.props[0]);
        emit(UpdateMemberLoadedState(_result));
      } catch (exception) {
        emit(MemberErrorState(exception));
      }
    });
    on<DeleteMemberEvent>((event, emit) async {
      try {
        final bool _result = await _memberRepository.deleteMember(event.props[0]);
        emit(DeleteMemberLoadedState(_result));
      } catch (exception) {
        emit(MemberErrorState(exception));
      }
    });
    on<RetrieveMemberEvent>((event, emit) async {
      try {
        final List<MemberModel> _result = await _memberRepository.members(event.props[0]);
        emit(RetrieveMemberLoadedState(_result));
      } catch (exception) {
        emit(MemberErrorState(exception));
      }
    });


    // on<ShowMemberEvent>((event, emit) async {
    //   try {
    //     emit(ShowMemberLoadedState(event.props[0]));
    //   } catch (exception) {
    //     emit(MemberErrorState(exception));
    //   }
    // });
  }
}
