import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:leenas_mushrooms/controller/local_modals/sed_details_post_post_model.dart';
import 'package:leenas_mushrooms/controller/local_modals/seed_detail_display_model.dart';
import 'package:leenas_mushrooms/services/dataverse_repository.dart';

part 'seed_details_event.dart';
part 'seed_details_state.dart';

class SeedDetailsBloc extends Bloc<SeedDetailsEvent, SeedDetailsState> {
  final DataVerseRepository repo;
  static const int pageSize = 10;
  SeedDetailsBloc({required this.repo}) : super(SeedDetailsInitial()) {
    on<SeedDetailsButtonPressEvent>(_onAddSedDetailsButtonPressEvent);
    on<GetSeedDetailsEvent>(_onGetSeedDetailsEvent);
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

void _onGetSeedDetailsEvent(
      GetSeedDetailsEvent event, Emitter<SeedDetailsState> emit) async {
    try {
      List<SeedDetailDisplayModel> existingDetails = [];
      if (state is SeedFetchSuccess) {
        existingDetails = (state as SeedFetchSuccess).seedDetails;
      } else if (state is SeedLoadingMore) {
        existingDetails = (state as SeedLoadingMore).seedDetails;
      }

      if (event.page == 1) {
        emit(SeedDetailsLoading());
      } else {
        emit(SeedLoadingMore(
          seedDetails: existingDetails,
          currentPage: event.page - 1,
          hasReachedMax: false,
        ));
      }

      final response = await repo.getSeedDetailsApi(page: event.page);
      log('API Response for page ${event.page}: ${response.toString()}');

      if (response.status == "success" && response.data != null) {
        final newDetails = response.data!.map((datum) {
          DateTime? dateTime = datum.date; // Added null check
          String formattedDate = dateTime != null
              ? DateFormat('MMMM d, y').format(dateTime)
              : 'Unknown Date';
          return SeedDetailDisplayModel(
            id: datum.id.toString(),
            date: formattedDate,
            harvestTime: datum.harvestTime?.toString() ?? 'Unknown',
            quantity: datum.quantity?.toInt() ?? 0, // Added null check
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

        emit(SeedFetchSuccess(
          seedDetails: updatedDetails,
          hasReachedMax: hasReachedMax,
          currentPage: event.page,
        ));
      } else {
        emit(SeedDetailsFailure(message: "No data available"));
      }
    } catch (e) {
      log('Error fetching seed details: $e');
      emit(SeedDetailsFailure(message: e.toString()));
    }
  }
}