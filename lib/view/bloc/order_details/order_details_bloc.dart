import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:leenas_mushrooms/model/order_details_add_model.dart';
import 'package:leenas_mushrooms/services/dataverse_repository.dart';
import 'package:meta/meta.dart';

part 'order_details_event.dart';
part 'order_details_state.dart';

class OrderDetailsBloc extends Bloc<OrderDetailsEvent, OrderDetailsState> {
  final DataVerseRepository repo;
  OrderDetailsBloc({required this.repo}) : super(OrderDetailsInitial()) {
    on<SubmitOrderDetailsEvent>(_onSubmitOrderDetailsEvent);
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
        log(response.status??"");
        emit(OrderDetailsSucess());
      }
      {
        emit(OrderDetailsError(message: "response error"));
      }
    } catch (e) {
      emit(OrderDetailsError(message: e.toString()));
    }
  }
}
