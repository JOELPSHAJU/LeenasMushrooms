import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Add this for date parsing/formatting
import 'package:leenas_mushrooms/controller/local_modals/add_bed_details_post_model.dart';
import 'package:leenas_mushrooms/controller/local_modals/bed_details_display_model.dart';
import 'package:leenas_mushrooms/services/dataverse_repository.dart';

part 'add_bed_details_event.dart';
part 'add_bed_details_state.dart';

class AddBedDetailsBloc extends Bloc<AddBedDetailsEvent, AddBedDetailsState> {
  final DataVerseRepository repo;
  int pageSize = 10;
  AddBedDetailsBloc({required this.repo}) : super(AddBedDetailsInitial()) {
    on<AddBedDetailsButtonPressEvent>(_onAddBedDetailsButtonPressEvent);
    on<GetBedDetailsEvent>(_onGetBedDetailsEvent);
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

  void _onGetBedDetailsEvent(
      GetBedDetailsEvent event, Emitter<AddBedDetailsState> emit) async {
    try {
      List<BedDetailsDisplayModel> existingDetails = [];
      if (state is BedFetchSuccess) {
        existingDetails = (state as BedFetchSuccess).bedDetails;
      } else if (state is BedLoadingMore) {
        existingDetails = (state as BedLoadingMore).bedDetails;
      }

      if (event.page == 1) {
        emit(AddBedDetailsLoading());
      } else {
        emit(BedLoadingMore(
          bedDetails: existingDetails,
          currentPage: event.page - 1,
          hasReachedMax: false, // Will be updated after fetch
        ));
      }

      final response = await repo.getBedDetailsApi(page: event.page);
      log('API Response for page ${event.page}: ${response.toString()}');

      if (response.status == "success" && response.data != null) {
        final newDetails = response.data!.map((datum) {
          DateTime? dateTime = datum.date;
          String formattedDate = dateTime != null
              ? DateFormat('MMMM d, y').format(dateTime)
              : 'Unknown Date';
          return BedDetailsDisplayModel(
            id: datum.id.toString(),
            date: formattedDate,
            harvestTime: datum.harvestTime?.toString() ?? 'Unknown',
            quantity: datum.quantity?.toInt() ?? 0,
            noOfPackets: datum.noOfPackets ?? 0,
            remarks: datum.remarks?.toString() ?? '',
          );
        }).toList();

        log('Fetched ${newDetails.length} items for page ${event.page}');

        final existingIds = existingDetails.map((e) => e.id).toSet();
        final uniqueNewDetails = newDetails
            .where((item) => !existingIds.contains(item.id))
            .toList();

        final updatedDetails = event.page == 1
            ? uniqueNewDetails
            : existingDetails + uniqueNewDetails;

        final hasReachedMax = newDetails.length < pageSize ||
            (response.pagination?.total != null &&
                event.page * pageSize >= response.pagination!.total!);

        emit(BedFetchSuccess(
          bedDetails: updatedDetails,
          hasReachedMax: hasReachedMax,
          currentPage: event.page,
        ));
      } else {
        emit(AddBedDetailsFailure(message: "No data available"));
      }
    } catch (e) {
      log('Error fetching bed details: $e');
      emit(AddBedDetailsFailure(message: e.toString()));
    }
  }
}