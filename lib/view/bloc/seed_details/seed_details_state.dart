

part of 'seed_details_bloc.dart';

@immutable
sealed class SeedDetailsState {}

final class SeedDetailsInitial extends SeedDetailsState {}

final class SeedDetailsLoading extends SeedDetailsState {}

final class SeedDetailsSuccess extends SeedDetailsState {}

final class SeedDetailsFailure extends SeedDetailsState {
  final String message;
  SeedDetailsFailure({required this.message});
}

final class SeedFetchSuccess extends SeedDetailsState {
  final List<SeedDetailDisplayModel> seedDetails;
  final bool hasReachedMax;
  final int currentPage;
  SeedFetchSuccess({
    required this.seedDetails,
    required this.hasReachedMax,
    required this.currentPage,
  });
}

final class SeedLoadingMore extends SeedDetailsState {
  final List<SeedDetailDisplayModel> seedDetails;
  final int currentPage;
  final bool hasReachedMax;
  SeedLoadingMore({
    required this.seedDetails,
    required this.currentPage,
    required this.hasReachedMax,
  });
}