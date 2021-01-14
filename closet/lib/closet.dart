import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'text_style.dart';
import 'app.dart';
import 'color.dart';

class closet extends StatefulWidget {
  @override
  _closet createState() => _closet();
}

class _closet extends State<closet> {
  /*
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
    return image;
    imageList.add(image);

  }
  */

  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SafeArea(child: Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, value) {
            return [
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                child: SliverSafeArea(
                    top: false,
                    sliver: SliverAppBar(
                      backgroundColor: Color(0xFF808080),
                      floating: true,
                      pinned: true,
                      primary: true,
                      title: Text(
                        "I-Clothes",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      actions: <Widget>[
                        IconButton(
                            icon: Icon(Icons.account_circle), onPressed: () {}),
                      ],
                      bottom: TabBar(
                        indicatorColor: Colors.purple,
                        tabs: [
                          Tab(text: '코디'),
                          Tab(text: '옷장'),
                        ],
                      ),
                      automaticallyImplyLeading: false,
                    ),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              GridView.count(
                  crossAxisCount: 2,
                  padding: EdgeInsets.all(16.0),
                  childAspectRatio: 8.0 / 9.0,
                  children: <Widget>[
                    Card(
                      child: AspectRatio(
                        aspectRatio: 18.0 / 11.0,
                        child: Image.asset('assets/codi1.jpg'),
                      ),
                    ),
                    Card(
                      child: AspectRatio(
                        aspectRatio: 18.0 / 11.0,
                        child: Image.asset('assets/codi2.jpg'),
                      ),
                    ),
                    Card(
                      child: AspectRatio(
                        aspectRatio: 18.0 / 11.0,
                        child: Image.asset('assets/codi3.jpg'),
                      ),
                    ),
                    Card(
                      child: AspectRatio(
                        aspectRatio: 18.0 / 11.0,
                        child: Image.asset('assets/codi9.jpg'),
                      ),
                    ),
                    Card(
                      child: AspectRatio(
                        aspectRatio: 18.0 / 11.0,
                        child: Image.asset('assets/codi5.jpg'),
                      ),
                    ),
                    Card(
                      child: AspectRatio(
                        aspectRatio: 18.0 / 11.0,
                        child: Image.asset('assets/codi6.jpg'),
                      ),
                    ),
                    Card(
                      child: AspectRatio(
                        aspectRatio: 18.0 / 11.0,
                        child: Image.asset('assets/codi7.jpg'),
                      ),
                    ),
                    Card(
                      child: AspectRatio(
                        aspectRatio: 18.0 / 11.0,
                        child: Image.asset('assets/codi8.jpg'),
                      ),
                    ),
                    Card(
                      child: AspectRatio(
                        aspectRatio: 18.0 / 11.0,
                        child: Image.asset('assets/codi9.jpg'),
                      ),
                    ),
                    Card(
                      child: AspectRatio(
                        aspectRatio: 18.0 / 11.0,
                        child: Image.asset('assets/codi1.jpg'),
                      ),
                    ),
                    Card(
                      child: AspectRatio(
                        aspectRatio: 18.0 / 11.0,
                        child: Image.asset('assets/codi2.jpg'),
                      ),
                    ),
                  ]),
              Center(child: Text('옷장')),
            ],
          ),
        ),
      ),

      // Column(
      //   children: [
      //     GridView.count(
      //       crossAxisCount: 2,
      //       padding: EdgeInsets.all(16.0),
      //       childAspectRatio: 8.0 / 9.0,
      //       children: <Widget>[
      //         Card(
      //           child: Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: <Widget>[
      //               AspectRatio(
      //                 aspectRatio: 18.0 / 11.0,
      //                 child: Image.asset('assets/sample.png'),
      //               ),
      //               Padding(
      //                 padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
      //                 child: Column(
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   children: <Widget>[
      //                     Row(
      //                       children: [
      //                         Text('Title'),
      //                         IconButton(
      //                             icon: Icon(Icons.favorite),
      //                             onPressed: () {}),
      //                       ],
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //             ],
      //           ),
      //         )
      //       ],
      //     ),
      //
      //   ],
      // ),
    ),
    );
  }
}
