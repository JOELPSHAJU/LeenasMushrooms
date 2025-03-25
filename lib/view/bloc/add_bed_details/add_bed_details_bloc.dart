import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Add this for date parsing/formatting
import 'package:leenas_mushrooms/controller/local_modals/add_bed_details_post_model.dart';
import 'package:leenas_mushrooms/services/dataverse_repository.dart';

part 'add_bed_details_event.dart';
part 'add_bed_details_state.dart';

class AddBedDetailsBloc extends Bloc<AddBedDetailsEvent, AddBedDetailsState> {
  final DataVerseRepository repo;

  AddBedDetailsBloc({required this.repo}) : super(AddBedDetailsInitial()) {
    on<AddBedDetailsButtonPressEvent>(_onAddBedDetailsButtonPressEvent);
  }

  void _onAddBedDetailsButtonPressEvent(AddBedDetailsButtonPressEvent event,
      Emitter<AddBedDetailsState> emit) async {
    emit(AddBedDetailsLoading());

    try {
      // Parse the date from "dd/MM/yyyy" to "yyyy-MM-dd"
      final inputFormat = DateFormat('dd/MM/yyyy');
      final outputFormat = DateFormat('yyyy-MM-dd');
      final parsedDate = inputFormat.parse(event.details.date);
      final formattedDate = outputFormat.format(parsedDate);

      final credentials = {
        "date":
            formattedDate, // Send in "yyyy-MM-dd" format (e.g., "2025-03-22")
        "harvest_time": event.details.harvestTime,
        "quantity": event.details.quantity,
        "no_of_packets": event.details.noOfPackets,
        "remarks": event.details.remarks,
      };

      final response = await repo.addBedDetailsApi(credentials: credentials);
      log(response.toString());

      if (response.status == "success") {
        emit(AddBedDetailsSuccess());
      }
    } catch (e) {
      emit(AddBedDetailsFailure(message: e.toString()));
    }
  }
}
