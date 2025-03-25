class ExpenseDetailsModel {
  final String id;
  final DateTime date;
  final String expenseType;
  final int amount;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  ExpenseDetailsModel({
    required this.id,
    required this.date,
    required this.expenseType,
    required this.amount,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

}