import 'package:application/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomHomeScreenItem extends StatelessWidget {
  CustomHomeScreenItem({
    Key? key,
    required this.title,
    required this.imagePath,
    this.onTap,
    this.height,
    this.width,
  }) : super(key: key);

  String imagePath;
  VoidCallback? onTap;
  String title;
  double? height;
  double? width;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 14.h,
      width: width ?? 12.h,
      child: Column(
        children: [
          Container(
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
                  Colors.grey,
                  Colors.black12,
                  Colors.grey
                ]
              )
            ),
            height: 8.h,
            width: 8.h,
            child: Padding(
              padding: EdgeInsets.all(3),
              child: IconButton(
                icon: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.fill,
                  ),
                ),
                onPressed: onTap,
              ),
            ),
          ),
          SizedBox(height: 1.5,),
          Text(title, style: TextStyle(fontWeight: FontWeight.w600), textAlign: TextAlign.center)
        ],
      )
    );
  }

}