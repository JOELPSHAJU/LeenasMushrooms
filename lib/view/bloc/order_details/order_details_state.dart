part of 'order_details_bloc.dart';

@immutable
sealed class OrderDetailsState {}

final class OrderDetailsInitial extends OrderDetailsState {}

final class OrderDetailsLoading extends OrderDetailsState {}

final class OrderDetailsSucess extends OrderDetailsState {}

final class OrderDetailsError extends OrderDetailsState {
  final String message;
   OrderDetailsError({required this.message});
}
class OrderLoadingMore extends OrderDetailsState {
  final List<OrderDetailsDisplayModel> orderDetails;
  final int currentPage;

  OrderLoadingMore({
    required this.orderDetails,
    required this.currentPage,
  });
}

class OrderFetchSuccess extends OrderDetailsState {
  final List<OrderDetailsDisplayModel> orderDetails;
  final bool hasReachedMax;
  final int currentPage;

  OrderFetchSuccess({
    required this.orderDetails,
    required this.hasReachedMax,
    required this.currentPage,
  });
}