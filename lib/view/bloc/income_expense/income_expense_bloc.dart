import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import 'package:leenas_mushrooms/controller/local_modals/expense_add_model.dart';
import 'package:leenas_mushrooms/controller/local_modals/income_add_model.dart';
import 'package:leenas_mushrooms/controller/local_modals/income_details_model.dart';
import 'package:leenas_mushrooms/services/dataverse_repository.dart';
import 'package:meta/meta.dart';

part 'income_expense_event.dart';
part 'income_expense_state.dart';

class IncomeExpenseBloc extends Bloc<IncomeExpenseEvent, IncomeExpenseState> {
  final DataVerseRepository repo;

  IncomeExpenseBloc({required this.repo}) : super(IncomeExpenseInitial()) {
    on<AddIncomeDetailsButtonPressEvent>(_onAddIncomeDetailsButtonPressEvent);
    on<AddExpenseDetailsButtonPressEvent>(_onAddExpenseDetailsButtonPressEvent);
    on<GetIncomeDetailsEvent>(_onGetIncomeDetailsEvent);
    on<GetExpenseDetailsEvent>(_onGetExpenseDetailsEvent);
  }

  void _onAddIncomeDetailsButtonPressEvent(
      AddIncomeDetailsButtonPressEvent event,
      Emitter<IncomeExpenseState> emit) async {
    emit(IncomeExpenseLoadingState());
    try {
      final credentials = {
        "date": event.details.date,
        "user_details": "",
        "source": "",
        "income_type": event.details.incomeType,
        "amount": event.details.amount,
      };
      final response = await repo.addIncomeDetailsApi(credentials: credentials);
      log(response.toString());
      emit(IncomeExpenseAddSuccessState(
          message: 'Income Details added Successfully!'));
    } catch (e) {
      emit(IncomeExpenseErrorState(message: e.toString()));
    }
  }

  void _onAddExpenseDetailsButtonPressEvent(
      AddExpenseDetailsButtonPressEvent event,
      Emitter<IncomeExpenseState> emit) async {
    emit(IncomeExpenseLoadingState());
    try {
      final credentials = {
        "date": event.details.date,
        "user_details": "",
        "expense_type": event.details.expenseType,
        "amount": event.details.amount,
      };
      final response =
          await repo.addExpenseDetailsApi(credentials: credentials);
      log(response.toString());
      emit(IncomeExpenseAddSuccessState(
          message: 'Expense Details added Successfully!'));
    } catch (e) {
      emit(IncomeExpenseErrorState(message: e.toString()));
    }
  }

  void _onGetIncomeDetailsEvent(
      GetIncomeDetailsEvent event, Emitter<IncomeExpenseState> emit) async {
    log('Fetching income details for page: ${event.page}');

    // Initial load or refresh
    if (event.page == 1) {
      emit(IncomeExpenseLoadingState());
    } else if (state is IncomeFetchSuccess) {
      final currentState = state as IncomeFetchSuccess;
      emit(IncomeLoadingMore(
          incomeDetails: currentState.incomeDetails,
          currentPage: currentState.currentPage));
    }

    try {
      final response = await repo.getIncomeDetailsApi(page: event.page);
      log('API Response: ${response.toString()}');

      if (response.status == "success" && response.data != null) {
        List<IncomeDetailsModel> newIncomeDetails = response.data!.map((datum) {
          DateTime dateTime = datum.date!;
          String formattedDate = DateFormat('MMMM d, y').format(dateTime);
          return IncomeDetailsModel(
            date: formattedDate,
            userDetails: datum.userDetails ?? "",
            source: datum.source ?? "",
            incomeType: datum.incomeType ?? "",
            amount: datum.amount.toString(),
          );
        }).toList();

        log('Fetched items: ${newIncomeDetails.length}');

        // Determine if we've reached the end of pagination
        const int limit = 10; // Matches the limit in the API call
        bool hasReachedMax = newIncomeDetails.length < limit ||
            (response.pagination?.totalPages != null &&
                event.page >= response.pagination!.totalPages!);

        if (event.page == 1) {
          emit(IncomeFetchSuccess(
            incomeDetails: newIncomeDetails,
            hasReachedMax: hasReachedMax,
            currentPage: event.page,
          ));
        } else if (state is IncomeLoadingMore) {
          final currentState = state as IncomeLoadingMore;
          emit(IncomeFetchSuccess(
            incomeDetails: currentState.incomeDetails + newIncomeDetails,
            hasReachedMax: hasReachedMax,
            currentPage: event.page,
          ));
        }
      } else {
        log('API returned no success or no data');
        emit(
            IncomeExpenseErrorState(message: "Failed to fetch income details"));
      }
    } catch (e) {
      log('Error fetching income details: $e');
      emit(IncomeExpenseErrorState(message: e.toString()));
    }
  }

  void _onGetExpenseDetailsEvent(
      GetExpenseDetailsEvent event, Emitter<IncomeExpenseState> emit) async {
    log('Fetching income details for page: ${event.page}');

    // Initial load or refresh
    if (event.page == 1) {
      emit(IncomeExpenseLoadingState());
    } else if (state is ExpenseFetchSuccess) {
      final currentState = state as ExpenseFetchSuccess;
      emit(ExpenseLoadingMore(
          expenseDetails: currentState.expenseDetails,
          currentPage: currentState.currentPage));
    }

    try {
      final response = await repo.getExpenseDetailsApi(page: event.page);
      log('API Response: ${response.toString()}');

      if (response.status == "success" && response.data != null) {
        List<ExpenseDetailModel> newExpenseDetail = response.data!.map((datum) {
          DateTime dateTime = datum.date!;
          String formattedDate = DateFormat('MMMM d, y').format(dateTime);
          return ExpenseDetailModel(
              date: formattedDate,
              userDetails: datum.userDetails ?? "",
              expenseType: datum.expenseType ?? "",
              amount: datum.amount!.toInt());
        }).toList();

        log('Fetched items: ${newExpenseDetail.length}');

        // Determine if we've reached the end of pagination
        const int limit = 10; // Matches the limit in the API call
        bool hasReachedMax = newExpenseDetail.length < limit ||
            (response.pagination?.totalPages != null &&
                event.page >= response.pagination!.totalPages!);

        if (event.page == 1) {
          emit(ExpenseFetchSuccess(
            expenseDetails: newExpenseDetail,
            hasReachedMax: hasReachedMax,
            currentPage: event.page,
          ));
        } else if (state is ExpenseLoadingMore) {
          final currentState = state as ExpenseLoadingMore;
          emit(ExpenseFetchSuccess(
            expenseDetails: currentState.expenseDetails + newExpenseDetail,
            hasReachedMax: hasReachedMax,
            currentPage: event.page,
          ));
        }
      } else {
        log('API returned no success or no data');
        emit(
            IncomeExpenseErrorState(message: "Failed to fetch income details"));
      }
    } catch (e) {
      log('Error fetching income details: $e');
      emit(IncomeExpenseErrorState(message: e.toString()));
    }
  }
}
