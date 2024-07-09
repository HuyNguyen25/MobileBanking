import 'package:application/screens/authentication/sign_in/sign_in_section.dart';
import 'package:application/screens/authentication/sign_up/sign_up_section.dart';
import 'package:application/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

///AuthenticationScreen contains SignInSection and SignUpSection in a tab view
class AuthenticationScreen extends ConsumerStatefulWidget {
  AuthenticationScreen({super.key});

  @override
  AuthenticationState createState() {
    // TODO: implement createState
    return AuthenticationState();
  }
}

class AuthenticationState extends ConsumerState<AuthenticationScreen> with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
        child: Scaffold(
        body: SizedBox(
          width: SizerUtil.width,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 5.h),
                Icon(
                  FontAwesomeIcons.globe,
                  size: 20.h
                ),
                SizedBox(height: 1.h),
                Text(
                  "eBanking",
                  style: CustomTextStyles.headlineSmall,
                ),
                SizedBox(height: 1.h),
                TabBar(
                  controller: tabController,
                  labelStyle: CustomTextStyles.titleSmall.copyWith(
                    fontSize: 10.sp
                  ),
                  tabs: [
                    Tab(
                      icon: Icon(Icons.login),
                      text: "Sign In",
                    ),
                    Tab(
                      icon: Icon(Icons.app_registration),
                      text: "Sign Up"
                    )
                  ],
                ),
                SizedBox(height: 3.h),
                SizedBox(
                  height: 40.h,
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      SignInSection(),
                      SignUpSection()
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.copyright, color: CustomColors.gray700),
                    SizedBox(width: 1.w),
                    Text("Created by Phuc Huy Nguyen", style: CustomTextStyles.titleSmall)
                  ],
                )
              ],
            ),
          ),
        )
      )
    );
  }
}