import 'dart:async';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unicorndial/unicorndial.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:path_provider/path_provider.dart';
import 'upload.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pie_chart/pie_chart.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final String UserEmail = _auth.currentUser.email;

// ignore: camel_case_types
class analyze extends StatefulWidget {
  @override
  _analyze createState() => new _analyze();
}

File _image;
List _results;

class _analyze extends State<analyze> {
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
    Query query = FirebaseFirestore.instance
        .collection('user')
        .doc(UserEmail)
        .collection('closet');

    // ignore: deprecated_member_use
    List<UnicornButton> childButtons = List<UnicornButton>();
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
          title: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Image classification'),
          StreamBuilder(
              stream: FirebaseFirestore.instance.snapshotsInSync(),
              builder: (context, _) {
                return Text(
                  'Latest Snapshot : ${DateTime.now().microsecond}',
                  style: Theme.of(context).textTheme.caption,
                );
              }),
        ],
      )),
      body: StreamBuilder<QuerySnapshot>(
          stream: query.snapshots(),
          builder: (context, stream) {
            if (stream.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (stream.hasError) {
              return Center(child: Text(stream.error.toString()));
            }

            QuerySnapshot querySnapshot = stream.data;

            return ListView.builder(
              itemCount: querySnapshot.size,
              itemBuilder: (context, index) => Temp(querySnapshot.docs[index]),
            );
          }),
      floatingActionButton: UnicornDialer(
          backgroundColor: Color.fromRGBO(255, 255, 255, 0.6),
          parentButtonBackground: Colors.redAccent,
          orientation: UnicornOrientation.VERTICAL,
          parentButton: Icon(Icons.add),
          childButtons: childButtons),
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
    // ignore: deprecated_member_use
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    // Perform image classification on the selected image.
    imageClassification(image);
  }

  Future pickAnImageFromCamera() async {
    // pick image and...
    // ignore: deprecated_member_use
    File image = await ImagePicker.pickImage(source: ImageSource.camera);
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

class Temp extends StatelessWidget {
  final DocumentSnapshot snapshot;

  Temp(this.snapshot);

  Map<String, dynamic> get temp {
    return snapshot.data();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(child: Text("$temp")),
        if (_image != null)
          Expanded(
              child: Container(
                  margin: EdgeInsets.all(10), child: Image.file(_image)))
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
        Expanded(
          child: SingleChildScrollView(
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
        ),
      ],
    );
  }
}
