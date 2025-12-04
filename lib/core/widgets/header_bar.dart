import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class HeaderBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onMenuClick;
  final VoidCallback? onNotificationClick;

  const HeaderBar({
    super.key,
    required this.onMenuClick,
    this.onNotificationClick,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: onMenuClick,
      ),
      title: const Text('MicroPOS'),
      actions: [
        Stack(
          children: [
            IconButton(
              icon: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.warningYellow,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.notifications,
                  color: AppColors.errorRed,
                  size: 20,
                ),
              ),
              onPressed: onNotificationClick ?? () {},
            ),
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                width: 12,
                height: 12,
                decoration: const BoxDecoration(
                  color: AppColors.errorRed,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 8),
      ],
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              AppColors.primaryPurple,
              AppColors.primaryPurpleDark,
            ],
          ),
        ),
      ),
    );
  }
}
