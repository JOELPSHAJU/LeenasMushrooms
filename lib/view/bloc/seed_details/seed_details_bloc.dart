import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:leenas_mushrooms/controller/local_modals/sed_details_post_post_model.dart';
import 'package:leenas_mushrooms/services/dataverse_repository.dart';

part 'seed_details_event.dart';
part 'seed_details_state.dart';

class SeedDetailsBloc extends Bloc<SeedDetailsEvent, SeedDetailsState> {
  final DataVerseRepository repo;
  SeedDetailsBloc({required this.repo}) : super(SeedDetailsInitial()) {
    on<SeedDetailsButtonPressEvent>(_onAddSedDetailsButtonPressEvent);
  }

  void _onAddSedDetailsButtonPressEvent(
      SeedDetailsButtonPressEvent event, Emitter<SeedDetailsState> emit) async {
    emit(SeedDetailsLoading());

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
        emit(SeedDetailsSuccess());
      }
    } catch (e) {
      emit(SeedDetailsFailure(message: e.toString()));
    }
  }
  
}
