import 'package:flutter/material.dart';

const iconColor = Color.fromARGB(255, 12, 124, 205);

class CustomBottomBar extends StatelessWidget {
  final TabController controller;

  const CustomBottomBar({super.key, 
    required this.controller,
  });
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.home,
              color: iconColor,
            ),
            onPressed: () {
              controller.animateTo(0);
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.cloud_upload_rounded,
              color: iconColor,
            ),
            iconSize: 30,
            onPressed: () {
              controller.animateTo(1);
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.manage_accounts,
              color: iconColor,
            ),
            onPressed: () {
              controller.animateTo(2);
            },
          ),
        ],
      ),
    );
  }
}
