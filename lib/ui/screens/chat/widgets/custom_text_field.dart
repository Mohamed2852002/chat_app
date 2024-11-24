import 'package:chat_app/style/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.onBtnPressed,
    required this.controller,
  });
  final void Function() onBtnPressed;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: null,
      controller: controller,
      decoration: InputDecoration(
        hintText: 'Send Message',
        suffixIcon: IconButton(
          onPressed: () {
            onBtnPressed();
          },
          icon: Icon(
            Icons.send,
            color: AppColors.primaryColor,
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor),
          borderRadius: BorderRadius.circular(16.r),
        ),
      ),
    );
  }
}
