part of 'income_expense_bloc.dart';

@immutable
sealed class IncomeExpenseEvent {}

final class AddIncomeDetailsButtonPressEvent extends IncomeExpenseEvent {
  final IncomeDetailModel details;

  AddIncomeDetailsButtonPressEvent({required this.details});
}

final class AddExpenseDetailsButtonPressEvent extends IncomeExpenseEvent {
  final ExpenseDetailModel details;

  AddExpenseDetailsButtonPressEvent({required this.details});
}

final class GetIncomeDetailsEvent extends IncomeExpenseEvent {
  final int page;
  GetIncomeDetailsEvent({required this.page});
}

final class GetExpenseDetailsEvent extends IncomeExpenseEvent {
  final int page;
  GetExpenseDetailsEvent({required this.page});
}
