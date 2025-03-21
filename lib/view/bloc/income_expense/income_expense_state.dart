part of 'income_expense_bloc.dart';

@immutable


sealed class IncomeExpenseState {}
class IncomeExpenseInitial extends IncomeExpenseState {}

class IncomeExpenseLoadingState extends IncomeExpenseState {}

class IncomeExpenseAddSuccessState extends IncomeExpenseState {
  final String? message;

   IncomeExpenseAddSuccessState({this.message});

  @override
  List<Object> get props => [message ?? ''];
}

class IncomeExpenseErrorState extends IncomeExpenseState {
  final String message;

   IncomeExpenseErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class IncomeExpenseFetchSuccess extends IncomeExpenseState {
  final List<IncomeDetailsModel> allIncomeDetails;
  final List<IncomeDetailsModel> incomeDetails;
  final bool hasReachedMax;
  final int currentPage;

   IncomeExpenseFetchSuccess({
    required this.allIncomeDetails,
    required this.incomeDetails,
    required this.hasReachedMax,
    required this.currentPage,
  });

  @override
  List<Object> get props =>
      [allIncomeDetails, incomeDetails, hasReachedMax, currentPage];
}

class IncomeExpenseLoadingMore extends IncomeExpenseState {
  final List<IncomeDetailsModel> incomeDetails;
  final int currentPage;

   IncomeExpenseLoadingMore({
    required this.incomeDetails,
    required this.currentPage,
  });

  @override
  List<Object> get props => [incomeDetails, currentPage];
}
