part of 'add_call_details_bloc.dart';

@immutable
sealed class AddCallDetailsEvent {}

final class AddCallDetailsButtonPressEvent extends AddCallDetailsEvent {
  final CallDetailsPostModel details;

  AddCallDetailsButtonPressEvent({required this.details});
}
