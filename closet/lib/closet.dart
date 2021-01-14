// import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';


class closet extends StatefulWidget {
  @override
  _closet createState() => _closet();
}

class _closet extends State<closet> {
  List<Image> imageList;
  List<Card> _buildGridCards(BuildContext context) {
    if (imageList == null || imageList.isEmpty) {
      return const <Card>[];
    }
    return imageList.map((image) {
      return Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          // TODO: Center items on the card (103)
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 18 / 11,
              child: image),
          ],
        ),
      );
    }).toList();
  }
  getGalleryImage() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      convertFileToImage(image);
    });
  }
  Future<Image> convertFileToImage(File picture) async {
    List<int> imageBase64 = picture.readAsBytesSync();
    String imageAsString = base64Encode(imageBase64);
    Uint8List uint8list = base64.decode(imageAsString);
    Image image = Image.memory(uint8list);
    imageList.add(image);
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      title: '내 옷장',
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('엥 유린데영??'),
            automaticallyImplyLeading: false,
            backgroundColor: Color(0xff5808e5),
            bottom: TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Tab(text: '코디', icon: Icon(Icons.favorite)),
                Tab(text: '옷장', icon: Icon(Icons.music_note)),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              GridView.count(crossAxisCount: 2,
                padding: EdgeInsets.all(16.0),
                childAspectRatio: 8.0 / 9.0,
                children: _buildGridCards(context)
              ),
              Center(child: Text('옷장')),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () =>getGalleryImage(),
          ),
        ),
      ),
    );
  }
}
