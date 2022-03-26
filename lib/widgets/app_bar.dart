import 'package:billi/configs/palette.dart';
import 'package:flutter/material.dart';

class BilliAppBar extends StatelessWidget with PreferredSizeWidget {
  const BilliAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Palette.white,
      elevation: 0,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Bangalore',
            style: TextStyle(color: Palette.orange, fontSize: 15),
          ),
          Text(
            'MSR college, Mathikere',
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
      leading: const Icon(
        Icons.location_on_rounded,
        color: Palette.orange,
        size: 25,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: CircleAvatar(
            radius: 20.0,
            child: Image.asset(
              'assets/logo/cat.png',
              width: 25,
              height: 25,
              fit: BoxFit.cover,
            ),
            backgroundColor: Palette.orange,
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
