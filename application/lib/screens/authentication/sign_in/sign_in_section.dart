import 'package:application/database_services/authentication_service.dart';
import 'package:application/models/user.dart';
import 'package:application/screens/authentication/sign_in/models/sign_in_section_model.dart';
import 'package:application/screens/authentication/sign_in/notifiers/sign_in_section_notifier.dart';
import 'package:application/screens/home/notifiers/home_screen_notifier.dart';
import 'package:application/theme/theme.dart';
import 'package:application/widgets/custom_text_field_style.dart';
import 'package:application/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

class SignInSection extends ConsumerStatefulWidget {
  const SignInSection({super.key});

  @override
  SignInSectionState createState() => SignInSectionState();
}

class SignInSectionState extends ConsumerState<SignInSection> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  SignInSectionModel signInSectionModel = SignInSectionModel(accountId: "", password: "");

  @override
  Widget build(BuildContext context) {
    bool loading = ref.watch(signInSectionNotifier);

    return loading ? LoadingWidgets.loading : SizedBox(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormField(
                    decoration: CustomTextFieldStyles.accountIdTextFieldDecoration,
                    onChanged: (value) {
                      setState(() {
                        signInSectionModel.accountId = value;
                      });
                    },
                    validator: (value) {
                      if(value == null || value.length != 10)
                        return "Account ID is invalid!";
                      return null;
                    },
                  ),
                  SizedBox(height: 1.h),
                  TextFormField(
                    decoration: CustomTextFieldStyles.passwordTextFieldDecoration,
                    onChanged: (value) {
                      setState(() {
                        signInSectionModel.password = value;
                      });
                    },
                    obscureText: true,
                    validator: (value) {
                      if(value == null || value.length < 6)
                        return "Password must have at least 6 characters!";
                      return null;
                    },
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () async {
                          if(_formKey.currentState!.validate()) {
                            ref.read(signInSectionNotifier.notifier).showLoading();
                            User? user = await AuthenticationService.signIn(
                              accountId: signInSectionModel.accountId,
                              password: signInSectionModel.password
                            );

                            if(user != null) {
                              //update homeScreenNotifier's state
                              ref.read(homeScreenNotifier.notifier).changeUser(user);

                              //navigate to home screen
                              if(context.mounted) {
                                Future.delayed(Duration(milliseconds: 800), () => Navigator.pushReplacementNamed(context, "/homeScreen"));
                              }
                            }
                            else {
                              ref.read(signInSectionNotifier.notifier).notShowLoading();
                              await _showFailToSignInDialog();
                            }
                          }
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.black45,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                          )
                        ),
                        child: Text("Sign In", style: CustomTextStyles.titleLarge.copyWith(color: Colors.white)),
                      ),
                      SizedBox(width: 5.w),
                      InkWell(
                        child: Text(
                          "Forgot Password?",
                          style: CustomTextStyles.titleSmall.copyWith(
                            decoration: TextDecoration.underline,
                            color: Colors.pink[900]
                          )
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _showFailToSignInDialog() async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Error!"),
        content: Text("Account ID or password may be incorrect."),
      )
    );
  }
}