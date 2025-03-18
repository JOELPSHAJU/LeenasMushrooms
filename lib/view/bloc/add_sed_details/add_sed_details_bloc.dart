import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:leenas_mushrooms/controller/local_modals/sed_details_post_post_model.dart';
import 'package:leenas_mushrooms/services/dataverse_repository.dart';

part 'add_sed_details_event.dart';
part 'add_sed_details_state.dart';

class AddSedDetailsBloc extends Bloc<AddSedDetailsEvent, AddSedDetailsState> {
  final DataVerseRepository repo;
  AddSedDetailsBloc({required this.repo}) : super(AddSedDetailsInitial()) {
    on<AddSedDetailsButtonPressEvent>(_onAddSedDetailsButtonPressEvent);
  }

  void _onAddSedDetailsButtonPressEvent(AddSedDetailsButtonPressEvent event,
      Emitter<AddSedDetailsState> emit) async {
    emit(AddSedDetailsLoading());

    try {
      final credentials = {
        "date": event.details.date,
        "harvest_time": event.details.harvestTime,
        "quantity": event.details.quantity,
        "no_of_packets": event.details.noOfPackets,
        "remarks": event.details.remarks,
      };

      final response = await repo.addSeedDetailsApi(credentials: credentials);
      log(response.toString());
      if (response.status == "success") {
        emit(AddSedDetailsSuccess());
      }
    } catch (e) {
      emit(AddSedDetailsFailure(message: e.toString()));
    }
  }
}
