import 'package:application/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

class AccountInformation extends StatelessWidget {
  AccountInformation({
    Key? key ,
    required this.accountName,
    required this.accountId,
    required this.balance
  }) : super(key: key);

  String accountName;
  String accountId;
  String balance;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80.w,
      height: 50.w,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 3,
              blurRadius: 2,
              offset: Offset(2,3)
            )
          ],
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.black,
              Colors.black87,
              Colors.black54,
              Colors.black45,
            ]
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 5.w, top: 5.w),
                  child: Text(
                    accountName,
                    style: CustomTextStyles.titleMedium.copyWith(
                      color: Colors.white
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5.w, right: 5.w),
                  child: Icon(FontAwesomeIcons.circleInfo, color: Colors.white),
                )
              ],
            ),
            SizedBox(height: 5.w),
            Row(
              children: [
                SizedBox(width: 6.w),
                Icon(Icons.perm_identity, color: Colors.white,),
                SizedBox(width: 8),
                Text(
                  "Account ID: $accountId",
                  style: CustomTextStyles.titleSmall.copyWith(
                    color: Colors.white
                  )
                )
              ],
            ),
            SizedBox(height: 3.w),
            Row(
              children: [
                SizedBox(width: 6.w),
                Icon(Icons.account_balance, color: Colors.white,),
                SizedBox(width: 8),
                Text(
                  "Balance: \$$balance",
                  style: CustomTextStyles.titleSmall.copyWith(
                      color: Colors.white
                  )
                )
              ],
            ),
            SizedBox(height: 3.w),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(FontAwesomeIcons.ccVisa, color: Colors.white),
                SizedBox(width: 5.w)
              ],
            )
          ],
        ),
      ),
    );
  }

}