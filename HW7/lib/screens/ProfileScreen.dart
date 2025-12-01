import 'package:flutter/material.dart';
import 'package:hw_7/models/User.dart';
import 'package:hw_7/widgets/ProfileHeader.dart';
import 'package:hw_7/widgets/UserStatusWidget.dart';
import 'package:sizer/sizer.dart';

class ProfileScreen extends StatelessWidget {

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {

    User testUser = User(
      name: 'Serhii',
      surname: 'Kolesnykov',
      avatarUrl: 'assets/images/profile01.jpg',
      profession: 'Full stack developer',
      numberOfProjects: 10,
      numberOfSubscribers: 20,
      numberOfSubscriptions: 30,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('User profile'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.sp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            ProfileHeader(
              userFullName: testUser.fullName,
              userAvatarUrl: testUser.userAvatarUrl,
              userProfession: testUser.userProfession,
            ),
            Padding(padding: const EdgeInsets.all(20)),
            UserStatusWidget(userStatistics: testUser.userStatisticMap()),
          ],
        ),
      ),

    );
  }
}