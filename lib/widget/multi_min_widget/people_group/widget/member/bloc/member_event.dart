part of 'member_bloc.dart';

abstract class MemberEvent extends Equatable {
  const MemberEvent();
}

class AddTempMemberEvent extends MemberEvent {
  final String memberModel;

  const AddTempMemberEvent({required this.memberModel});
  @override
  List<String> get props => [memberModel];
}
class AddMemberEvent extends MemberEvent {
  final MemberModel memberModel;

  const AddMemberEvent({required this.memberModel});
  @override
  List<MemberModel> get props => [memberModel];
}
class UpdateMemberEvent extends MemberEvent {
  final MemberModel memberModel;

  const UpdateMemberEvent({required this.memberModel});
  @override
  List<MemberModel> get props => [memberModel];
}
class DeleteMemberEvent extends MemberEvent {
  final int id;

  const DeleteMemberEvent({required this.id});
  @override
  List<int> get props => [id];
}
class RetrieveMemberEvent extends MemberEvent {
  final int id;

  const RetrieveMemberEvent(this.id);
  @override
  List<dynamic> get props => [id];
}



// class ShowMemberEvent extends MemberEvent {
//   final MemberModel memberModel;
//
//   const ShowMemberEvent(this.memberModel);
//   @override
//   List<dynamic> get props => [memberModel];
// }