class PasswordChangeSectionModel {
  PasswordChangeSectionModel({
    required this.oldPassword,
    required this.newPassword,
    required this.confirmedNewPassword
  });

  String oldPassword;
  String newPassword;
  String confirmedNewPassword;
}