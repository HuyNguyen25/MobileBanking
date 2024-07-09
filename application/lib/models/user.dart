class User {
  User({
  required this.id,
  required this.email,
  required this.password,
  required this.accountId,
  required this.name,
  required this.balance,
  required this.contactIds
  });

  String id;
  String email;
  String password;
  String accountId;
  String name;
  double balance;
  List<String> contactIds;
}