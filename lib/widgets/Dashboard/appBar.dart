import 'package:flutter/material.dart';
import 'package:pos_system/widgets/drawer.dart';
import 'package:pos_system/widgets/loginScreen.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Welcome '),
      actions: [
        PopupMenuButton(
          itemBuilder: (BuildContext context) {
            return [
              const PopupMenuItem(
                child: Text('Profile'),
                value: 'profile',
              ),
              const PopupMenuItem(
                child: Text('Logout'),
                value: 'logout',
              ),
            ];
          },
          onSelected: (value) {
            if (value == 'profile') {
              // Handle profile option

              print('Go to Profile');
            } else if (value == 'logout') {
              // Handle logout option
              print('Logout');
              Navigator.pushReplacementNamed(context, '/splash_screen');
            }
          },
        ),
      ],
    );
  }
}
