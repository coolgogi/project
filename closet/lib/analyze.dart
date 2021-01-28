import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unicorndial/unicorndial.dart';

class analyze extends StatefulWidget {
  @override
  _analyze createState() => new _analyze();
}

class _analyze extends State<analyze> {
  File _image;
  List _results;

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    var childButtons = List<UnicornButton>();

    childButtons.add(UnicornButton(
        hasLabel: true,
        labelText: "Gallery",
        currentButton: FloatingActionButton(
            heroTag: "Gallery",
            backgroundColor: Colors.redAccent,
            mini: true,
            child: Icon(Icons.image),
            onPressed: pickAnImageFromGallery)));

    childButtons.add(UnicornButton(
        hasLabel: true,
        labelText: "Camera",
        currentButton: FloatingActionButton(
          heroTag: "Camera",
          backgroundColor: Colors.greenAccent,
          mini: true,
          child: Icon(Icons.camera),
          onPressed: pickAnImageFromCamera,
        )));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Image classification',
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
      body: Column(
        children: [
          if (_image != null)
            Container(margin: EdgeInsets.all(10), child: Image.file(_image))
          else
            Container(
              margin: EdgeInsets.all(40),
              child: Opacity(
                opacity: 0.6,
                child: Center(
                  child: Text('No Image Selected!'),
                ),
              ),
            ),
          SingleChildScrollView(
            child: Column(
              children: _results != null
                  ? _results.map((result) {
                      return Card(
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: Text(
                            "${result["label"]} -  ${result["confidence"].toStringAsFixed(2)}",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    }).toList()
                  : [],
            ),
          ),
        ],
      ),
      floatingActionButton: UnicornDialer(
          backgroundColor: Color.fromRGBO(255, 255, 255, 0.6),
          parentButtonBackground: Colors.redAccent,
          orientation: UnicornOrientation.VERTICAL,
          parentButton: Icon(Icons.add),
          childButtons: childButtons),
      // FloatingActionButton(
      //   onPressed: pickAnImage,
      //   tooltip: 'Select Image',
      //   child: Icon(Icons.image),
      // ),
    );
  }

  Future loadModel() async {
    Tflite.close();
    String res;
    res = await Tflite.loadModel(
      model: "assets/ml/mobilenet_v1_1.0_224.tflite",
      labels: "assets/ml/mobilenet_v1_1.0_224.txt",
    );
    print(res);
  }

  Future pickAnImageFromGallery() async {
    // pick image and...
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    // Perform image classification on the selected image.
    imageClassification(image);
  }

  Future pickAnImageFromCamera() async {
    // pick image and...
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    // Perform image classification on the selected image.
    imageClassification(image);
  }

  Future imageClassification(File image) async {
    // Run tensorflowlite image classification model on the image
    final List results = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 6,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _results = results;
      _image = image;
    });
  }
}
