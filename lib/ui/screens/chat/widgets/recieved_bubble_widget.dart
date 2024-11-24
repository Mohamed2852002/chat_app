import 'package:chat_app/firestore/models/message.dart';
import 'package:chat_app/style/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class RecievedBubbleWidget extends StatelessWidget {
  const RecievedBubbleWidget({super.key, required this.message});
  final Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(left: 16.w, right: 80.w),
            padding: REdgeInsets.only(
              right: 22,
              left: 40,
              top: 15,
              bottom: 30,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32.r),
                topRight: Radius.circular(32.r),
                bottomRight: Radius.circular(32.r),
              ),
              color: AppColors.secondaryColor,
            ),
            child: Text(
              message.content,
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
              ),
            ),
          ),
          Positioned(
            left: 30.w,
            bottom: 7.h,
            child: Text(
              DateFormat('h:mm a').format(
                DateTime.fromMillisecondsSinceEpoch(
                  message.messageTime.millisecondsSinceEpoch,
                ),
              ),
              style: TextStyle(
                color: Colors.white,
                fontSize: 11.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
