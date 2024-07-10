class Transaction {
  Transaction({
    required this.sourceAccountId,
    required this.destinationAccountId,
    required this.details,
    required this.amountOfMoney
  });

  String sourceAccountId;
  String destinationAccountId;
  String details;
  double amountOfMoney;
}