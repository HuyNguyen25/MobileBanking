import 'package:application/models/transaction.dart';
import 'package:application/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

class HistoryItem extends StatelessWidget {
  HistoryItem({super.key, required this.transaction});

  Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.w,vertical: 2.h),
        child: Row(
          children: [
            Icon(FontAwesomeIcons.commentDollar),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                transaction.details,
                style: CustomTextStyles.titleSmall.copyWith(
                  color: CustomColors.gray900
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Icon(FontAwesomeIcons.ellipsis)
          ],
        ),
      ),
    );
  }

}