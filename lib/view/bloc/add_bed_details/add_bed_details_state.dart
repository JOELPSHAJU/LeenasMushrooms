part of 'add_bed_details_bloc.dart';

// States
@immutable
sealed class AddBedDetailsState {}

final class AddBedDetailsInitial extends AddBedDetailsState {}

final class AddBedDetailsLoading extends AddBedDetailsState {}

final class AddBedDetailsSuccess extends AddBedDetailsState {}

final class AddBedDetailsFailure extends AddBedDetailsState {
  final String message;

  AddBedDetailsFailure({required this.message});
}
