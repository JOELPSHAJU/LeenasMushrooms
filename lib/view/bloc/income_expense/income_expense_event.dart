part of 'income_expense_bloc.dart';

@immutable
sealed class IncomeExpenseEvent {}



final class AddIncomeDetailsButtonPressEvent extends IncomeExpenseEvent {
  final IncomeDetailsAddModel details;

  AddIncomeDetailsButtonPressEvent({required this.details});
}
