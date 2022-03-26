import 'package:billi/configs/palette.dart';
import 'package:billi/widgets/common_navigation_bar.dart';
import 'package:flutter/material.dart';

class UserHome extends StatefulWidget {
  const UserHome({Key? key}) : super(key: key);

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: CommonBottomNavigationBar(0),
        appBar: AppBar(
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
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height - 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 45.0,
                  margin: const EdgeInsets.symmetric(
                      horizontal: 25, vertical: 30.0),
                  child: TextField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        // width: 0.0 produces a thin "hairline" border
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 0.0),
                        borderRadius: BorderRadius.circular(22.0),
                      ),
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(
                        Icons.search,
                        size: 20,
                        color: Colors.grey,
                      ),
                      hintText: "Try Bangalore Fort",
                      hintStyle: const TextStyle(color: Colors.grey),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 14.0),
                      suffixIcon: const Icon(
                        Icons.mic,
                        size: 20,
                        color: Palette.orange,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    circularIcons('assets/logo/museum.png', 'Museum'),
                    circularIcons('assets/logo/gallery.png', 'Gallery'),
                    circularIcons('assets/logo/monument.png', 'Monument'),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 30, left: 25),
                  child: Text(
                    "Popular Places",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 3,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 8.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: 230,
                              margin: const EdgeInsets.only(bottom: 4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: GestureDetector(
                                onTap: () {},
                                child: Card(
                                  child: Column(
                                    children: [
                                      _bgPicture(index),
                                      Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            leftSection(index),
                                            rightSection(index)
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _bgPicture(int index) {
    return Container(
      width: double.maxFinite,
      height: 150,
      decoration: BoxDecoration(
          image: const DecorationImage(
              image: NetworkImage(
                "https://imagesvc.meredithcorp.io/v3/mm/image?q=60&c=sc&poi=face&w=1600&h=800&url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F28%2F2020%2F03%2Fgallery-uffizi-florence-italy-ONLINEMUSE0320.jpg",
              ),
              fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(8)),
    );
  }

  Widget leftSection(int index) {
    return SizedBox(
      height: 55,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          Text(
            "Supreme",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
          ),
          Text(
            "Central Road, Central Asia, Bangalore",
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

Widget rightSection(int index) {
  return SizedBox(
    height: 50,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          height: 25,
          width: 50,
          decoration: BoxDecoration(
              color: Palette.green, borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Text(
                  '4.3',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                Icon(
                  Icons.star,
                  color: Palette.white,
                  size: 15,
                ),
              ],
            ),
          ),
        ),
        const Text(
          "₹250 for one",
          style: TextStyle(color: Colors.grey, fontSize: 12),
        ),
      ],
    ),
  );
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
