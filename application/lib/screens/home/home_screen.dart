import 'package:application/constants/image_constants.dart';
import 'package:application/constants/pocketbase.dart';
import 'package:application/database_services/synchronization_service.dart';
import 'package:application/models/user.dart';
import 'package:application/screens/authentication/sign_in/notifiers/sign_in_section_notifier.dart';
import 'package:application/screens/home/notifiers/home_screen_notifier.dart';
import 'package:application/screens/home/widgets/AccountInformation.dart';
import 'package:application/screens/home/widgets/custom_home_screen_item.dart';
import 'package:application/theme/theme.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends ConsumerStatefulWidget {
  HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> {
  final pb = PocketBase(PocketbaseConstants.pocketbasePath);

  @override
  void initState() {
    super.initState();
    User? currentUser = ref.read(homeScreenNotifier);
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
          ref.read(signInSectionNotifier.notifier).notShowLoading();
          Navigator.pushReplacementNamed(context, "/");
        }
          return true;
      },
      name: "backButtonInterceptorFunctionForHomeScreen"
    );
  }

  @override
  void dispose() {
    pb.collection("accounts").unsubscribe();
    BackButtonInterceptor.removeByName("backButtonInterceptorFunctionForHomeScreen");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(homeScreenNotifier);
    return SafeArea(
      child: Scaffold(
        appBar: _buildHomeScreenAppBar(context),
        body: _buildHomeScreenBody(user, context)
      ),
    );
  }

  PreferredSizeWidget _buildHomeScreenAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.logout, color: CustomColors.gray900),
        onPressed: () async {
          if(context.mounted) {
            ref.read(signInSectionNotifier.notifier).notShowLoading();
            Navigator.pushReplacementNamed(context, "/");
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
      title: Text("eBanking", style: CustomTextStyles.titleMedium.copyWith(color: CustomColors.gray900)),
      actions: [
        IconButton(
          icon: Icon(Icons.search, color: CustomColors.gray900),
          onPressed: () async {

          },
        ),
        IconButton(
          icon: Icon(Icons.history, color: CustomColors.gray900),
          onPressed: () async {
            if(context.mounted) {
              Navigator.pushReplacementNamed(context, "/historyScreen");
            }
          },
        )
      ],
    );
  }

  Widget _buildHomeScreenBody(User? user, BuildContext context) {
    return SizedBox(
      width: SizerUtil.width,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 1.5.w),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 1.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 5.w),
                  Text(
                    "Welcome Back!",
                    style: CustomTextStyles.titleMedium,
                  )
                ],
              ),
              SizedBox(height: 2.h),
              AccountInformation(
                accountId: user!.accountId,
                accountName: user!.name,
                balance: user!.balance.toString(),
              ),
              SizedBox(height: 3.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 5.w),
                  Text(
                    "Payment",
                    style: CustomTextStyles.titleMedium,
                  )
                ],
              ),
              SizedBox(height: 2.h),
              SizedBox(
                height: 16.h,
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: [
                    SizedBox(width: 2.w),
                    CustomHomeScreenItem(title: "Pay Bills", iconData: FontAwesomeIcons.receipt),
                    SizedBox(width: 4.w),
                    CustomHomeScreenItem(title: "Pay Taxes", iconData: FontAwesomeIcons.flagUsa),
                    SizedBox(width: 4.w),
                    CustomHomeScreenItem(title: "QR", iconData: FontAwesomeIcons.qrcode),
                    SizedBox(width: 4.w),
                    CustomHomeScreenItem(title: "Stock", iconData: FontAwesomeIcons.arrowTrendUp),
                    SizedBox(width: 4.w),
                    CustomHomeScreenItem(title: "More", iconData: FontAwesomeIcons.ellipsis),
                    SizedBox(width: 2.w)
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 5.w),
                  Text(
                    "Money Transfer, eWallet",
                    style: CustomTextStyles.titleMedium,
                  )
                ],
              ),
              SizedBox(height: 2.h),
              SizedBox(
                height: 17.h,
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: [
                    SizedBox(width: 2.w),
                    CustomHomeScreenItem(title: "Money Transfer", iconData: FontAwesomeIcons.moneyBillTransfer,
                      onTap: () async {
                        if(context.mounted) {
                          Navigator.pushReplacementNamed(context, "/moneyTransferScreen");
                        }
                      },
                    ),
                    SizedBox(width: 4.w),
                    CustomHomeScreenItem(title: "Apple Wallet", iconData: FontAwesomeIcons.applePay),
                    SizedBox(width: 4.w),
                    CustomHomeScreenItem(title: "PayPal", iconData: FontAwesomeIcons.paypal),
                    SizedBox(width: 4.w),
                    CustomHomeScreenItem(title: "Google Wallet", iconData: FontAwesomeIcons.googleWallet),
                    SizedBox(width: 4.w),
                    CustomHomeScreenItem(title: "More", iconData: FontAwesomeIcons.ellipsis),
                    SizedBox(width: 2.w)
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 5.w),
                  Text(
                    "Card Management",
                    style: CustomTextStyles.titleMedium,
                  )
                ],
              ),
              SizedBox(height: 2.h),
              SizedBox(
                height: 16.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomHomeScreenItem(title: "Debit", iconData: FontAwesomeIcons.solidCreditCard),
                    CustomHomeScreenItem(title: "Credit", iconData: FontAwesomeIcons.creditCard),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 5.w),
                  Text(
                    "Utility",
                    style: CustomTextStyles.titleMedium,
                  )
                ],
              ),
              SizedBox(height: 2.h),
              SizedBox(
                height: 16.h,
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: [
                    SizedBox(width: 2.w),
                    CustomHomeScreenItem(title: "Deposit", iconData: FontAwesomeIcons.piggyBank),
                    SizedBox(width: 4.w),
                    CustomHomeScreenItem(title: "Statements", iconData: FontAwesomeIcons.fileInvoice),
                    SizedBox(width: 4.w),
                    CustomHomeScreenItem(title: "Credit Score", iconData: FontAwesomeIcons.star),
                    SizedBox(width: 4.w),
                    CustomHomeScreenItem(title: "ChatBot", iconData: FontAwesomeIcons.robot),
                    SizedBox(width: 4.w),
                    CustomHomeScreenItem(title: "More", iconData: FontAwesomeIcons.ellipsis),
                    SizedBox(width: 2.w)
                  ],
                ),
              ),
            ],
          ),
        ),
      )
    );
  }

}