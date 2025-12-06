import 'package:flutter/material.dart';
import 'package:hommie/utils/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Profile Content',
        style: TextStyle(fontSize: 24, color: AppColors.textPrimaryLight),
      ),
    );
  }
}