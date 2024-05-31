import 'package:flutter/material.dart';

import '../../../widgets/custom_editing_profile.dart';
import '../../../widgets/custom_profile.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Center(
        child: Column(
          children: [
            EditProfile(),

          ],
        ),
      ),
    );
  }
}
