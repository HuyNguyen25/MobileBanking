import 'package:application/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomTextFieldStyles {
  static final accountIdTextFieldDecoration = InputDecoration(
    icon: Icon(Icons.person),
    hintText: "Account ID",
    hintStyle: CustomTextStyles.titleSmall,
    errorStyle: CustomTextStyles.titleSmall.copyWith(fontSize: 9.8.sp, color: Colors.red),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(
        width: 1.5,
        color: Colors.black45
      )
    ),
  );

  static final passwordTextFieldDecoration = accountIdTextFieldDecoration.copyWith(
    icon: Icon(Icons.lock),
    hintText: "Password",
  );

  static final destinationAccountIdTextFieldDecoration = accountIdTextFieldDecoration.copyWith(
    icon: Icon(Icons.perm_identity, color: Colors.white),
    hintText: "Destination Account ID",
    hintStyle: CustomTextStyles.titleSmall.copyWith(
      color: Colors.white
    ),
    errorStyle: CustomTextStyles.titleSmall.copyWith(
      fontSize: 9.8.sp,
      color: Colors.amber
    )
  );

  static final amountOfTransferMoneyTextFieldDecoration = destinationAccountIdTextFieldDecoration.copyWith(
    hintText: "Amount of Money",
    icon: Icon(Icons.monetization_on_sharp, color: Colors.white),
  );

  static final transferTitleTextFieldDecoration = destinationAccountIdTextFieldDecoration.copyWith(
    hintText: "Title (< 100 characters)",
    icon: Icon(Icons.title, color: Colors.white)
  );

  static final oldPasswordTextFieldDecoration = passwordTextFieldDecoration.copyWith(
    hintText: "Old Password",
  );

  static final confirmedNewPasswordTextFieldDecoration = passwordTextFieldDecoration.copyWith(
    hintText: "Confirm New Password",
  );

  static final newPasswordTextFieldDecoration = oldPasswordTextFieldDecoration.copyWith(
    hintText: "New Password"
  );

  static final emailTextFieldDecoration = accountIdTextFieldDecoration.copyWith(
    icon: Icon(Icons.email),
    hintText: "Email"
  );
}