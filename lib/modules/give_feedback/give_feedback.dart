// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:billi/configs/palette.dart';
import 'package:billi/widgets/custom_text_button.dart';
import 'package:billi/widgets/custom_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FeedbackPage extends StatefulWidget {
  FeedbackPage({Key? key, this.transactionId = 'xivqv3JEr4YnSjt4xewA'})
      : super(key: key);
  final String transactionId;
  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

// TODO : Add a focus so that as the user presses  enter, he/she directly goes to next text field.

class _FeedbackPageState extends State<FeedbackPage> {
  final auth = FirebaseAuth.instance;
  final store = FirebaseFirestore.instance;

  TextEditingController ratingController = TextEditingController();
  TextEditingController reviewController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  String mid = "";
  String mName = "";
  double rating = 0;

  Future getTransactionDeets() async {
    await store
        .collection("transactions")
        .doc(widget.transactionId)
        .get()
        .then((value) {
      mid = value.data() == null ? "Supreme" : value.data()!["mid"];
    });
    await store.collection("museums").doc(mid).get().then((value) {
      mName = value.data() == null ? "Supreme" : value.data()!["name"];
      print(mName);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getTransactionDeets().then((value) {
      setState(() {});
    });
    super.initState();
  }

  void sendFeedback() async {
    try {
      await store.collection('feedback').add({
        'tid': widget.transactionId,
        'review': reviewController.text.trim(),
        'timestamp': DateTime.now().microsecondsSinceEpoch,
        'rating': rating
      }).then((value) async {
        await store
            .collection('feedback')
            .doc(value.id)
            .update({"fid": value.id});
        final museumdata = await store.collection('museums').doc(mid).get();
        final oldrating = museumdata.data()!['rating'];
        final newrating = (oldrating == 0) ? rating : (rating + oldrating) / 2;
        await store
            .collection('museums')
            .doc(mid)
            .update({'rating': newrating});
      });
    } on PlatformException catch (error) {
      var message = "Something's wrong";
      if (error.message != null) {
        message = error.message!;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
    } on FirebaseAuthException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message!),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = min(MediaQuery.of(context).size.width - 20, 320);
    return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Container(
          height: 280,
          width: w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              RotatedBox(
                quarterTurns: 3,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 280,
                      alignment: Alignment.center,
                      child: AutoSizeText(
                        "Feedback".toUpperCase(),
                        minFontSize: 18,
                        maxFontSize: 34,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Palette.black,
                          fontSize: 34,
                          fontFamily: 'Lato',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 280,
                      height: 2,
                      color: Palette.orange,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.museum_outlined,
                          size: 30,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        AutoSizeText(
                          mName,
                          minFontSize: 18,
                          maxFontSize: 22,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Palette.gold,
                              fontSize: 22,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RatingBar.builder(
                      initialRating: 0,
                      minRating: 1,
                      direction: Axis.horizontal,
                      // allowHalfRating: true,
                      itemSize: 25,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Palette.orange,
                      ),
                      onRatingUpdate: (stars) {
                        setState(() {
                          rating = stars;
                          print(rating);
                        });
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      controller: reviewController,
                      width: w - 100,
                      height: 130,
                      maxLines: null,
                      title: 'Review',
                      fontSize: 11,
                      hint: 'Talk about your experience here',
                      suffixWidget: null,
                      inputType: TextInputType.name,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextButton(
                        width: w - 150,
                        height: 30,
                        title: "Submit",
                        onTap: () {
                          sendFeedback();
                          Navigator.pop(context);
                        })
                  ],
                ),
              )
            ],
          ),
        ));
    // SafeArea(
    //   child: Scaffold(
    //     body: SingleChildScrollView(
    //       child: Center(
    //           child: Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           Text(
    //             'Feedback Form for ticket number' + widget.transactionId,
    //             style: TextStyle(fontSize: 30),
    //           ),
    //           CustomTextField(
    //             controller: ratingController,
    //             width: 300,
    //             height: 74,
    //             title: 'rating',
    //             hint: '1 - 5',
    //             suffixWidget: null,
    //             inputType: TextInputType.name,
    //           ),
    //           SizedBox(
    //             height: 20,
    //           ),
    // CustomTextField(
    //   controller: reviewController,
    //   width: 300,
    //   height: 74,
    //   title: 'Desc',
    //   hint: 'Enter any detail of review here',
    //   suffixWidget: null,
    //   inputType: TextInputType.name,
    // ),
    //           SizedBox(
    //             height: 20,
    //           ),
    //           CustomTextButton(
    //             width: 300,
    //             height: 43,
    //             title: 'Give feedback',
    //             onTap: () {
    //               sendFeedback();
    //               Navigator.push(
    //                 context,
    //                 MaterialPageRoute(
    //                     builder: (context) =>
    //                         MyHomePage(title: 'Signed up staff member')),
    //               );
    //               // signIn();
    //             },
    //           ),
    //           SizedBox(
    //             height: 20,
    //           ),
    //         ],
    //       )),
    //     ),
    //   ),
    // );
  }
}
