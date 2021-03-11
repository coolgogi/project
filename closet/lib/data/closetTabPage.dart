import 'dart:core';
import 'dart:io';

import 'package:closet/data/weather.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import '../weatherPage.dart';
import 'package:unicorndial/unicorndial.dart';

// class cody extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery.of(context).size;
//
//     return ListView(
//       children: <Widget>[
//         Container(
//           child: Padding(
//             padding: const EdgeInsets.only(top: 10, bottom: 10),
//             child: SizedBox(
//               height: size.height * 0.129,
//               child: GestureDetector(
//                 onTap: () {
//                   Navigator.of(context).push(
//                       MaterialPageRoute(builder: (context) => weatherPage()));
//                 },
//                 child: weatherBar(),
//               ),
//             ),
//           ),
//         ),
//         Container(
//             child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Row(
//             children: <Widget>[
//               Text(
//                 '~~~님의 코디',
//                 style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     color: Theme.of(context).colorScheme.onBackground
//                 )
//               ),
//               Expanded(
//                 child: Container(),
//               ),
//               InkWell(
//               child: Text(
//                   '편집',
//                   style: TextStyle(color: Theme.of(context).colorScheme.primary)),
//               // onTap: () => ,
//               ),
//             ],
//           ),
//         )),
//         GridView.count(
//             physics: NeverScrollableScrollPhysics(),
//             shrinkWrap: true,
//             crossAxisCount: 2,
//             padding: EdgeInsets.all(16.0),
//             childAspectRatio: 8.0 / 9.0,
//             children: <Widget>[
//               Card(
//                 child: AspectRatio(
//                   aspectRatio: 18.0 / 11.0,
//                   child: Image.asset('assets/codi1.jpg'),
//                 ),
//               ),
//               Card(
//                 child: AspectRatio(
//                   aspectRatio: 18.0 / 11.0,
//                   child: Image.asset('assets/codi2.jpg'),
//                 ),
//               ),
//               Card(
//                 child: AspectRatio(
//                   aspectRatio: 18.0 / 11.0,
//                   child: Image.asset('assets/codi3.jpg'),
//                 ),
//               ),
//               Card(
//                 child: AspectRatio(
//                   aspectRatio: 18.0 / 11.0,
//                   child: Image.asset('assets/codi9.jpg'),
//                 ),
//               ),
//               Card(
//                 child: AspectRatio(
//                   aspectRatio: 18.0 / 11.0,
//                   child: Image.asset('assets/codi5.jpg'),
//                 ),
//               ),
//               Card(
//                 child: AspectRatio(
//                   aspectRatio: 18.0 / 11.0,
//                   child: Image.asset('assets/codi6.jpg'),
//                 ),
//               ),
//               Card(
//                 child: AspectRatio(
//                   aspectRatio: 18.0 / 11.0,
//                   child: Image.asset('assets/codi7.jpg'),
//                 ),
//               ),
//               Card(
//                 child: AspectRatio(
//                   aspectRatio: 18.0 / 11.0,
//                   child: Image.asset('assets/codi8.jpg'),
//                 ),
//               ),
//               Card(
//                 child: AspectRatio(
//                   aspectRatio: 18.0 / 11.0,
//                   child: Image.asset('assets/codi9.jpg'),
//                 ),
//               ),
//               Card(
//                 child: AspectRatio(
//                   aspectRatio: 18.0 / 11.0,
//                   child: Image.asset('assets/codi1.jpg'),
//                 ),
//               ),
//               Card(
//                 child: AspectRatio(
//                   aspectRatio: 18.0 / 11.0,
//                   child: Image.asset('assets/codi2.jpg'),
//                 ),
//               ),
//             ]),
//       ],
//     );
//   }
// }

// String category = '';
// File _image;
// List _results;

