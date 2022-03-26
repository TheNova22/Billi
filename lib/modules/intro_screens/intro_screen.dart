import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../widgets/custom_text_button.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

final List<String> imgList = [
  'assets/images/intro-1.png',
  'assets/images/intro-2.png',
  'assets/images/intro-3.png',
];

final List<String> imgText = [
  'Manage your bookings!',
  'Revise slots!',
  'Get instant E-tickets!',
];

final List<Widget> imageSliders = imgList
    .map((item) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.all(5.0),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  child:
                      //  Column(
                      // children: <Widget>[
                      Image.asset(
                    item,
                    height: 200,
                    fit: BoxFit.contain,
                  ),

                  // Positioned(
                  //   bottom: 0.0,
                  //   left: 0.0,
                  //   right: 0.0,
                  //   child: Container(
                  //     decoration: const BoxDecoration(
                  //       gradient: LinearGradient(
                  //         colors: [
                  //           Color.fromARGB(200, 0, 0, 0),
                  //           Color.fromARGB(0, 0, 0, 0)
                  //         ],
                  //         begin: Alignment.bottomCenter,
                  //         end: Alignment.topCenter,
                  //       ),
                  //     ),
                  //     padding: const EdgeInsets.symmetric(
                  //         vertical: 10.0, horizontal: 20.0),
                  //     child: Text(
                  //       'No. ${imgList.indexOf(item)} image',
                  //       style: const TextStyle(
                  //         color: Colors.white,
                  //         fontSize: 20.0,
                  //         fontWeight: FontWeight.bold,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // ],
                  // )
                ),
              ),
            ),
            const SizedBox(
              height: 7,
            ),
            Text(
              imgText[imgList.indexOf(item)],
              style: const TextStyle(
                fontFamily: 'Lato',
                fontSize: 20.0,
              ),
            )
          ],
        ))
    .toList();

class _IntroScreenState extends State<IntroScreen> {
  // @override
  // Widget build(BuildContext context) {
  // return
// CarouselSlider(
//         items: items,
//         options: CarouselOptions(
//           height: 400,
//           aspectRatio: 16 / 9,
//           viewportFraction: 0.8,
//           initialPage: 0,
//           enableInfiniteScroll: true,
//           reverse: false,
//           autoPlay: true,
//           autoPlayInterval: const Duration(seconds: 3),
//           autoPlayAnimationDuration: const Duration(milliseconds: 800),
//           autoPlayCurve: Curves.fastOutSlowIn,
//           enlargeCenterPage: true,
//           onPageChanged: callbackFunction,
//           scrollDirection: Axis.horizontal,
//         ));
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          const Text(
            'Welcome!',
            style: TextStyle(fontFamily: 'Allura', fontSize: 60),
          ),
          // Expanded(
          //   child:
          CarouselSlider(
            items: imageSliders,
            carouselController: _controller,
            options: CarouselOptions(
                height: 300,
                autoPlay: true,
                enlargeCenterPage: true,
                // aspectRatio: 2.0,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
          ),
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imgList.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _controller.animateToPage(entry.key),
                child: Container(
                    width: 12.0,
                    height: 12.0,
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black
                          .withOpacity(_current == entry.key ? 0.9 : 0.4),
                    )),
              );
            }).toList(),
          ),
          Column(
            children: [
              CustomTextButton(
                width: 300,
                height: 43,
                title: 'Login',
                onTap: () {},
              ),
              const SizedBox(
                height: 7,
              ),
              CustomTextButton(
                width: 300,
                height: 43,
                title: 'Register',
                onTap: () {},
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
