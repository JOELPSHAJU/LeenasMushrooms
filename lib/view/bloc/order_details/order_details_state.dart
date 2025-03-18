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