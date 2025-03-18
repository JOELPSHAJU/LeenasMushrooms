import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:leenas_mushrooms/controller/local_modals/order_details_add_model.dart';
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
        "quantity": event.model.quantity,
        "courier_data": event.model.courierData,
        "courier_provider": event.model.courierProvider,
        "courier_ref_no": event.model.courierRefNo,
        "tracking_id": "",
        "tracking_status": event.model.trackingStatus,
        "payment_status": ""
      };
      final response = await repo.addOrderDetailsApi(credentials: credentials);
      log(response.toString());
      emit(OrderDetailsSucess());
    } catch (e) {
      emit(OrderDetailsError(message: e.toString()));
    }
  }
}
