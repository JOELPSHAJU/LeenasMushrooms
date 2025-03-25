part of 'add_bed_details_bloc.dart';

@immutable
sealed class AddBedDetailsEvent {}

final class AddBedDetailsButtonPressEvent extends AddBedDetailsEvent {
  final AddBedDetailsPostModel details;

  AddBedDetailsButtonPressEvent({required this.details});
}
