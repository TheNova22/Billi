import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';

typedef void Callback(List<dynamic> list);

class Camera extends StatefulWidget {
  final List<CameraDescription> cameras;
  final Callback setRecognitions;

  Camera(this.cameras, this.setRecognitions);
  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  late CameraController cameraController;
  bool isDetecting = false;

  @override
  void initState() {
    super.initState();
    cameraController =
        CameraController(widget.cameras.first, ResolutionPreset.high);
    cameraController.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {});

      // cameraController.startImageStream((image) {
      //   if (!isDetecting) {
      //     isDetecting = true;
      //     Tflite.runModelOnFrame(
      //       bytesList: image.planes.map((plane) {
      //         return plane.bytes;
      //       }).toList(),
      //       imageHeight: image.height,
      //       imageWidth: image.width,
      //       numResults: 1,
      //     ).then((value) {
      //       if (value!.isNotEmpty) {
      //         widget.setRecognitions(value);
      //         isDetecting = false;
      //       }
      //     });
      //   }
      // });
    });
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  Future click() async {
    XFile file = await cameraController.takePicture();
    // final bytes = await file.readAsBytes();

    Tflite.runModelOnImage(
      path: file.path,
      numResults: 1,
    ).then((value) {
      if (value!.isNotEmpty) {
        widget.setRecognitions(value);
        isDetecting = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!cameraController.value.isInitialized) {
      return Container();
    }

    return Center(
      child: Stack(children: [
        CameraPreview(cameraController),
        GestureDetector(
          child: Container(
            alignment: Alignment.bottomCenter,
            child: Text("Click"),
          ),
          onTap: () {
            click().then((value) {
              print("done");
            });
          },
        )
      ]),
    );
  }
}
