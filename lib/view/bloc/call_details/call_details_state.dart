part of 'call_details_bloc.dart';

@immutable
sealed class CallDetailsState {}

final class CallDetailsInitial extends CallDetailsState {}

final class CallDetailsLoading extends CallDetailsState {}

class CallDetailsLoadingMore extends CallDetailsState {
  final List<CallDetailsModel> callDetails;
  final int currentPage;

  CallDetailsLoadingMore(
      {required this.callDetails, required this.currentPage});
}

final class CallDetailsSuccess extends CallDetailsState {
  final List<CallDetailsModel>? callDetails;

  CallDetailsSuccess({this.callDetails});
}

final class CallDetailsFailure extends CallDetailsState {
  final String message;

  CallDetailsFailure({required this.message});
}

class CallDetailsFetchSuccess extends CallDetailsState {
  final List<CallDetailsModel> callDetails;

  final bool hasReachedMax;
  final int currentPage;

  CallDetailsFetchSuccess({
    required this.callDetails,

    this.hasReachedMax = false,
    this.currentPage = 1,
  });
  @override
  List<Object> get props =>
      [callDetails, hasReachedMax, currentPage];
}
