part of 'add_call_details_bloc.dart';

@immutable
sealed class AddCallDetailsState {}

final class AddCallDetailsInitial extends AddCallDetailsState {}

final class AddCallDetailsLoading extends AddCallDetailsState {}

final class AddCallDetailsSuccess extends AddCallDetailsState {}

final class AddCallDetailsFailure extends AddCallDetailsState {
  final String message;

  AddCallDetailsFailure({required this.message});
}
