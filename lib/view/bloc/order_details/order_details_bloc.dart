import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import 'package:leenas_mushrooms/controller/local_modals/order_details_display_model.dart';
import 'package:leenas_mushrooms/model/order_details_add_model.dart';
import 'package:leenas_mushrooms/services/dataverse_repository.dart';
import 'package:meta/meta.dart';

part 'order_details_event.dart';
part 'order_details_state.dart';

class OrderDetailsBloc extends Bloc<OrderDetailsEvent, OrderDetailsState> {
  final DataVerseRepository repo;
  OrderDetailsBloc({required this.repo}) : super(OrderDetailsInitial()) {
    on<SubmitOrderDetailsEvent>(_onSubmitOrderDetailsEvent);
    on<GetOrderDetailsEvent>(_onGetOrderDetailsEvent);
  }
  void _onSubmitOrderDetailsEvent(
      SubmitOrderDetailsEvent event, Emitter<OrderDetailsState> emit) async {
    emit(OrderDetailsLoading());

    try {
      final credentials = {
        "date": event.model.date,
        "item": "",
        "order_type": event.model.orderType,
        "name": event.model.name,
        "address": event.model.address,
        "pincode": event.model.pincode,
        "phone_number": event.model.phoneNumber,
        "catalogue": event.model.catalogue,
        "quantity": int.parse(event.model.quantity),
        "courier_data": event.model.courierData,
        "courier_provider": event.model.courierProvider,
        "courier_ref_no": event.model.courierRefNo,
        "tracking_id": "",
        "tracking_status": event.model.trackingStatus,
        "payment_status": ""
      };
      final response = await repo.addOrderDetailsApi(credentials: credentials);
      if (response.status == "success") {
        log(response.status ?? "");
        emit(OrderDetailsSucess());
      } else {
        emit(OrderDetailsError(message: "response error"));
      }
    } catch (e) {
      emit(OrderDetailsError(message: e.toString()));
    }
  }

  void _onGetOrderDetailsEvent(
      GetOrderDetailsEvent event, Emitter<OrderDetailsState> emit) async {
    log('Fetching income details for page: ${event.page}');

    // Initial load or refresh
    if (event.page == 1) {
      emit(OrderDetailsLoading());
    } else if (state is OrderFetchSuccess) {
      final currentState = state as OrderFetchSuccess;
      emit(OrderLoadingMore(
          orderDetails: currentState.orderDetails,
          currentPage: currentState.currentPage));
    }

    try {
      final response = await repo.getOrderDetailsApi(page: event.page);
      log('API Response: ${response.toString()}');

      if (response.status == "success" && response.data != null) {
        List<OrderDetailsDisplayModel> newOrderDetail =
            response.data!.map((datum) {
          DateTime dateTime = datum.date!;
          String formattedDate = DateFormat('MMMM d, y').format(dateTime);
          return OrderDetailsDisplayModel(
              id: datum.id.toString(),
              date: formattedDate,
              item: datum.item.toString(),
              orderType: datum.orderType.toString(),
              name: datum.name.toString(),
              address: datum.address.toString(),
              pincode: datum.pincode.toString(),
              phoneNumber: datum.phoneNumber.toString(),
              catalogue: datum.catalogue.toString(),
              quantity: datum.quantity!.toInt(),
              courierData: datum.courierData.toString(),
              courierProvider: datum.courierProvider.toString(),
              courierRefNo: datum.courierRefNo.toString(),
              trackingId: datum.trackingId.toString(),
              trackingStatus: datum.trackingStatus.toString(),
              paymentStatus: datum.paymentStatus.toString(),
              createdAt: datum.createdAt!,
              updatedAt: datum.updatedAt!,
              v: datum.v!.toInt());
        }).toList();

        log('Fetched items: ${newOrderDetail.length}');

        // Determine if we've reached the end of pagination
        const int limit = 10; // Matches the limit in the API call
        bool hasReachedMax = newOrderDetail.length < limit ||
            (response.pagination?.totalPages != null &&
                event.page >= response.pagination!.totalPages!);

        if (event.page == 1) {
          emit(OrderFetchSuccess(
            orderDetails: newOrderDetail,
            hasReachedMax: hasReachedMax,
            currentPage: event.page,
          ));
        } else if (state is OrderLoadingMore) {
          final currentState = state as OrderLoadingMore;
          emit(OrderFetchSuccess(
            orderDetails: currentState.orderDetails + newOrderDetail,
            hasReachedMax: hasReachedMax,
            currentPage: event.page,
          ));
        }
      } else {
        log('API returned no success or no data');
        emit(OrderDetailsError(message: "Failed to fetch income details"));
      }
    } catch (e) {
      log('Error fetching income details: $e');
      emit(OrderDetailsError(message: e.toString()));
    }
  }
}
