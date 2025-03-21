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
