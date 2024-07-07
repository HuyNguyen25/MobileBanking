import 'package:application/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SignUpSection extends StatelessWidget {
  SignUpSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Text(
        "Please visit the nearest bank to open your account. Online registration is not available. Thank you for your patience.",
        style: CustomTextStyles.titleMedium,
        textAlign: TextAlign.left
      )
    );
  }
}
