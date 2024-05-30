// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:task_manager/constant/app_colors.dart';
import 'package:task_manager/constant/app_style.dart';

class CommonButton extends StatelessWidget {
  final void Function()? onTap;
  final String title;
  final Color? color;
  final Color? textColor;
  const CommonButton(
      {super.key, this.onTap, required this.title, this.color, this.textColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: color ?? buttonColor,
          borderRadius: BorderRadius.circular(05),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: AppTextStyle.normalSemiBold15
              .copyWith(color: textColor ?? appWhiteColor),
        ),
      ),
    );
  }
}
