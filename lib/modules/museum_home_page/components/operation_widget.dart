import 'package:billi/configs/palette.dart';
import 'package:billi/modules/assign_roles/assign_roles.dart';
import 'package:flutter/material.dart';

class OperationWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  const OperationWidget({Key? key, required this.icon, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
      child: InkWell(
        child: SizedBox(
          width: width / 3 - 10.0,
          child: Column(
            children: [
              Icon(
                icon,
                // Icons.person_add_alt_1_outlined,
                color: Palette.orange,
                size: 35.0,
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
