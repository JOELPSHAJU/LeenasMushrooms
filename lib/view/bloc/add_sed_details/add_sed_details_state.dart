part of 'add_sed_details_bloc.dart';

@immutable
sealed class AddSedDetailsState {}

final class AddSedDetailsInitial extends AddSedDetailsState {}

final class AddSedDetailsLoading extends AddSedDetailsState {}

final class AddSedDetailsSuccess extends AddSedDetailsState {}

final class AddSedDetailsFailure extends AddSedDetailsState {
  final String message;

  AddSedDetailsFailure({required this.message});
}
