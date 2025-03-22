import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Added for date formatting
import 'package:leenas_mushrooms/controller/local_modals/add_mushroom_post_model.dart';
import 'package:leenas_mushrooms/services/dataverse_repository.dart';

part 'add_mushroom_details_event.dart';
part 'add_mushroom_details_state.dart';

class AddMushroomDetailsBloc
    extends Bloc<AddMushroomDetailsEvent, AddMushroomDetailsState> {
  final DataVerseRepository repo;

  AddMushroomDetailsBloc({required this.repo})
      : super(AddMushroomDetailsInitial()) {
    on<AddMushroomDetailsButtonPressEvent>(
        _onAddMushroomDetailsButtonPressEvent);
  }

  void _onAddMushroomDetailsButtonPressEvent(
      AddMushroomDetailsButtonPressEvent event,
      Emitter<AddMushroomDetailsState> emit) async {
    emit(AddMushroomDetailsLoading());

    try {
      // Convert date from "dd/MM/yyyy" to "yyyy-MM-dd"
      final inputFormat = DateFormat('dd/MM/yyyy');
      final outputFormat = DateFormat('yyyy-MM-dd');
      final parsedDate = inputFormat.parse(event.details.date);
      final formattedDate = outputFormat.format(parsedDate);

      final credentials = {
        "date": formattedDate, // Send in "yyyy-MM-dd" format
        "harvest_time": event.details.harvestTime,
        "quantity": event.details.quantity,
        "damage": event.details.damage,
        "remarks": event.details.remarks,
      };

      final response =
          await repo.addMushroomDetailsApi(credentials: credentials);
      log(response.toString());

      if (response.status == "success") {
        emit(AddMushroomDetailsSuccess());
      }
    } catch (e) {
      emit(AddMushroomDetailsFailure(message: e.toString()));
    }
  }
}
