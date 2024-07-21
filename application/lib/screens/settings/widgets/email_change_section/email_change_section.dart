import 'package:application/database_services/authentication_service.dart';
import 'package:application/screens/settings/notifiers/settings_screen_notifier.dart';
import 'package:application/screens/settings/widgets/email_change_section/models/email_change_section_model.dart';
import 'package:application/theme/theme.dart';
import 'package:application/utils/string_utils.dart';
import 'package:application/widgets/custom_text_field_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

class EmailChangeSection extends ConsumerStatefulWidget {
  const EmailChangeSection({super.key});

  @override
  EmailChangeSectionState createState() => EmailChangeSectionState();
}

class EmailChangeSectionState extends ConsumerState<EmailChangeSection> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  EmailChangeSectionModel emailChangeSectionModel = EmailChangeSectionModel(
    password: "",
    newEmail: ""
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
                  decoration: CustomTextFieldStyles.passwordTextFieldDecoration,
                  style: CustomTextStyles.titleSmall,
                  onChanged: (value) {
                    setState(() {
                      emailChangeSectionModel.password = value;
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
                  decoration: CustomTextFieldStyles.emailTextFieldDecoration,
                  style: CustomTextStyles.titleSmall,
                  onChanged: (value) {
                    setState(() {
                      emailChangeSectionModel.newEmail = value;
                    });
                  },
                  validator: (value) {
                    if(value == null || !StringUtils.isValidEmail(value))
                      return "Email is invalid!";
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

                    bool result = await AuthenticationService.changeEmail(
                      accountId: user!.accountId,
                      password: emailChangeSectionModel.password,
                      newEmail: emailChangeSectionModel.newEmail
                    );

                    if(result)
                      await _showEmailChangedSuccessfullyDialog();
                    else
                      await _showEmailChangedUnsuccessfullyDialog();
                  },
                )
              ],
            ),
          )
        )
      )
    );
  }

  Future<void> _showEmailChangedSuccessfullyDialog() async {
    await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => AlertDialog(
        title: Text(
          "Email is changed successfully!",
          style: CustomTextStyles.titleMedium
        )
      )
    );
  }

  Future<void> _showEmailChangedUnsuccessfullyDialog() async {
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

