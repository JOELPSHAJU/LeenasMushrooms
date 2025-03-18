import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:leenas_mushrooms/controller/local_modals/income_add_model.dart';
import 'package:leenas_mushrooms/services/dataverse_repository.dart';
import 'package:meta/meta.dart';

part 'income_expense_event.dart';
part 'income_expense_state.dart';

class IncomeExpenseBloc extends Bloc<IncomeExpenseEvent, IncomeExpenseState> {
  final DataVerseRepository repo;
  IncomeExpenseBloc({required this.repo}) : super(IncomeExpenseInitial()) {
    on<AddIncomeDetailsButtonPressEvent>(_onAddIncomeDetailsButtonPressEvent);
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
        "amount":event.details.amount
      };
      final response = await repo.addCallDetailsApi(credentials: credentials);
      log(response.toString());
      emit(IncomeExpenseSucessState());
    } catch (e) {
      emit(IncomeExpenseErrorState(message: e.toString()));
    }
  }
}
