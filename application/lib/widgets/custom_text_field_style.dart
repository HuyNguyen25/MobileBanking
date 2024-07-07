import 'package:flutter/material.dart';

class CustomTextFieldStyles {
  static final accountIdTextFieldDecoration = InputDecoration(
    icon: Icon(Icons.person),
    hintText: "Account ID",
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
}