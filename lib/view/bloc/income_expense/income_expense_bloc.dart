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
      emit( IncomeExpenseAddSuccessState(
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
      emit( IncomeExpenseAddSuccessState(
          message: 'Expense Details added Successfully!'));
    } catch (e) {
      emit(IncomeExpenseErrorState(message: e.toString()));
    }
  }

  void _onGetIncomeDetailsEvent(
      GetIncomeDetailsEvent event, Emitter<IncomeExpenseState> emit) async {
    if (event.page == 1) {
      emit(IncomeExpenseLoadingState());
    } else if (state is IncomeExpenseFetchSuccess) {
      final currentState = state as IncomeExpenseFetchSuccess;
      emit(IncomeExpenseLoadingMore(
        incomeDetails: currentState.incomeDetails,
        currentPage: currentState.currentPage,
      ));
    }

    try {
      final response = await repo.getIncomeDetailsApi(page: event.page);

      if (response.status == "success" && response.data != null) {
        List<IncomeDetailsModel> newIncomeDetails = response.data!.map((datum) {
          DateTime dateTime = datum.date!;
          String formattedDate = DateFormat('MMMM d, y').format(dateTime);
          return IncomeDetailsModel(
            date: formattedDate,
            userDetails: datum.userDetails ?? '',
            source: datum.source ?? '',
            incomeType: datum.incomeType ?? '',
            amount: datum.amount.toString(),
          );
        }).toList();

        bool hasReachedMax =
            event.page >= (response.pagination?.totalPages ?? 1);

        if (event.page == 1) {
          emit(IncomeExpenseFetchSuccess(
            allIncomeDetails: newIncomeDetails,
            incomeDetails: newIncomeDetails,
            hasReachedMax: hasReachedMax,
            currentPage: event.page,
          ));
        } else if (state is IncomeExpenseLoadingMore) {
          final currentState = state as IncomeExpenseLoadingMore;
          emit(IncomeExpenseFetchSuccess(
            allIncomeDetails: currentState.incomeDetails + newIncomeDetails,
            incomeDetails: List.from(currentState.incomeDetails)
              ..addAll(newIncomeDetails),
            hasReachedMax: hasReachedMax,
            currentPage: event.page,
          ));
        }
      } else {
        emit( IncomeExpenseErrorState(
            message: "Failed to fetch income details"));
      }
    } catch (e) {
      emit(IncomeExpenseErrorState(message: e.toString()));
    }
  }
}
