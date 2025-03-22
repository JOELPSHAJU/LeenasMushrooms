part of 'add_mushroom_details_bloc.dart';

@immutable
sealed class AddMushroomDetailsEvent {}

final class AddMushroomDetailsButtonPressEvent extends AddMushroomDetailsEvent {
  final AddMushroomDetailsPostModel details;

  AddMushroomDetailsButtonPressEvent({required this.details});
}
