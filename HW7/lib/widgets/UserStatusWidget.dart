import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class UserStatusWidget extends StatelessWidget {
  
  final Map<String, int> userStatistics;
  
  const UserStatusWidget ({required this.userStatistics ,super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.max,
      children: userStatistics.entries
          .map((entry) =>
          Column(
            children: [
              Text(entry.key, style: TextStyle(fontSize: 17.sp),),
              Text('${entry.value}', style: TextStyle(fontSize: 20.sp, ),),
            ],
          ),
      ).toList(),
    );
  }
}