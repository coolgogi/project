import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unicorndial/unicorndial.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pie_chart/pie_chart.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
// ignore: non_constant_identifier_names
final String UserEmail = _auth.currentUser.email;

// ignore: camel_case_types
class analyze extends StatefulWidget {
  @override
  _analyze createState() => new _analyze();
}

File _image;
List _results;

// ignore: camel_case_types
class _analyze extends State<analyze> {
  Map<String, double> dataMap = {
    "jersey": 1,
    "miniSkirt": 2,
  };

  // ignore: non_constant_identifier_names
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
          title: Text(
        'Image classification',
        style: Theme.of(context).textTheme.headline5,
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
            DocumentSnapshot ds = querySnapshot.docs[querySnapshot.size - 1];
            return Column(children: [
              makePieChart(ds),
              makeImageList(querySnapshot),
            ]);
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
    // Run tensorflow lite image classification model on the image
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
    uploadToFirebase(_image);
  }

  Future<void> uploadToFirebase(File image) async {
    String docID = Timestamp.now().seconds.toString();
    firebase_storage.UploadTask uploadTask;
    String _label = _results.first['label'];

    String path = "user/" + "$UserEmail/" + "$docID/";
    firebase_storage.Reference ref =
        firebase_storage.FirebaseStorage.instance.ref().child(path);

    if (kIsWeb) {
      uploadTask = ref.putData(await image.readAsBytes());
    } else {
      uploadTask = ref.putFile(File(image.path));
    }

    await uploadTask.whenComplete(() => null);
    String downloadURL = await ref.getDownloadURL();
    // print("=============downloadURL===============");
    // print(downloadURL);
    // print("=============downloadURL===============");

    Map<String, dynamic> data = {
      'type': _results.first["label"],
      'season': "?",
      "color": "?",
      "imageURL": downloadURL,
    };

    FirebaseFirestore.instance
        .collection('user')
        .doc(UserEmail)
        .collection("closet")
        .doc(docID)
        .set(data);

    FirebaseFirestore.instance
        .collection('user')
        .doc(UserEmail)
        .collection('closet')
        .doc('clothes')
        .get()
        .then((DocumentSnapshot docs) {
      if (docs.exists) {
        try {
          double num = docs[_label];
          updateDoc(_label, num);
        } catch (e) {
          createDoc(_label);
        }
      } else {
        Map<String, dynamic> data = {
          "$_label": 1.0,
        };
        FirebaseFirestore.instance
            .collection('user')
            .doc(UserEmail)
            .collection('closet')
            .doc("clothes")
            .set(data);
      }
    });
  }

  void updateDoc(String label, double num) async {
    await FirebaseFirestore.instance
        .collection("user")
        .doc(UserEmail)
        .collection("closet")
        .doc("clothes")
        .update({
      "$label": num + 1.0,
    });
  }

  void createDoc(String label) async {
    await FirebaseFirestore.instance
        .collection("user")
        .doc(UserEmail)
        .collection("closet")
        .doc("clothes")
        .update({
      "$label": 1.0,
    });
  }
}

class makePieChart extends StatelessWidget {
  final DocumentSnapshot snapshot;
  Map<String, double> PieChartData = {};

  makePieChart(this.snapshot) {
    snapshot.data().forEach((key, value) {
      PieChartData["$key"] = value.toDouble();
    });
  }

  @override
  Widget build(BuildContext context) {
    return PieChart(
      dataMap: PieChartData,
    );
  }
}

class makeImageList extends StatelessWidget {
  final QuerySnapshot snapshot;

  makeImageList(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.count(
          crossAxisCount: 4,
          children: List.generate(snapshot.size, (index) {
            if (snapshot.docs[index].id == "clothes") {
              return Container();
            } else
              return GridViewCard(snapshot.docs[index]);
          })),
    );
  }
}

class GridViewCard extends StatelessWidget {
  final DocumentSnapshot snapshot;

  GridViewCard(this.snapshot);

  // ignore: non_constant_identifier_names
  Map<String, dynamic> get FBdata {
    return snapshot.data();
  }

  @override
  Widget build(BuildContext context) {
    return snapshot.exists
        ? Card(
            // child: Text("$FBdata"),
            child: Image.network(
              FBdata['imageURL'],
              fit: BoxFit.fitWidth,
            ),
          )
        : Card();
  }
}
