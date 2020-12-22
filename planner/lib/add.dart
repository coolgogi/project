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
    FirebaseFirestore.instance.collection('product') ;
    product
        .doc(_productNameController.text)
        .set({
      'name': _productNameController.text,
      'price': int.parse(_productPriceController.text),
      'description': _productDescriptionController.text,
      'photo': _url,
      'docName': _productNameController.text,
      'uid':   auth.currentUser.uid,
      'created': today,
      'updated' : '',
      'likes' : 0,

    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
    FirebaseFirestore.instance.collection('product')
        .doc(_productNameController.text)
        .collection('likedMembers').doc('sample')
        .set({
      'sample':'sample'
    });

    setState(() {
      print("Profile Picture uploaded");
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Uploaded')));
    });
  }

  getGalleryImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add'),
          leading: FlatButton(
            padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
            child: Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          actions: <Widget>[
            FlatButton(
                onPressed: () => uploadImage(context), child: Text('Save'))
          ],
        ),
        body: Container(
          child: ListView(
            children: [
              _image == null
                  ? Image.network(
                  'http://handong.edu/site/handong/res/img/logo.png',
                  width: MediaQuery.of(context).size.width)
                  : Image.file(_image),
//카메라 버튼 , image picker
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(Icons.camera_alt),
                    onPressed: () => getImage(),
                  ),
                ],
              ),
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
}
