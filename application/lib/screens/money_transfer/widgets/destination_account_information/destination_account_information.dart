import 'package:application/screens/money_transfer/notifiers/money_transfer_screen_notifier.dart';
import 'package:application/screens/money_transfer/widgets/destination_account_information/models/destination_account_information_model.dart';
import 'package:application/theme/theme.dart';
import 'package:application/utils/string_utils.dart';
import 'package:application/widgets/custom_text_field_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

class DestinationAccountInformation extends ConsumerStatefulWidget {
  const DestinationAccountInformation({super.key});

  @override
  DestinationAccountInformationState createState() => DestinationAccountInformationState();
}

class DestinationAccountInformationState extends ConsumerState<DestinationAccountInformation> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DestinationAccountInformationModel destinationAccountInformationModel = DestinationAccountInformationModel(
    destinationAccountId: "",
    destinationAccountName: "",
    amountOfTransferMoney: ""
  );

  @override
  Widget build(BuildContext context) {
    final user = ref.read(moneyTransferScreenNotifier);

    return SizedBox(
      width: 80.w,
      height: 80.w,
      child: Container(
        constraints: BoxConstraints.tight(Size.fromWidth(80.w)),
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
              Colors.brown.shade900,
              Colors.brown.shade700,
              Colors.brown.shade500,
              Colors.brown.shade300,
            ]
          )
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top:5.w, left: 5.w, right: 5.w),
                child: TextFormField(
                  style: CustomTextStyles.titleSmall.copyWith(
                    color: Colors.white
                  ),
                  decoration: CustomTextFieldStyles.destinationAccountIdTextFieldDecoration,
                  onChanged: (value) {
                    setState(() {
                      destinationAccountInformationModel
                        .destinationAccountName = value;
                    });
                  },
                  validator: (value) {
                    if(value == null || value.length != 10)
                      return "Account ID is invalid!";
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top:5.w, left: 5.w, right: 5.w),
                child: TextFormField(
                  style: CustomTextStyles.titleSmall.copyWith(
                    color: Colors.white
                  ),
                  decoration: CustomTextFieldStyles.amountOfTransferMoneyTextFieldDecoration,
                  onChanged: (value) {
                    setState(() {
                      destinationAccountInformationModel
                        .amountOfTransferMoney = value;
                    });
                  },
                  validator: (value) {
                    if(value == null || !StringUtils.isNonNegativeNumeric(value))
                      return "Try again!";
                    return null;
                  },
                ),
              ),
              SizedBox(height: 2.w),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.black
                ),
                child: Text(
                  "Search",
                  style: CustomTextStyles.titleSmall.copyWith(
                    color: Colors.white
                  ),
                ),
                onPressed: () async {

                },
              )
            ]
          ),
        ),
      ),
    );
  }
}
