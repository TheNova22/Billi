import 'package:billi/configs/palette.dart';
import 'package:flutter/material.dart';

class Wallet extends StatefulWidget {
  const Wallet({Key? key}) : super(key: key);

  @override
  State<Wallet> createState() => _Wallet();
}

class _Wallet extends State<Wallet> {
  List<String> t1 = ["BILL-I CASH AMOUNT","REWARD POINTS"];
  List<String> t2 = ["₹200","₹50"];
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
                        Row(

                          children: [
                            GestureDetector(
                              onTap: ()
                  {Navigator.pop(context);
                  },
                              child: Image.asset(
                                'assets/images/arrow.png',
                                width: 30,
                                height: 30,
                              ),
                            ),
                            SizedBox(width: 20,),

                            Text(
                              'Billi',
                              style: TextStyle(fontFamily: 'Allura',fontSize: 35,),
                            ),
                            SizedBox(width: 20,),
                            Text(
                              'wallet',
                              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
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
                                            'Billi Wallet',
                                            style: TextStyle(fontFamily: 'Allura',fontSize: 35,color: Palette.white),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'Mr. robert samuel',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Palette.white,
                                             ),
                                          ),
                                        ],
                                      ),
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
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(top: 30),
                                    child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(left: 10, right: 10),
                                          child: Container(
                                            height: 40,
                                            width: MediaQuery.of(context).size.width * 0.3,
                                            decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius: BorderRadius.circular(5),
                                            ),
                                           ),

                                          ),
                                        Column(
                                          children: [
                                            Text(
                                              'Wallet Balance',
                                              style: TextStyle(
                                                fontSize: 20,
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
                                  ),

                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 40,
                              width: MediaQuery.of(context).size.width * 0.3,
                              decoration: BoxDecoration(
                                  color: Palette.orange,
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                  Border.all(color: Palette.orange, width: 0.0)),
                              child: Center(
                                  child: Text(
                                    "ADD CASH",
                                    style:
                                    TextStyle(color: Palette.white, fontSize: 15),
                                  )),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width * 0.3,
                      decoration: BoxDecoration(
                        boxShadow: [BoxShadow(
                          color: Colors.grey,
                          blurRadius: 5.0,
                        ),],
                          color: Palette.white,
                          borderRadius: BorderRadius.circular(10),
                          border:
                          Border.all(color: Palette.white, width: 0.0)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            t1[0],
                            style: TextStyle(color: Palette.blue, fontSize: 15),
                          ),
                          Text(
                            t2[0],
                            style: TextStyle(color: Palette.black, fontSize: 15),
                          ),
                          Text(
                            "History",
                            style: TextStyle(color: Palette.blue, fontSize: 15),
                          ),
                        ],
                      ),

                    ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width * 0.3,
                          decoration: BoxDecoration(
                              boxShadow: [BoxShadow(
                                color: Colors.grey,
                                blurRadius: 5.0,
                              ),],
                              color: Palette.white,
                              borderRadius: BorderRadius.circular(10),
                              border:
                              Border.all(color: Palette.white, width: 0.0)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                t1[1],
                                style: TextStyle(color: Palette.blue, fontSize: 15),
                              ),
                              Text(
                                t2[1],
                                style: TextStyle(color: Palette.black, fontSize: 15),
                              ),
                              Text(
                                "History",
                                style: TextStyle(color: Palette.blue, fontSize: 15),
                              ),
                            ],
                          ),

                        ),


                        SizedBox(
                          height: 30,
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "BILL-I  WALLET  BENEFITS",
                            style: TextStyle(color: Palette.blue, fontSize: 15),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            circularIcons('assets/images/rupee1.png', 'Quick Refunds'),
                            circularIcons('assets/images/tap.png', 'One-Tap payment'),
                            circularIcons('assets/images/badge.png', 'Special Discounts'),
                          ],
                        ),

                      ],
                    )
                )
            )
        )

    ));
  }
  Widget circularIcons(String image, String title) {
    return Column(
      children: [
        CircleAvatar(
          radius: 25.0,
          child: Image.asset(
            image,
            width: 25,
            height: 25,
            fit: BoxFit.cover,
          ),
          backgroundColor: Palette.blue,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: const TextStyle(color: Colors.black, fontSize: 12),
          ),
        ),
      ],
    );
  }

}
