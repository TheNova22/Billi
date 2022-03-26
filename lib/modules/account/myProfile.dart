import 'package:billi/configs/palette.dart';
import 'package:flutter/material.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {

  List<String> images = [
  "assets/images/profile.png",
  "assets/images/notification.png",
  "assets/images/rupee.png",
  "assets/images/lock.png",
  "assets/images/darkmode.png"
  ];
  List<String> titles = [
  "Account Details",
  "Notifications",
  "Wallet",
  "Lock",
  "Dark Mode"
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: SingleChildScrollView(
      child:SizedBox(
      height: MediaQuery.of(context).size.height,
    child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
    child: ListView(
    children: [
      SizedBox(
        height: 20,
      ),
      Text(
        'My Profile',
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      ),
      SizedBox(
        height: 20,
      ),
      ListView.builder(
          shrinkWrap: true,
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                InkWell(
                  onTap:()
                  {
                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.9,
                    margin: const EdgeInsets.only(bottom: 4),
                    decoration: BoxDecoration(
                      color: Palette.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Tile(images[index], titles[index], index),
                  ),
                ),
                SizedBox(
                  height: 10,
                )
              ],
            );
          }),
      ],
    )
    )
    )
      )

    ));
  }
  Widget Tile(String image, String title, int index) {
    bool _switchValue = true;
    return ListTile(
      leading: Image.asset(
        image,
        width: 30,
        height: 30,
      ),
      title: Text(
        title,
        style: TextStyle(color: Palette.blue, fontSize: 15),
      ),
      trailing:
           Icon(
        Icons.arrow_back_ios,
        size: 15,
        color: Palette.blue,
      )

    );
  }
}
