import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomHomeScreenItem extends StatelessWidget {
  CustomHomeScreenItem({
    Key? key,
    required this.title,
    required this.iconData,
    this.onTap,
    this.height,
    this.width,
  }) : super(key: key);

  IconData iconData;
  VoidCallback? onTap;
  String title;
  double? height;
  double? width;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 15.h,
      width: width ?? 12.h,
      child: Column(
        children: [
          IconButton(
            onPressed: onTap,
            iconSize: 3.3.h,
            icon: Container(
              padding: EdgeInsets.only(left: 1.h, top: 1.h),
              alignment: Alignment.topLeft,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 1.5,
                    blurRadius: 5,
                    offset: Offset(1,2)
                  )
                ],
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.black),
                gradient: SweepGradient(
                  colors: [
                    Colors.black38,
                    Colors.black87,
                    Colors.black38
                  ]
                )
              ),
              height: 8.h,
              width: 8.h,
              child: Icon(
                iconData,
                color: Colors.white,
              ),
            ),
          ),
          Text(title, style: TextStyle(fontFamily: "Urbanist", fontWeight: FontWeight.w800, fontSize: 9.sp), textAlign: TextAlign.center)
        ],
      )
    );
  }

}