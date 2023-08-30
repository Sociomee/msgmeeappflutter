// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'get_contact_cubit.dart';

enum GetContactStatus { initial, loading, loaded, error }

class GetContactState extends Equatable {
  final GetContactStatus status;
  final List<Contact> contacts;
  GetContactState({
    required this.status,
    required this.contacts,
  });
  factory GetContactState.initial() {
    return GetContactState(status: GetContactStatus.initial, contacts: []);
  }
  @override
  List<Object> get props => [status, contacts];

  GetContactState copyWith({
    GetContactStatus? status,
    List<Contact>? contacts,
  }) {
    return GetContactState(
      status: status ?? this.status,
      contacts: contacts ?? this.contacts,
    );
  }
}
