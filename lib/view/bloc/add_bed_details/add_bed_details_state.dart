part of 'add_bed_details_bloc.dart';

@immutable
sealed class AddBedDetailsState {}

final class AddBedDetailsInitial extends AddBedDetailsState {}

final class AddBedDetailsLoading extends AddBedDetailsState {}

final class AddBedDetailsSuccess extends AddBedDetailsState {}

final class AddBedDetailsFailure extends AddBedDetailsState {
  final String message;

  AddBedDetailsFailure({required this.message});
}

final class BedFetchSuccess extends AddBedDetailsState {
  final List<BedDetailsDisplayModel> bedDetails;
  final bool hasReachedMax;
  final int currentPage;

  BedFetchSuccess({
    required this.bedDetails,
    required this.hasReachedMax,
    required this.currentPage,
  });
}

final class BedLoadingMore extends AddBedDetailsState {
  final List<BedDetailsDisplayModel> bedDetails;
  final int currentPage;
  final bool hasReachedMax;

  BedLoadingMore({
    required this.bedDetails,
    required this.currentPage,
    required this.hasReachedMax,
  });
}