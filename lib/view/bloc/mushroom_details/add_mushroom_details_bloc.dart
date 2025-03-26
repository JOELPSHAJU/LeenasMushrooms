
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:leenas_mushrooms/controller/local_modals/add_mushroom_post_model.dart';
import 'package:leenas_mushrooms/controller/local_modals/mushroom_detail_display_model.dart';
import 'package:leenas_mushrooms/services/dataverse_repository.dart';

part 'add_mushroom_details_event.dart';
part 'add_mushroom_details_state.dart';

class MushroomDetailsBloc extends Bloc<MushroomDetailsEvent, MushroomDetailsState> {
  final DataVerseRepository repo;
  static const int pageSize = 10;

  MushroomDetailsBloc({required this.repo}) : super(MushroomDetailsInitial()) {
    on<MushroomDetailsButtonPressEvent>(_onAddMushroomDetailsButtonPressEvent);
    on<GetMushroomDetailsEvent>(_onGetMushroomDetailsEvent);
  }

  void _onAddMushroomDetailsButtonPressEvent(
      MushroomDetailsButtonPressEvent event,
      Emitter<MushroomDetailsState> emit) async {
    emit(MushroomDetailsLoading());
    try {
      final inputFormat = DateFormat('dd/MM/yyyy');
      final outputFormat = DateFormat('yyyy-MM-dd');
      final parsedDate = inputFormat.parse(event.details.date);
      final formattedDate = outputFormat.format(parsedDate);

      final credentials = {
        "date": formattedDate,
        "harvest_time": event.details.harvestTime,
        "quantity": event.details.quantity,
        "damage": event.details.damage,
        "remarks": event.details.remarks,
      };

      final response = await repo.addMushroomDetailsApi(credentials: credentials);
      log(response.toString());

      if (response.status == "success") {
        emit(MushroomDetailsSuccess());
       
      }
    } catch (e) {
      emit(MushroomDetailsFailure(message: e.toString()));
    }
  }

  void _onGetMushroomDetailsEvent(
      GetMushroomDetailsEvent event, Emitter<MushroomDetailsState> emit) async {
    try {
      // Show loading state for first page or if no data exists
      if (event.page == 1 || state is MushroomDetailsInitial) {
        emit(MushroomDetailsLoading());
      } else if (state is MushroomFetchSuccess) {
        emit(MushroomLoadingMore(
          mushroomDetails: (state as MushroomFetchSuccess).mushroomDetails,
          currentPage: (state as MushroomFetchSuccess).currentPage,
          hasReachedMax: (state as MushroomFetchSuccess).hasReachedMax,
        ));
      }

      final response = await repo.getMushroomDetailsApi(page: event.page);
      log('API Response for page ${event.page}: ${response.toString()}');

      if (response.status == "success" && response.data != null) {
        final newDetails = response.data!.map((datum) {
          DateTime dateTime = datum.date!;
          String formattedDate = DateFormat('MMMM d, y').format(dateTime);
          return MushroomDetailDisplayModel(
            id: datum.id.toString(),
            date: formattedDate,
            harvestTime: datum.harvestTime.toString(),
            quantity: datum.quantity!.toInt(),
            damage: datum.damage!.toInt(),
            remarks: datum.remarks.toString(),
          );
        }).toList();

        log('Fetched ${newDetails.length} items for page ${event.page}');

        final hasReachedMax = newDetails.length < pageSize ||
            (response.pagination?.total != null &&
                event.page * pageSize >= response.pagination!.total!);

        if (event.page == 1) {
          emit(MushroomFetchSuccess(
            mushroomDetails: newDetails,
            hasReachedMax: hasReachedMax,
            currentPage: event.page,
          ));
        } else if (state is MushroomLoadingMore) {
          final currentDetails = (state as MushroomLoadingMore).mushroomDetails;
          emit(MushroomFetchSuccess(
            mushroomDetails: currentDetails + newDetails, // Combine old + new data
            hasReachedMax: hasReachedMax,
            currentPage: event.page,
          ));
        }
      } else {
        emit(MushroomDetailsFailure(message: "No data available"));
      }
    } catch (e) {
      log('Error fetching mushroom details: $e');
      emit(MushroomDetailsFailure(message: e.toString()));
    }
  }
}