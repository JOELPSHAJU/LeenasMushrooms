part of 'seed_details_bloc.dart';

@immutable
sealed class SeedDetailsEvent {}

final class SeedDetailsButtonPressEvent extends SeedDetailsEvent {
  final SedHarvestDetailsPostModel details;

  SeedDetailsButtonPressEvent({required this.details});
}
final class GetSeedDetailsEvent extends SeedDetailsEvent{
  final int page;

  GetSeedDetailsEvent({required this.page});

}