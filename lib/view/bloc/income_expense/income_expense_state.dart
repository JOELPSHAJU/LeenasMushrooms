part of 'income_expense_bloc.dart';

@immutable
sealed class IncomeExpenseState {}

class IncomeExpenseInitial extends IncomeExpenseState {}

class IncomeExpenseLoadingState extends IncomeExpenseState {}

class IncomeExpenseAddSuccessState extends IncomeExpenseState {
  final String? message;
  IncomeExpenseAddSuccessState({this.message});
}

class IncomeExpenseErrorState extends IncomeExpenseState {
  final String message;
  IncomeExpenseErrorState({required this.message});
}

class IncomeFetchSuccess extends IncomeExpenseState {
  final List<IncomeDetailsModel> incomeDetails;

  final bool hasReachedMax;
  final int currentPage;

  IncomeFetchSuccess({
    required this.incomeDetails,
    required this.hasReachedMax,
    required this.currentPage,
  });
}

class ExpenseFetchSuccess extends IncomeExpenseState {
  final List<ExpenseDetailModel> expenseDetails;
  final bool hasReachedMax;
  final int currentPage;

  ExpenseFetchSuccess({
    required this.expenseDetails,
    required this.hasReachedMax,
    required this.currentPage,
  });
}

class IncomeLoadingMore extends IncomeExpenseState {
  final List<IncomeDetailsModel> incomeDetails;
  final int currentPage;

  IncomeLoadingMore({
    required this.incomeDetails,
    required this.currentPage,
  });
}

class ExpenseLoadingMore extends IncomeExpenseState {
  final List<ExpenseDetailModel> expenseDetails;
  final int currentPage;

  ExpenseLoadingMore({
    required this.expenseDetails,
    required this.currentPage,
  });
}
