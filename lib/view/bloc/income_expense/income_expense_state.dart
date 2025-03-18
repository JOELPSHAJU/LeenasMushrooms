part of 'income_expense_bloc.dart';

@immutable
sealed class IncomeExpenseState {}

final class IncomeExpenseInitial extends IncomeExpenseState {}

final class IncomeExpenseLoadingState extends IncomeExpenseState {}

final class IncomeExpenseSucessState extends IncomeExpenseState {}

final class IncomeExpenseErrorState extends IncomeExpenseState {
  final String message;
  IncomeExpenseErrorState({required this.message});
}
