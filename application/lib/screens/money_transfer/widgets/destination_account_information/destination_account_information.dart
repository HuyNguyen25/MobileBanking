import 'package:application/database_services/core_service.dart';
import 'package:application/screens/money_transfer/notifiers/money_transfer_screen_notifier.dart';
import 'package:application/screens/money_transfer/widgets/destination_account_information/models/destination_account_information_model.dart';
import 'package:application/theme/theme.dart';
import 'package:application/utils/string_utils.dart';
import 'package:application/widgets/custom_text_field_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
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
    amountOfTransferMoney: "",
    date: "",
    title: "",
    destinationAccountNameVisibility: false
  );

  @override
  Widget build(BuildContext context) {
    final user = ref.read(moneyTransferScreenNotifier);

    return SizedBox(
      width: 80.w,
      //height: 80.w,
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
            mainAxisSize: MainAxisSize.min,
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
                        .destinationAccountNameVisibility = false;
                      destinationAccountInformationModel
                        .destinationAccountId = value;
                    });
                  },
                  validator: (value) {
                    if(value == null || value.length != 15 || value == user!.accountId)
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
                        .destinationAccountNameVisibility = false;
                      destinationAccountInformationModel
                        .amountOfTransferMoney = value;
                    });
                  },
                  validator: (value) {
                    if(value == null || !StringUtils.isNonNegativeNumeric(value) || double.parse(value!) > user!.balance)
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
                  if(_formKey.currentState!.validate()) {
                    final receiver = await CoreService.getAccountName(
                      accountId: destinationAccountInformationModel.destinationAccountId
                    );

                    if(receiver != null) {
                      setState(() {
                        destinationAccountInformationModel
                          .destinationAccountName = receiver;
                        destinationAccountInformationModel
                          .destinationAccountNameVisibility = true;
                      });
                    }
                    else {
                      setState(() {
                        destinationAccountInformationModel
                            .destinationAccountNameVisibility = false;
                      });
                      await _showFailToFindDestinationAccountDialog();
                    }
                  }
                },
              ),
              SizedBox(height: 1.2.w),
              destinationAccountInformationModel.destinationAccountNameVisibility ?
              Flexible(
                child: Text(
                  "\$ ${destinationAccountInformationModel.amountOfTransferMoney} to ${destinationAccountInformationModel.destinationAccountName}",
                  style: CustomTextStyles.titleSmall.copyWith(color: Colors.white),
                ),
              ) : Container(height: 0),
              SizedBox(height: 1.2.w),
              destinationAccountInformationModel.destinationAccountNameVisibility ?
              TextFormField(
                style: CustomTextStyles.titleSmall.copyWith(
                  color: Colors.white
                ),
                decoration: CustomTextFieldStyles.transferTitleTextFieldDecoration,
                onChanged: (value) {
                  setState(() {
                    destinationAccountInformationModel.title = value;
                  });
                },
                validator: (value) {
                  if(value!= null && value.length > 100)
                    return "Title is too long!";
                  return null;
                },
              ) : Container(height: 0),
              SizedBox(height: 1.2.w),
              destinationAccountInformationModel.destinationAccountNameVisibility ?
              TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: Colors.black
                ),
                child: Text(
                  "Confirm",
                  style: CustomTextStyles.titleSmall.copyWith(
                      color: Colors.white
                  ),
                ),
                onPressed: () async {
                  if(!_formKey.currentState!.validate())
                    return;

                  await CoreService.transferMoney(
                    sourceAccountId: user!.accountId,
                    destinationAccountId: destinationAccountInformationModel.destinationAccountId,
                    amountOfMoney: double.parse(destinationAccountInformationModel.amountOfTransferMoney)
                  );

                  //hide transfer confirmation
                  setState(() {
                    destinationAccountInformationModel.date = DateFormat.yMMMMd('en_US').add_jm().format(DateTime.now());
                  });

                  //show dialog indicating a successful transfer
                  await _showSucessfulTransferDialog();
                },
              ) : Container(height: 0),
              SizedBox(height: 5.w),
            ]
          ),
        ),
      ),
    );
  }

  Future<void> _showFailToFindDestinationAccountDialog() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: Text("Error!", style: CustomTextStyles.titleMedium),
          content: Text("Destination account ID may be incorrect.", style: CustomTextStyles.titleSmall)
      )
    );
  }

  Future<void> _showSucessfulTransferDialog() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
            title: Text("Transfer Completed", style: CustomTextStyles.titleMedium),
            content: Text(
              "\$${destinationAccountInformationModel.amountOfTransferMoney} to "
                  "${destinationAccountInformationModel.destinationAccountId} (${destinationAccountInformationModel.destinationAccountName}) "
                  "at ${destinationAccountInformationModel.date} -"
                  " title: ${destinationAccountInformationModel.title}.",
              style: CustomTextStyles.titleSmall
            ),
          actions: [
            TextButton(
              child: Text("Dismiss", style: CustomTextStyles.titleMedium.copyWith(fontSize: 14.sp)),
              onPressed: () async {
                //reset model to initial state, except receiver's ID and amount of transfer money
                setState(() {
                  destinationAccountInformationModel.destinationAccountNameVisibility = false;
                  destinationAccountInformationModel.title = "";
                  destinationAccountInformationModel.date = "";
                  destinationAccountInformationModel.destinationAccountName = "";
                });
                Navigator.of(context).pop();
              },
            )
          ],
        )
    );
  }
}
