import 'package:application/constants/pocketbase.dart';
import 'package:application/database_services/synchronization_service.dart';
import 'package:application/models/user.dart';
import 'package:application/screens/home/notifiers/home_screen_notifier.dart';
import 'package:application/screens/home/widgets/AccountInformation.dart';
import 'package:application/screens/money_transfer/notifiers/money_transfer_screen_notifier.dart';
import 'package:application/screens/money_transfer/widgets/destination_account_information/destination_account_information.dart';
import 'package:application/theme/theme.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:sizer/sizer.dart';

class MoneyTransferScreen extends ConsumerStatefulWidget {
  MoneyTransferScreen({super.key});

  @override
  MoneyTransferScreenState createState() => MoneyTransferScreenState();
}

class MoneyTransferScreenState extends ConsumerState<MoneyTransferScreen> {
  final pb = PocketBase(PocketbaseConstants.pocketbasePath);

  @override
  void initState() {
    super.initState();
    User? currentUser = ref.read(moneyTransferScreenNotifier);
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
      name: "backButtonInterceptorFunctionForMoneyTransferScreen"
    );
  }

  @override
  void dispose() {
    pb.collection("accounts").unsubscribe();
    BackButtonInterceptor.removeByName("backButtonInterceptorFunctionForMoneyTransferScreen");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(moneyTransferScreenNotifier);
    return SafeArea(
      child: Scaffold(
        appBar: _buildMoneyTransferScreenAppBar(context),
        body: _buildMoneyTransferScreenBody(user, context),
      ),
    );
  }

  PreferredSizeWidget _buildMoneyTransferScreenAppBar(BuildContext context) {
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
      title: Text("Transfer", style: CustomTextStyles.titleMedium.copyWith(color: CustomColors.gray900)),
    );
  }

  Widget _buildMoneyTransferScreenBody(User? user, BuildContext context) {
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
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 5.w),
                  Text(
                    "From:",
                    style: CustomTextStyles.titleMedium,
                  )
                ],
              ),
              SizedBox(height: 2.h),
              AccountInformation(
                accountName: user!.name,
                accountId: user!.accountId,
                balance: user!.balance.toString(),
              ),
              SizedBox(height: 2.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 5.w),
                  Text(
                    "To:",
                    style: CustomTextStyles.titleMedium,
                  )
                ],
              ),
              SizedBox(height: 2.h),
              DestinationAccountInformation()
            ],
          ),
        ),
      ),
    );
  }
}