import 'package:billi/configs/palette.dart';
import 'package:billi/modules/account/myProfile.dart';
import 'package:billi/modules/account/wallet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
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
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
              child: ListView(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Account Details',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: 5,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            InkWell(
                              onTap:()
                        {
                          if(index == 0) {
                            Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => MyProfile()));
                          }
                          if(index == 2)
                          {
                            Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => Wallet()));
                          }
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
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width * 0.85,
                      decoration: BoxDecoration(
                        color: Palette.blue,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      'My Referrals',
                                      style: TextStyle(
                                        fontSize: 23,
                                        color: Palette.white,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      '23',
                                      style: TextStyle(
                                          fontSize: 35,
                                          color: Palette.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      'My Rewards',
                                      style: TextStyle(
                                        fontSize: 23,
                                        color: Palette.white,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      '₹230',
                                      style: TextStyle(
                                          fontSize: 35,
                                          color: Palette.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: Text(
                                'My Referral Link',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Palette.white,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Container(
                                height: 40,
                                width: MediaQuery.of(context).size.width * 0.7,
                                decoration: BoxDecoration(
                                  color: Palette.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                    child: Text(
                                  " QAWRSEDRHNZFSEZ",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 15),
                                )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width * 0.35,
                          decoration: BoxDecoration(
                              color: Palette.white,
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(color: Palette.blue, width: 0.0)),
                          child: Center(
                              child: Text(
                            "Help & Support",
                            style: TextStyle(color: Palette.blue, fontSize: 15),
                          )),
                        ),
                        Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width * 0.35,
                          decoration: BoxDecoration(
                              color: Palette.blue,
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(color: Palette.blue, width: 0.0)),
                          child: Center(
                              child: Text(
                            "Log Out",
                            style:
                                TextStyle(color: Palette.white, fontSize: 15),
                          )),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
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
      trailing: (index != 4)
          ? Icon(
              Icons.arrow_back_ios,
              size: 15,
              color: Palette.blue,
            )
          : Transform.scale(
              scale: 0.8,
              child: CupertinoSwitch(
                value: _switchValue,
                activeColor: Palette.blue,
                onChanged: (value) {
                  setState(() {
                    _switchValue = value;
                  });
                },
              ),
            ),
      selected: true,
    );
  }
}
