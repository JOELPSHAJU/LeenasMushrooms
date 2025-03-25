part of 'add_mushroom_details_bloc.dart';

@immutable
sealed class AddMushroomDetailsState {}

final class AddMushroomDetailsInitial extends AddMushroomDetailsState {}

final class AddMushroomDetailsLoading extends AddMushroomDetailsState {}

final class AddMushroomDetailsSuccess extends AddMushroomDetailsState {}

final class AddMushroomDetailsFailure extends AddMushroomDetailsState {
  final String message;

  AddMushroomDetailsFailure({required this.message});
}
