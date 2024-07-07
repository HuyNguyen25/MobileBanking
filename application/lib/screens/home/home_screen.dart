import 'package:application/constants/image_constants.dart';
import 'package:application/constants/pocketbase.dart';
import 'package:application/database_services/SynchronizationService.dart';
import 'package:application/models/user.dart';
import 'package:application/screens/authentication/sign_in/notifiers/sign_in_section_notifier.dart';
import 'package:application/screens/home/notifiers/home_screen_notifier.dart';
import 'package:application/screens/home/widgets/AccountInformation.dart';
import 'package:application/screens/home/widgets/custom_home_screen_item.dart';
import 'package:application/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends ConsumerStatefulWidget {
  HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    User? currentUser = ref.read(homeScreenNotifier);
    if(currentUser != null) {
      PocketbaseConstants.pocketbaseObject.collection("accounts").subscribe(
        currentUser.id,
        (e) async {
          final result = await SynchronizationService.getCurrentUserUpdate(id: currentUser.id);
          ref.read(homeScreenNotifier.notifier).changeUser(result);
        }
      );
    }
  }

  @override
  void dispose() {
    PocketbaseConstants.pocketbaseObject.collection("accounts").unsubscribe();
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
        icon: Icon(Icons.logout),
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
          color: Colors.black45
        ),
      ),
      title: Text("eBanking", style: CustomTextStyles.titleMedium.copyWith(color: CustomColors.gray900)),
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () async {

          },
        ),
        IconButton(
          icon: Icon(Icons.mail),
          onPressed: () async {

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
              SizedBox(height: 2.h),
              SizedBox(height: 3.h),
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
                height: 15.h,
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: [
                    SizedBox(width: 2.w),
                    CustomHomeScreenItem(title: "Pay Bills", imagePath: ImageConstants.payBillsPath),
                    SizedBox(width: 4.w),
                    CustomHomeScreenItem(title: "Pay Taxes", imagePath: ImageConstants.payTaxesPath),
                    SizedBox(width: 4.w),
                    CustomHomeScreenItem(title: "QR", imagePath: ImageConstants.qrPath),
                    SizedBox(width: 4.w),
                    CustomHomeScreenItem(title: "Stock", imagePath: ImageConstants.stockPath),
                    SizedBox(width: 4.w),
                    CustomHomeScreenItem(title: "More", imagePath: ImageConstants.morePath),
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
                height: 15.h,
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: [
                    SizedBox(width: 2.w),
                    CustomHomeScreenItem(title: "Money Transfer", imagePath: ImageConstants.moneyTransferPath),
                    SizedBox(width: 4.w),
                    CustomHomeScreenItem(title: "Apple Wallet", imagePath: ImageConstants.applePayPath),
                    SizedBox(width: 4.w),
                    CustomHomeScreenItem(title: "PayPal", imagePath: ImageConstants.paypalPath),
                    SizedBox(width: 4.w),
                    CustomHomeScreenItem(title: "Google Wallet", imagePath: ImageConstants.googleWalletPath),
                    SizedBox(width: 4.w),
                    CustomHomeScreenItem(title: "More", imagePath: ImageConstants.morePath),
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
                height: 15.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomHomeScreenItem(title: "Debit", imagePath: ImageConstants.debitPath),
                    CustomHomeScreenItem(title: "Debit", imagePath: ImageConstants.debitPath),
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
                height: 15.h,
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: [
                    SizedBox(width: 2.w),
                    CustomHomeScreenItem(title: "Deposit", imagePath: ImageConstants.depositPath),
                    SizedBox(width: 4.w),
                    CustomHomeScreenItem(title: "Finance", imagePath: ImageConstants.financePath),
                    SizedBox(width: 4.w),
                    CustomHomeScreenItem(title: "Credit Score", imagePath: ImageConstants.creditScorePath),
                    SizedBox(width: 4.w),
                    CustomHomeScreenItem(title: "ChatBot", imagePath: ImageConstants.chatBotPath),
                    SizedBox(width: 4.w),
                    CustomHomeScreenItem(title: "More", imagePath: ImageConstants.morePath),
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