// class getImageList extends StatefulWidget {
//   @override
//   _getImageListState createState() => _getImageListState();
// }
//
// class _getImageListState extends State<getImageList> {
//
//   Future pickAnImageFromGallery() async {
//     // ignore: deprecated_member_use
//     File image = await ImagePicker.pickImage(source: ImageSource.gallery);
//     // Perform image classification on the selected image.
//     imageClassification(image);
//   }
//
//   Future pickAnImageFromCamera() async {
//     // pick image and...
//     // ignore: deprecated_member_use
//     File image = await ImagePicker.pickImage(source: ImageSource.camera);
//     // Perform image classification on the selected image.
//     imageClassification(image);
//   }
//
//   Future imageClassification(File image) async {
//     // Run tensorflow lite image classification model on the image
//     final List results = await Tflite.runModelOnImage(
//       path: image.path,
//       numResults: 6,
//       threshold: 0.05,
//       imageMean: 127.5,
//       imageStd: 127.5,
//     );
//     setState(() {
//       _results = results;
//       _image = image;
//     });
//     uploadToFirebase(_image);
//   }
//
//   Future<void> uploadToFirebase(File image) async {
//     String docID = Timestamp.now().seconds.toString();
//     firebase_storage.UploadTask uploadTask;
//     String _label = _results.first['label'];
//
//     String path = "user/" + "$UserEmail/" + "closet/" + "$category/";
//     firebase_storage.Reference ref =
//     firebase_storage.FirebaseStorage.instance.ref().child(path);
//
//     if (kIsWeb) {
//       uploadTask = ref.putData(await image.readAsBytes());
//     } else {
//       uploadTask = ref.putFile(File(image.path));
//     }
//
//     await uploadTask.whenComplete(() => null);
//     String downloadURL = await ref.getDownloadURL();
//     // print("=============downloadURL===============");
//     // print(downloadURL);
//     // print("=============downloadURL===============");
//
//     Map<String, dynamic> data = {
//       'type': _results.first["label"],
//       'season': "?",
//       "color": "?",
//       "imageURL": downloadURL,
//     };
//
//     FirebaseFirestore.instance
//         .collection('user')
//         .doc(UserEmail)
//         .collection("closet")
//         .doc("outers/$docID")
//         .set(data);
//
//     FirebaseFirestore.instance
//         .collection('user')
//         .doc(UserEmail)
//         .collection('closet')
//         .doc('clothes')
//         .get()
//         .then((DocumentSnapshot docs) {
//       if (docs.exists) {
//         try {
//           double num = docs[_label];
//           updateDoc(_label, num);
//         } catch (e) {
//           createDoc(_label);
//         }
//       } else {
//         Map<String, dynamic> data = {
//           "$_label": 1.0,
//         };
//         FirebaseFirestore.instance
//             .collection('user')
//             .doc(UserEmail)
//             .collection('closet')
//             .doc("clothes")
//             .set(data);
//       }
//     });
//   }
//
//   void updateDoc(String label, double num) async {
//     await FirebaseFirestore.instance
//         .collection("user")
//         .doc(UserEmail)
//         .collection("closet")
//         .doc("clothes")
//         .update({
//       "$label": num + 1.0,
//     });
//   }
//
//   void createDoc(String label) async {
//     await FirebaseFirestore.instance
//         .collection("user")
//         .doc(UserEmail)
//         .collection("closet")
//         .doc("clothes")
//         .update({
//       "$label": 1.0,
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GridView.count(
//       shrinkWrap: true,
//       crossAxisCount: 3,
//       padding: EdgeInsets.all(16.0),
//       childAspectRatio: 8.0 / 9.0,
//       children: <Widget>[
//
//       ],
//     );
//   }
// }
////////////////////////////////////////////////////////////////////////////////
// class getImageList extends StatefulWidget {
//   @override
//   _getImageListState createState() => _getImageListState();
// }
//
//
// class _getImageListState extends State<getImageList> {
//   var storage = firebase_storage.FirebaseStorage.instance;
//   List<AssetImage> listOfImage;
//   bool clicked = false;
//   List<String> listOfStr = List();
//   String image;
//   bool isLoading = false;
//
//   @override
//   void initState() {
//     super.initState();
//     getImages();
//   }
//
//   void getImages() {
//     listOfImage = List();
//     for (int i = 0; i < 6; i++) {
//       listOfImage.add(
//           AssetImage('assets/images/travelimage' + i.toString() + '.jpeg'));
//     }
//   }
//
//     @override
//     Widget build(BuildContext context) {
//       return Container();
//     }
// }
///////////////////////////////////////////////////////////////////////////////

// class pickedImagePage extends StatefulWidget {
//   var image;
//
//   pickedImagePage(this.image);
//
//   @override
//   _pickedImagePageState createState() => _pickedImagePageState();
// }
//
// class _pickedImagePageState extends State<pickedImagePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Image.file(image),
//     );
//   }
// }

File _image;
List _results;
String category = '';

class makeImageList extends StatelessWidget {
  final QuerySnapshot snapshot;

  makeImageList(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          padding: EdgeInsets.all(16.0),
          childAspectRatio: 8.0 / 9.0,
          children: List.generate(snapshot.size, (index) {
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

class outers extends StatefulWidget {
  @override
  _outersState createState() => _outersState();
}

class _outersState extends State<outers> {
  var storage = firebase_storage.FirebaseStorage.instance;

  @override
  Widget build(BuildContext context) {
    Query query = FirebaseFirestore.instance
        .collection('user')
        .doc(UserEmail)
        .collection('closet')
        .doc('clothes')
        .collection("outers");


    return StreamBuilder<QuerySnapshot>(
        stream: query.snapshots(),
        builder: (context, stream) {
          if (stream.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (stream.hasError) {
            return Center(child: Text(stream.error.toString()));
          }

          QuerySnapshot querySnapshot = stream.data;
          // DocumentSnapshot ds = querySnapshot.docs[querySnapshot.size - 1];
          return Column(children: [
            makeImageList(querySnapshot),
          ]);
        });
  }
}





class tops extends StatefulWidget {
  @override
  _topsState createState() => _topsState();
}

class _topsState extends State<tops> {
  var storage = firebase_storage.FirebaseStorage.instance;

  @override
  Widget build(BuildContext context) {
    Query query = FirebaseFirestore.instance
        .collection('user')
        .doc(UserEmail)
        .collection('closet')
        .doc('clothes')
        .collection("tops");


    return StreamBuilder<QuerySnapshot>(
        stream: query.snapshots(),
        builder: (context, stream) {
          if (stream.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (stream.hasError) {
            return Center(child: Text(stream.error.toString()));
          }

          QuerySnapshot querySnapshot = stream.data;
          // DocumentSnapshot ds = querySnapshot.docs[querySnapshot.size - 1];
          return Column(children: [
            makeImageList(querySnapshot),
          ]);
        });
  }
}

class pants extends StatefulWidget {
  @override
  _pantsState createState() => _pantsState();
}

class _pantsState extends State<pants> {
  var storage = firebase_storage.FirebaseStorage.instance;

  @override
  Widget build(BuildContext context) {
    Query query = FirebaseFirestore.instance
        .collection('user')
        .doc(UserEmail)
        .collection('closet')
        .doc('clothes')
        .collection("shoes");


    return StreamBuilder<QuerySnapshot>(
        stream: query.snapshots(),
        builder: (context, stream) {
          if (stream.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (stream.hasError) {
            return Center(child: Text(stream.error.toString()));
          }

          QuerySnapshot querySnapshot = stream.data;
          // DocumentSnapshot ds = querySnapshot.docs[querySnapshot.size - 1];
          return Column(children: [
            makeImageList(querySnapshot),
          ]);
        });
  }
}

class shoes extends StatefulWidget {
  @override
  _shoesState createState() => _shoesState();
}

class _shoesState extends State<shoes> {
  var storage = firebase_storage.FirebaseStorage.instance;

  @override
  Widget build(BuildContext context) {
    Query query = FirebaseFirestore.instance
        .collection('user')
        .doc(UserEmail)
        .collection('closet')
        .doc('clothes')
        .collection("shoes");


    return StreamBuilder<QuerySnapshot>(
        stream: query.snapshots(),
        builder: (context, stream) {
          if (stream.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (stream.hasError) {
            return Center(child: Text(stream.error.toString()));
          }

          QuerySnapshot querySnapshot = stream.data;
          // DocumentSnapshot ds = querySnapshot.docs[querySnapshot.size - 1];
          return Column(children: [
            makeImageList(querySnapshot),
          ]);
        });
  }
}

class accessories extends StatefulWidget {
  @override
  _accessoriesState createState() => _accessoriesState();
}

class _accessoriesState extends State<accessories> {
  var storage = firebase_storage.FirebaseStorage.instance;

  @override
  Widget build(BuildContext context) {
    Query query = FirebaseFirestore.instance
        .collection('user')
        .doc(UserEmail)
        .collection('closet')
        .doc('clothes')
        .collection("accessories");


    return StreamBuilder<QuerySnapshot>(
        stream: query.snapshots(),
        builder: (context, stream) {
          if (stream.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (stream.hasError) {
            return Center(child: Text(stream.error.toString()));
          }

          QuerySnapshot querySnapshot = stream.data;
          // DocumentSnapshot ds = querySnapshot.docs[querySnapshot.size - 1];
          return Column(children: [
            makeImageList(querySnapshot),
          ]);
        });
  }
}
