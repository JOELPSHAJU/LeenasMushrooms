part of 'add_mushroom_details_bloc.dart';

@immutable
sealed class MushroomDetailsEvent {}

final class MushroomDetailsButtonPressEvent extends MushroomDetailsEvent {
  final MushroomDetailsPostModel details;

  MushroomDetailsButtonPressEvent({required this.details});
}

final class GetMushroomDetailsEvent extends MushroomDetailsEvent{
  final int page;

  GetMushroomDetailsEvent({required this.page});

}