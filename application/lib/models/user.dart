class User {
  User({
  required this.email,
  required this.password,
  required this.accountId,
  required this.name,
  required this.balance,
  required this.contactIds
  });

  String email;
  String password;
  String accountId;
  String name;
  double balance;
  List<String> contactIds;
}