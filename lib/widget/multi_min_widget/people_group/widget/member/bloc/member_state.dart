part of 'member_bloc.dart';


abstract class MemberState extends Equatable {
  const MemberState();
}

class MemberInitial extends MemberState {
  @override
  List<Object> get props => [];
}

class NewMemberLoadedState extends MemberState {
  final bool status;
  const NewMemberLoadedState(this.status);
  @override
  List<Object?> get props => [status];
}
class UpdateMemberLoadedState extends MemberState {
  final bool status;
  const UpdateMemberLoadedState(this.status);
  @override
  List<Object?> get props => [status];
}
class DeleteMemberLoadedState extends MemberState {
  final bool status;
  const DeleteMemberLoadedState(this.status);
  @override
  List<Object?> get props => [status];
}
class RetrieveMemberLoadedState extends MemberState {
  final List<MemberModel> memberModels;
  const RetrieveMemberLoadedState(this.memberModels);
  @override
  List<List<MemberModel>?> get props => [memberModels];
}

class ShowMemberLoadedState extends MemberState {
  final String memberModel;
  const ShowMemberLoadedState(this.memberModel);
  @override
  List<String?> get props => [memberModel];
}
class GetAllPersonState extends MemberState{
  final List<Person> items;

  const GetAllPersonState(this.items);

  @override
  List<List<Person>?> get props => [items];

}

class MemberErrorState extends MemberState {
  final dynamic error;
  const MemberErrorState(this.error);
  @override
  List<dynamic> get props => [error];
}