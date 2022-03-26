import 'package:billi/configs/palette.dart';
import 'package:billi/modules/account/myProfile.dart';
import 'package:billi/modules/account/wallet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MuseumDescription extends StatefulWidget {
  const MuseumDescription({Key? key}) : super(key: key);

  @override
  State<MuseumDescription> createState() => _MuseumDescription();
}

class _MuseumDescription extends State<MuseumDescription> {
  List<String> images = ["assets/images/image1.png","assets/images/image2.png"];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: ListView(
              children: [
              Stack(
                children: [
                  Container(
                  width: double.maxFinite,
                  height: 350,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            "assets/images/image3.png",
                          ),
                            fit: BoxFit.cover,

                          ),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(25),
                      bottomLeft: Radius.circular(25),
                    ),
            ),

                  ),

                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          "assets/images/backarrow.png",
                          width: 30,
                          height: 30,
                        ),
                        Image.asset(
                          "assets/images/photo.png",
                          width: 30,
                          height: 30,
                        ),
                      ],
                    ),

                  ),
                  Positioned(
                    top: 250,
                    left: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Supreme Museum',
                          style: TextStyle(
                            fontSize: 35,
                            color: Palette.white,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Central Road, Central Asia, Bangalore',
                          style: TextStyle(
                              fontSize: 20,
                              color: Palette.white,
                             ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 15,
                          color: Palette.black,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 270),
                        child: Divider(thickness: 2,color: Palette.blue,),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi quis ligula ac libero malesuada consequat eget ut velit. Vestibulum interdum ullamcorper urna vel luctus. Aliquam blandit, tortor nec semper rhoncus, augue lacus rutrum urna, id posuere turpis lacus vitae ante. Donec leo nibh, cursus quis augue ut, ullamcorper varius ex. ',
                        style: TextStyle(

                          fontSize: 15,
                          color: Palette.black,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Souvenirs',
                        style: TextStyle(
                          fontSize: 15,
                          color: Palette.black,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 270),
                        child: Divider(thickness: 2,color: Palette.blue,),
                      ),

                      Row(
                        children: [
                          Image.asset(
                            images[0],
                            width: 150,
                            height: 200,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Image.asset(
                            images[1],
                            width: 150,
                            height: 200,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }


}
