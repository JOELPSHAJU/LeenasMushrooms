import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:leenas_mushrooms/controller/local_modals/call_details_add_model.dart';
import 'package:leenas_mushrooms/services/api_services.dart';
import 'package:meta/meta.dart';

part 'add_call_details_event.dart';
part 'add_call_details_state.dart';

class AddCallDetailsBloc
    extends Bloc<AddCallDetailsEvent, AddCallDetailsState> {
  final ApiService apiService;
  AddCallDetailsBloc({required this.apiService})
      : super(AddCallDetailsInitial()) {
    on<AddCallDetailsButtonPressEvent>(_onAddCallDetailsButtonPressEvent);
  }
  void _onAddCallDetailsButtonPressEvent(AddCallDetailsButtonPressEvent event,
      Emitter<AddCallDetailsState> emit) async {
    emit(AddCallDetailsLoading());
    try {
      final response = await apiService.addCallDetails({
        "date": event.details.date,
        "call_type": event.details.callType,
        "name": event.details.name,
        "phone_number": event.details.phoneNumber,
        "purpose": event.details.purpose,
        "current_status": event.details.currentStatus
      });
      log(response.toString());
      emit(AddCallDetailsSuccess());
    } catch (e) {
      emit(AddCallDetailsFailure(message: e.toString()));
    }
  }
}
