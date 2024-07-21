import 'package:application/constants/pocketbase.dart';
import 'package:application/database_services/synchronization_service.dart';
import 'package:application/models/user.dart';
import 'package:application/screens/home/notifiers/home_screen_notifier.dart';
import 'package:application/screens/settings/models/settings_screen_model.dart';
import 'package:application/screens/settings/notifiers/settings_screen_notifier.dart';
import 'package:application/screens/settings/widgets/email_change_section/email_change_section.dart';
import 'package:application/screens/settings/widgets/password_change_section/password_change_section.dart';
import 'package:application/theme/theme.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:sizer/sizer.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  SettingsScreen({super.key});

  @override
  SettingsScreenState createState() => SettingsScreenState();
}

class SettingsScreenState extends ConsumerState<SettingsScreen> {
  final pb = PocketBase(PocketbaseConstants.pocketbasePath);
  SettingsScreenModel settingsScreenModel = SettingsScreenModel(
    showPasswordChangeSection: false,
    showEmailChangeSection: false
  );

  @override
  void initState() {
    super.initState();
    User? currentUser = ref.read(settingsScreenNotifier);
    if(currentUser != null) {
      pb.collection("accounts").subscribe(
        currentUser.accountId,
        (e) async {
          final result = await SynchronizationService.getCurrentUserUpdate(accountId: currentUser.accountId);
          ref.read(homeScreenNotifier.notifier).changeUser(result);
        }
      );
    }

    BackButtonInterceptor.add(
      (stopDefaultButtonEvent, info) async {
        if(context.mounted) {
          Navigator.pushReplacementNamed(context, "/homeScreen");
        }
        return true;
      },
      name: "backButtonInterceptorFunctionForSettingsScreen"
    );
  }

  @override
  void dispose() {
    pb.collection("accounts").unsubscribe();
    BackButtonInterceptor.removeByName("backButtonInterceptorFunctionForSettingsScreen");
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(settingsScreenNotifier);
    return SafeArea(
      child: Scaffold(
        appBar: _buildSettingsScreenAppBar(context),
        body: _buildSettingsScreenBody(user, context)
      )
    );
  }

  PreferredSizeWidget _buildSettingsScreenAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.logout, color: CustomColors.gray900),
        onPressed: () async {
          if(context.mounted) {
            Navigator.pushReplacementNamed(context, "/homeScreen");
          }
        },
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(3),
        child: Container(
          height: 3,
          color: Colors.black
        ),
      ),
      title: Text("Security Settings", style: CustomTextStyles.titleMedium.copyWith(color: CustomColors.gray900)),
    );
  }

  Widget _buildSettingsScreenBody(User? user, BuildContext context) {
    return SizedBox(
      width: SizerUtil.width,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 1.5.w),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 2.h),
              InkWell(
                onTap: () {
                  setState(() {
                    settingsScreenModel.showPasswordChangeSection = !settingsScreenModel.showPasswordChangeSection;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 5.w),
                      child: Text(
                        "Change Password",
                        style: CustomTextStyles.titleMedium,
                      )
                    ),
                   Icon(
                       settingsScreenModel.showPasswordChangeSection ?
                        Icons.arrow_drop_up_sharp: Icons.arrow_drop_down_sharp,
                     color: CustomColors.gray900
                   )
                  ],
                ),
              ),
              SizedBox(height: 2.h),
              settingsScreenModel.showPasswordChangeSection ?
                PasswordChangeSection(): Container(height: 0),
              SizedBox(height: 2.h),
              InkWell(
                onTap: () {
                  setState(() {
                    settingsScreenModel.showEmailChangeSection = !settingsScreenModel.showEmailChangeSection;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 5.w),
                      child: Text(
                        "Change Email",
                        style: CustomTextStyles.titleMedium,
                      )
                    ),
                    Icon(
                      settingsScreenModel.showEmailChangeSection ?
                        Icons.arrow_drop_up_sharp: Icons.arrow_drop_down_sharp,
                      color: CustomColors.gray900
                    )
                  ],
                ),
              ),
              SizedBox(height: 2.h),
              settingsScreenModel.showEmailChangeSection ?
              EmailChangeSection(): Container(height: 0),
            ],
          ),
        ),
      ),
    );
  }
}
