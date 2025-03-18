part of 'order_details_bloc.dart';

@immutable
sealed class OrderDetailsEvent {}

final class SubmitOrderDetailsEvent extends OrderDetailsEvent{
  final OrderDetailsAddModel model;

  SubmitOrderDetailsEvent({required this.model});
}