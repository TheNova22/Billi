import 'package:billi/modules/model_check/model_check.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';

class MyHomePage extends StatefulWidget {
  final List<CameraDescription> cameras;

  MyHomePage(this.cameras);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String predOne = '';
  double confidence = 0;
  int index = 0;

  @override
  void initState() {
    super.initState();
    loadTfliteModel();
  }

  loadTfliteModel() async {
    String? res = await Tflite.loadModel(
        model: "assets/model_unquant.tflite", labels: "assets/labels.txt");
    print(res);
  }

  setRecognitions(outputs) {
    print(outputs);

    index = outputs[0]['index'];

    confidence = outputs[0]['confidence'];

    setState(() {
      predOne = outputs[0]['label'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "TensorFlow Lite App",
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Stack(
        children: [
          Camera(widget.cameras, setRecognitions),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Card(
                  child: Text(predOne),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
