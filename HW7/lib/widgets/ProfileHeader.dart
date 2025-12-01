import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ProfileHeader extends StatelessWidget {

  final String userFullName;
  final String? userAvatarUrl;
  final String userProfession;

  const ProfileHeader({
    required this.userFullName,
    required this.userAvatarUrl,
    required this.userProfession,
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Row(
      children: [
        CircleAvatar(
          radius: 34.sp,
          backgroundImage: userAvatarUrl != null ? AssetImage(userAvatarUrl!) : null,
          child: userAvatarUrl == null ? const Icon(Icons.person, size: 40, color: Colors.white,) : null ,
        ),
        SizedBox(width: 5.w,),
        Expanded(
            child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            Text( userFullName , style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),),
            SizedBox(height: 2.h,),
            Text(userProfession, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
          ],
        )
        ),
      ],
    );
  }
}