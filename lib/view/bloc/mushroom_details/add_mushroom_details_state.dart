part of 'add_mushroom_details_bloc.dart';

@immutable
sealed class MushroomDetailsState {}

final class MushroomDetailsInitial extends MushroomDetailsState {}

final class MushroomDetailsLoading extends MushroomDetailsState {}

final class MushroomDetailsSuccess extends MushroomDetailsState {}

final class MushroomDetailsFailure extends MushroomDetailsState {
  final String message;

  MushroomDetailsFailure({required this.message});
}

class MushroomFetchSuccess extends MushroomDetailsState {
  final List<MushroomDetailDisplayModel> mushroomDetails;
  final bool hasReachedMax;
  final int currentPage;

  MushroomFetchSuccess({
    required this.mushroomDetails,
    required this.hasReachedMax,
    required this.currentPage,
  });
}

class MushroomLoadingMore extends MushroomDetailsState {
  final List<MushroomDetailDisplayModel> mushroomDetails;
  final int currentPage;
  final bool hasReachedMax;

  MushroomLoadingMore({
    required this.hasReachedMax,
    required this.mushroomDetails,
    required this.currentPage,
  });
}
