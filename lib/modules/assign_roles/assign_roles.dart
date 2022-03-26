import 'package:flutter/material.dart';

class AssignRoles extends StatefulWidget {
  const AssignRoles({Key? key}) : super(key: key);

  @override
  State<AssignRoles> createState() => _AssignRolesState();
}

class _AssignRolesState extends State<AssignRoles> {
  String dropdownValue = 'One';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.arrow_back_rounded,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          // 'Supreme Museum',
          "Assign Roles",
          style: TextStyle(color: Colors.black, fontSize: 22.0),
        ),
        actions: [
          DropdownButton(
            items: <String>['One', 'Two', 'Free', 'Four']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue!;
              });
            },
          )
        ],
      ),
    );
  }
}
