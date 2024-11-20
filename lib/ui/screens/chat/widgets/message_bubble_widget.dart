import 'package:chat_app/firestore/models/message.dart';
import 'package:chat_app/style/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageBubbleWidget extends StatelessWidget {
  const MessageBubbleWidget({super.key, required this.message});
  final Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.only(left: 110.w, right: 16.w),
        padding: EdgeInsets.all(20.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32.r),
            topRight: Radius.circular(32.r),
            bottomLeft: Radius.circular(32.r),
          ),
          color: AppColors.primaryColor,
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
    );
  }
}

// Positioned(
//               child: Text(
//                 DateFormat('hh:mm a').format(
//                     DateTime.fromMillisecondsSinceEpoch(
//                         message.messageTime.microsecondsSinceEpoch)),
//                 textAlign: TextAlign.right,
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 10.sp,
//                 ),
//               ),
//             ),
