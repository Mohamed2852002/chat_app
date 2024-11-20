import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomMessageDialog extends StatelessWidget {
  const CustomMessageDialog(
      {super.key,
      required this.message,
      required this.positiveBtnText,
      required this.onPositiveBtnPress});
  final String message;
  final String positiveBtnText;
  final void Function() onPositiveBtnPress;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      content: Text(message),
      contentTextStyle: TextStyle(
        fontSize: 18.sp,
        color: Colors.black,
      ),
      actions: [
        TextButton(
          onPressed: () {
            onPositiveBtnPress();
          },
          child: Text(positiveBtnText),
        ),
      ],
    );
  }
}
