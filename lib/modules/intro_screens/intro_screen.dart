import 'package:billi/configs/palette.dart';
import 'package:billi/modules/user_log_in_page/user_log_in_page.dart';
import 'package:billi/modules/user_register_page/user_register_page.dart';
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
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.white,
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
                height: 40,
                title: 'Login',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserLoginPage()),
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextButton(
                width: 300,
                height: 40,
                title: 'Register',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserRegisterPage()),
                  );
                },
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
