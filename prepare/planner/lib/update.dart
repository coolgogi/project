import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'detail.dart';
class UpdateProduct extends StatefulWidget {
  final String photo;
  final String name;
  final int price;
  final String description;
  final  String docName;
  final String uid;

  UpdateProduct(this.photo, this.name, this.price, this.description, this.docName,this.uid);

  @override
  _UpdateProductState createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
  File _image;
  final picker = ImagePicker();
  final _productNameController = TextEditingController();
  final _productPriceController = TextEditingController();
  final _productDescriptionController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  var _changed = false;
   var _dowurl;
   var _url;
  Future updateImage(BuildContext context) async {

    String updatedDay = DateTime.now().toString();

    //파일 삭제 후 업로드
    if(_changed==true) {
      String fileNameToDelete = basename(widget.name);
      Reference firebaseStorageRefToDelete =
      FirebaseStorage.instance.ref().child(fileNameToDelete);
      firebaseStorageRefToDelete.delete();
      //firebase storage
      String fileName = basename(_productNameController.text);
      Reference firebaseStorageRef =
      FirebaseStorage.instance.ref().child(fileName);

      UploadTask uploadTask = firebaseStorageRef.putFile(_image);
      TaskSnapshot taskSnapshot = await uploadTask;
       _dowurl = await (await uploadTask).ref.getDownloadURL();
       _url = _dowurl.toString();
    }
    else {
      Reference imgurl= FirebaseStorage.instance.ref().child(widget.docName);
       _dowurl = await imgurl.getDownloadURL();
       _url = _dowurl.toString();
    }
    //firestore
    CollectionReference product =
    FirebaseFirestore.instance.collection('product') ;
    product
        .doc(widget.docName)
        .update({
      'name': _productNameController.text,
      'price': int.parse(_productPriceController.text),
      'description': _productDescriptionController.text,
      'photo': _url,
      'updated' : updatedDay
    });

    setState(() {
      print("Profile Picture uploaded");
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
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
        _image = File(pickedFile.path);
    });
  }

  Widget build(BuildContext context) {
    _productNameController.text=widget.name;
    _productPriceController.text=(widget.price).toString();
    _productDescriptionController.text=widget.description;
    return Scaffold(
        appBar: AppBar(
          title: Text('Edit'),
          leading: FlatButton(
            padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
            child: Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          actions: <Widget>[
            FlatButton(
                onPressed: () => updateImage(context), child: Text('Save'))
          ],
        ),
        body: Container(
          child: ListView(
            children: [
              _image == null
                  ? Image.network(
                widget.photo,
                  width: MediaQuery.of(context).size.width)
                  : Image.file(_image),
//카메라 버튼 , image picker
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(Icons.camera_alt),
                    onPressed: () {
                      getGalleryImage();
                      setState(() {
                        _changed=true;
                      });
                    },
                  ),
                ],
              ),
              TextField(
                controller: _productNameController,
                decoration: InputDecoration(
                    labelText: 'Name',
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
