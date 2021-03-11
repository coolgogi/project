import 'package:closet/data/weather.dart';
import 'package:closet/weatherPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:closet/helper/tabCategory.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:animated_widgets/animated_widgets.dart';
import 'package:provider/provider.dart';
import 'helper/fancy_fab.dart';
import 'helper/bloc.dart';
import 'data/closetTabPage.dart';
import 'data/location.dart';

// class closet extends StatefulWidget {
//   @override
//   _closetState createState() => _closetState();
// }
//
// class _closetState extends State<closet> {
//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery.of(context).size;
//
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
//             SizedBox(
//               height: size.height * 0.10,
//               child: Text(
//                 '날씨',
//                 textAlign: TextAlign.center,
//               ),
//             ),
//             DefaultTabController(
//               length: 6,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: <Widget>[
//                   Container(
//                     decoration: BoxDecoration(
//                         border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5))
//                     ),
//                     child: TabBar(
//                       isScrollable: true,
//                       indicatorColor: Theme.of(context).colorScheme.primary,
//                       labelColor: Theme.of(context).colorScheme.primary,
//                       unselectedLabelColor: Theme.of(context).colorScheme.onPrimary,
//                       labelStyle: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
//                       unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w400),
//                       tabs: [
//                         Tab(text: '코디'),
//                         Tab(text: '아우터'),
//                         Tab(text: '상의'),
//                         Tab(text: '하의'),
//                         Tab(text: '신발'),
//                         Tab(text: '악세사리'),
//                       ],
//                     ),
//                   ),
//                   // Expanded(
//                   //   child: TabBarView(
//                   //         children: <Widget>[
//                   //           Icon(Icons.airline_seat_flat),
//                   //           Icon(Icons.airline_seat_flat),
//                   //           Icon(Icons.airline_seat_flat),
//                   //           Icon(Icons.airline_seat_flat),
//                   //           Icon(Icons.airline_seat_flat),
//                   //           Icon(Icons.airline_seat_flat),
//                             cody(),
//                             outers(),
//                             tops(),
//                             pants(),
//                             shoes(),
//                             accessories()
//                   //         ]),
//                   // ),
//                 ],
//               ),
//             )
//           ],
//         )
//       ),
//       floatingActionButton: FancyFab(),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather/weather.dart';
import 'data/weather.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
// ignore: non_constant_identifier_names
final String UserEmail = _auth.currentUser.email;
String nickname;


class codi extends StatefulWidget {
  // closet({@required this.weatherData});

  // final WeatherData weatherData;

  @override
  _codiState createState() => _codiState();
}

class _codiState extends State<codi> {
  int temperature;
  Icon weatherDisplayIcon;
  AssetImage backgroundImage;

  void initState() {
    super.initState(); // super : 자식 클래스에서 부모 클래스의 멤버변수 참조할 때 사용
    FirebaseFirestore.instance.
    collection('user').
    doc(UserEmail).get().
    then((DocumentSnapshot snapshot) {
      nickname = snapshot.get('nickname');
      print('nickname: $nickname');
    });
  }

  // void updateWeatherInfo(WeatherData weatherData) {
  //   setState(() {
  //     temperature = weatherData.currentTemperature.round();
  //     WeatherDisplayData weatherDisplayData =
  //         weatherData.getWeatherDisplayData();
  //     backgroundImage = weatherDisplayData.weatherImage;
  //     weatherDisplayIcon = weatherDisplayData.weatherIcon;
  //   });
  // }

  // @override
  // void initStata() {
  //   super.initState();
  //   updateWeatherInfo(widget.weatherData);
  //   WeatherData().getCurrentTemperature();
  // }


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery
        .of(context)
        .size;

    Query query = FirebaseFirestore.instance
        .collection('user')
        .doc(UserEmail)
        .collection('codi');

    // weatherBar();
    // weather();

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
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(size.height * 0.058),
              child: AppBar(
                elevation: 0,
                title: Text(
                  'CloDay',
                  style: Theme
                      .of(context)
                      .textTheme
                      .headline5,
                ),
                actions: [
                  Container(
                    width: size.width * 0.15,
                    child: Icon(
                        Icons.today_outlined,
                        color: Theme
                            .of(context)
                            .colorScheme
                            .onSurface
                    ),
                  ),
                ],
              ),
            ),
            body: ListView(
              children: <Widget>[
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: SizedBox(
                      height: size.height * 0.129,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => weatherPage()));
                        },
                        child: weatherBar(),
                      ),
                    ),
                  ),
                ),
                Container(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                              '$nickname님의 코디',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme
                                      .of(context)
                                      .colorScheme
                                      .onBackground
                              )
                          ),
                          Expanded(
                            child: Container(),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: InkWell(
                              child: Text(
                                  '편집',
                                  style: TextStyle(color: Theme
                                      .of(context)
                                      .colorScheme
                                      .primary)),
                              onTap: () {
                                Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => tabCategoryPage()));
                              },
                            ),
                          ),
                        ],
                      ),
                    )),
                makeImageList(querySnapshot),
              ],
            ),
            // floatingActionButton: FancyFab(),
          );
        });
  }
}

class makeImageList extends StatelessWidget {
  final QuerySnapshot snapshot;

  makeImageList(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.count(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 2,
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
