import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import 'package:leenas_mushrooms/controller/local_modals/call_details_post_model.dart';
import 'package:leenas_mushrooms/services/dataverse_repository.dart';
import 'package:meta/meta.dart';

part 'call_details_event.dart';
part 'call_details_state.dart';

class CallDetailsBloc extends Bloc<CallDetailsEvent, CallDetailsState> {
  final DataVerseRepository repo;
  final int limit = 10;

  CallDetailsBloc({required this.repo}) : super(CallDetailsInitial()) {
    on<CallDetailsButtonPressEvent>(_onAddCallDetailsButtonPressEvent);
    on<GetCallDetailsEvent>(_onGetCallDetailsEvent);
  }

  void _onAddCallDetailsButtonPressEvent(
      CallDetailsButtonPressEvent event, Emitter<CallDetailsState> emit) async {
    emit(CallDetailsLoading());

    try {
      final credentials = {
        "date": event.details.date,
        "call_type": event.details.callType,
        "name": event.details.name,
        "phone_number": event.details.phoneNumber,
        "purpose": event.details.purpose,
        "current_status": event.details.currentStatus
      };
      final response = await repo.addCallDetailsApi(credentials: credentials);
      log(response.toString());
      emit(CallDetailsSuccess());
    } catch (e) {
      emit(CallDetailsFailure(message: e.toString()));
    }
  }

  void _onGetCallDetailsEvent(
      GetCallDetailsEvent event, Emitter<CallDetailsState> emit) async {
    // If it's the first page or refresh, show loading state
    if (event.page == 1) {
      emit(CallDetailsLoading());
    } else if (state is CallDetailsFetchSuccess) {
      // For pagination, emit loading more state
      final currentState = state as CallDetailsFetchSuccess;
      emit(CallDetailsLoadingMore(
          callDetails: currentState.callDetails,
          currentPage: currentState.currentPage));
    }

    try {
      final response = await repo.getCallDetailsApi(page: event.page);

      if (response.status == "success" && response.data != null) {
        List<CallDetailsModel> newCallDetails = response.data!.map((datum) {
          DateTime dateTime = datum.date!;
          String formattedDate = DateFormat('MMMM d, y').format(dateTime);
          return CallDetailsModel(
            date: formattedDate,
            callType: datum.callType.toString(),
            name: datum.name.toString(),
            phoneNumber: datum.phoneNumber.toString(),
            purpose: datum.purpose.toString(),
            currentStatus: datum.currentStatus.toString(),
          );
        }).toList();

        // Check if we've reached the max (fewer items than limit returned)
        bool hasReachedMax = newCallDetails.length < limit;

        if (event.page == 1) {
          // First page - replace all data
          emit(CallDetailsFetchSuccess(
            allCallDetails:newCallDetails,
            callDetails: newCallDetails,
            hasReachedMax: hasReachedMax,
            currentPage: event.page,
          ));
        } else if (state is CallDetailsLoadingMore) {
          // Pagination - append new data
          final currentState = state as CallDetailsLoadingMore;
          emit(CallDetailsFetchSuccess(
            allCallDetails: currentState.callDetails + newCallDetails,
            callDetails: List.from(currentState.callDetails)
              ..addAll(newCallDetails),
            hasReachedMax: hasReachedMax, 
            currentPage: event.page,
          ));
        }
      } else {
        emit(CallDetailsFailure(message: "Failed to fetch call details"));
      }
    } catch (e) {
      emit(CallDetailsFailure(message: e.toString()));
    }
  }
}
