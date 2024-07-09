class DestinationAccountInformationModel {
  DestinationAccountInformationModel({
    required this.destinationAccountId,
    required this.destinationAccountName,
    required this.amountOfTransferMoney,
    required this.date,
    required this.destinationAccountNameVisibility
  });
  String destinationAccountId;
  String destinationAccountName;
  String amountOfTransferMoney;
  DateTime? date;
  bool destinationAccountNameVisibility;
}