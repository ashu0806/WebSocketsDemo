import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageItem extends StatelessWidget {
  const MessageItem({
    super.key,
    required this.sendByMe,
    required this.message,
  });
  final bool sendByMe;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 10.w,
          vertical: 4.h,
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 10.w,
          vertical: 4.h,
        ),
        decoration: BoxDecoration(
          color: sendByMe ? Colors.blue : Colors.grey,
          borderRadius: BorderRadius.circular(
            10.r,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(
            10.sm,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                message,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 5.w,
              ),
              Text(
                "10:15 PM",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
