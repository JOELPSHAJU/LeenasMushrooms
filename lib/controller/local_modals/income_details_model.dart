class IncomeDetailsModel {
  final String date;
  final String userDetails;
  final String source;
  final String incomeType;
  final String amount; // Using String for simplicity in DataTable

  IncomeDetailsModel({
    required this.date,
    required this.userDetails,
    required this.source,
    required this.incomeType,
    required this.amount,
  });

  @override
  String toString() =>
      'IncomeDetailsModel(date: $date, incomeType: $incomeType, amount: $amount)';
}


