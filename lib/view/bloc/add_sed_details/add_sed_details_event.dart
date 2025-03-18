part of 'add_sed_details_bloc.dart';

@immutable
sealed class AddSedDetailsEvent {}

final class AddSedDetailsButtonPressEvent extends AddSedDetailsEvent {
  final SedHarvestDetailsPostModel details;

  AddSedDetailsButtonPressEvent({required this.details});
}
