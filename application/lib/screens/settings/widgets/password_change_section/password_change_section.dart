import 'package:application/database_services/authentication_service.dart';
import 'package:application/database_services/core_service.dart';
import 'package:application/screens/settings/notifiers/settings_screen_notifier.dart';
import 'package:application/screens/settings/widgets/password_change_section/models/password_change_section_model.dart';
import 'package:application/theme/theme.dart';
import 'package:application/widgets/custom_text_field_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

class PasswordChangeSection extends ConsumerStatefulWidget {
  const PasswordChangeSection({super.key});

  @override
  PasswordChangeSectionState createState() => PasswordChangeSectionState();
}

class PasswordChangeSectionState extends ConsumerState<PasswordChangeSection> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  PasswordChangeSectionModel passwordChangeSectionModel = PasswordChangeSectionModel(
    oldPassword: "",
    newPassword: "",
    confirmedNewPassword: ""
  );

  @override
  Widget build(BuildContext context) {
    final user = ref.read(settingsScreenNotifier);
    return SizedBox(
      width: 80.w,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: CustomColors.gray700),
          borderRadius: BorderRadius.circular(15)
        ),
        child: Form(
         key: _formKey,
         child: Padding(
           padding: EdgeInsets.all(5.w),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.center,
             children: [
              TextFormField(
                decoration: CustomTextFieldStyles.oldPasswordTextFieldDecoration,
                style: CustomTextStyles.titleSmall,
                onChanged: (value) {
                 setState(() {
                   passwordChangeSectionModel.oldPassword = value;
                 });
                },
                validator: (value) {
                 if(value == null || value.length < 6)
                   return "Password must have at least 6 characters!";
                 return null;
                }
               ),
               SizedBox(height: 3.w),
               TextFormField(
                 decoration: CustomTextFieldStyles.newPasswordTextFieldDecoration,
                 style: CustomTextStyles.titleSmall,
                 onChanged: (value) {
                   setState(() {
                     passwordChangeSectionModel.newPassword = value;
                   });
                 },
                 validator: (value) {
                   if(value == null || value.length < 6)
                     return "Password must have at least 6 characters!";
                   return null;
                 }
               ),
               SizedBox(height: 3.w),
               TextFormField(
                 decoration: CustomTextFieldStyles.confirmedNewPasswordTextFieldDecoration,
                 style: CustomTextStyles.titleSmall,
                 onChanged: (value) {
                   setState(() {
                     passwordChangeSectionModel.confirmedNewPassword = value;
                   });
                 },
                 validator: (value) {
                   if(value == null || value.length < 6)
                     return "Password must have at least 6 characters!";
                   if(value != passwordChangeSectionModel.newPassword)
                     return "Passwords do not match!";
                   return null;
                 }
               ),
               SizedBox(height: 3.w),
               TextButton(
                 style: TextButton.styleFrom(
                   backgroundColor: Colors.black
                 ),
                 child: Text(
                   "Change",
                   style: CustomTextStyles.titleSmall.copyWith(
                     color: Colors.white
                   ),
                 ),
                 onPressed: () async {
                   if(!_formKey.currentState!.validate())
                     return;

                   bool result = await AuthenticationService.changePassword(
                    accountId: user!.accountId,
                    oldPassword: passwordChangeSectionModel.oldPassword,
                    newPassword: passwordChangeSectionModel.newPassword
                   );

                   //password is changed successfully
                   if(result)
                     await _showPasswordChangedSuccessfullyDialog();
                   else
                     await _showPasswordChangedUnsuccessfullyDialog();
                 },
               )
             ],
           ),
         )
        )
      )
    );
  }

  Future<void> _showPasswordChangedSuccessfullyDialog() async {
    await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => AlertDialog(
        title: Text(
          "Password is changed successfully!",
          style: CustomTextStyles.titleMedium
        )
      )
    );
  }

  Future<void> _showPasswordChangedUnsuccessfullyDialog() async {
    await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => AlertDialog(
        title: Text(
          "Password is incorrect!",
          style: CustomTextStyles.titleMedium
        )
      )
    );
  }
}
