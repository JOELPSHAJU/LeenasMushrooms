part of 'call_details_bloc.dart';

@immutable
sealed class CallDetailsEvent {}

final class CallDetailsButtonPressEvent extends CallDetailsEvent {
  final CallDetailsModel details;

  CallDetailsButtonPressEvent({required this.details});
}

final class GetCallDetailsEvent extends CallDetailsEvent {
  final int page;
  GetCallDetailsEvent({required this.page});
}
