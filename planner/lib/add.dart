import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  File _image;
  final picker = ImagePicker();
  final _productNameController = TextEditingController();
  final _productPriceController = TextEditingController();
  final _productDescriptionController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future uploadImage(BuildContext context) async {
    String today = DateTime.now().toString();
    //firebase storage
    String fileName = basename(_productNameController.text);
    Reference firebaseStorageRef =
    FirebaseStorage.instance.ref().child(fileName);

    UploadTask uploadTask = firebaseStorageRef.putFile(_image);

    TaskSnapshot taskSnapshot = await uploadTask;
    var _dowurl = await (await uploadTask).ref.getDownloadURL();
    final _url = _dowurl.toString();

    //firestore
    CollectionReference product =
    FirebaseFirestore.instance.collection('product');
    product
        .doc(_productNameController.text)
        .set({
      'name': _productNameController.text,
      'price': int.parse(_productPriceController.text),
      'description': _productDescriptionController.text,
      'photo': _url,
      'docName': _productNameController.text,
      'uid': auth.currentUser.uid,
      'created': today,
      'updated': '',
      'likes': 0,

    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
    FirebaseFirestore.instance.collection('product')
        .doc(_productNameController.text)
        .collection('likedMembers').doc('sample')
        .set({
      'sample': 'sample'
    });

    setState(() {
      print("Profile Picture uploaded");
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Uploaded')));
    });
  }

  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50
    );
    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    File image = await  ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50
    );
    setState(() {
      _image = image;
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('등록하기'),
          leading: FlatButton(
            padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
            child: Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  uploadImage(context);
                  Navigator.pop(context);
                }
                , child: Text('Save'))
          ],
        ),
        body: Container(
          child: ListView(
            children: [   //사진 있는지
              _image == null
              // 사진 누르면 이미지 업로드할 수 있게
                  ? InkWell(child: Image.network(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTfBpIhpz-sLYsnrwOdWI9qrKZ8LTiosa6PVQ&usqp=CAU'),onTap: ()=>_showPicker(context))
                  : Image.file(_image),
//카메라 버튼 , image picker
              TextField(
                controller: _productNameController,
                decoration: InputDecoration(
                  labelText: 'Product Name',
                  filled: true,
                ),
              ),
              TextField(
                controller: _productPriceController,
                decoration: InputDecoration(
                  labelText: 'Price',
                  filled: true,
                ),
              ),
              TextField(
                controller: _productDescriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  filled: true,
                ),
              )
            ],
          ),
        ));
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}