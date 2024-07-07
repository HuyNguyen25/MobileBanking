import 'package:application/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomHomeScreenItem extends StatelessWidget {
  CustomHomeScreenItem({
    Key? key,
    required this.title,
    required this.imagePath,
    this.onTap
  }) : super(key: key);

  String imagePath;
  VoidCallback? onTap;
  String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 14.h,
      width: 12.h,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
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
                icon: Image.asset(
                  imagePath,
                  fit: BoxFit.fill,
                ),
                onPressed: onTap,
              ),
            ),
          ),
          SizedBox(height: 1.5,),
          Text(title, style: TextStyle(fontWeight: FontWeight.w600))
        ],
      )
    );
  }

}