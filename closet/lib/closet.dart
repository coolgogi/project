import 'package:closet/data/weather.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:animated_widgets/animated_widgets.dart';
import 'package:provider/provider.dart';
import 'helper/fancy_fab.dart';
import 'helper/bloc.dart';
import 'data/closetTabPage.dart';
import 'location.dart';

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


class closet extends StatefulWidget {
  // closet({@required this.weatherData});

  // final WeatherData weatherData;

  @override
  _closetState createState() => _closetState();
}

class _closetState extends State<closet> {
  int temperature;
  Icon weatherDisplayIcon;
  AssetImage backgroundImage;

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
    final Size size = MediaQuery.of(context).size;
    // weatherBar();
    // weather();

    return DefaultTabController(
        length: 6,
        child: Scaffold(
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(size.height * 0.14),
                  child: AppBar(
                    title: Text(
                      'CloDay',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    actions: [
                      Container(
                        width: size.width * 0.15,
                        child: Icon(
                            Icons.notifications_none_outlined,
                            color:Theme.of(context).colorScheme.onSurface
                        ),
                      ),
                    ],
                    bottom: TabBar(
                      isScrollable: true,
                      indicatorColor: Theme.of(context).colorScheme.primary,
                      labelColor: Theme.of(context).colorScheme.primary,
                      unselectedLabelColor: Theme.of(context).colorScheme.onPrimary,
                      labelStyle: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
                      unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w400),
                      tabs: [
                        Tab(text: '코디'),
                        Tab(text: '아우터'),
                        Tab(text: '상의'),
                        Tab(text: '하의'),
                        Tab(text: '신발'),
                        Tab(text: '악세사리'),
                      ],
                    ),
                  ),
                ),
                body: Column(
                  children: [
                    Expanded(
                      child: TabBarView(
                        children: [
                          cody(),
                          outers(),
                          tops(),
                          pants(),
                          shoes(),
                          accessories()
                        ],
                      ),
                    ),
                  ],
                ),
                // floatingActionButton: FancyFab(),
              ),
    );
  }
}





////////////////////////////////

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:animated_widgets/animated_widgets.dart';
// import 'package:provider/provider.dart';
// import 'helper/fancy_fab.dart';
// import 'helper/bloc.dart';
//
// class closet extends StatefulWidget {
//   @override
//   _closetState createState() => _closetState();
// }
//
// class _closetState extends State<closet>
//     with SingleTickerProviderStateMixin {
//   TabController _tabController;
//
//   @override
//   void initState() {
//     _tabController = TabController(
//       initialIndex: 0,
//       length: 2,
//       vsync: this,
//     );
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery.of(context).size;
//
//     return Scaffold(
//       body: NestedScrollView(
//         floatHeaderSlivers: true,
//         headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
//           return <Widget>[
//             SliverAppBar(
//               // backgroundColor: Theme
//               //     .of(context)
//               //     .colorScheme
//               //     .background,
//               title: Text(
//                 "I-Clothes",
//                 style: Theme.of(context).textTheme.headline5,
//               ),
//               actions: <Widget>[
//                 ShakeAnimatedWidget(
//                   enabled: false,
//                   duration: Duration(milliseconds: 700),
//                   shakeAngle: Rotation.deg(z: 40),
//                   curve: Curves.linear,
//                   child: IconButton(
//                       icon: Icon(Icons.notifications_none_outlined),
//                       color: Theme
//                           .of(context)
//                           .colorScheme
//                           .onPrimary,
//                       onPressed: () {}),
//                 ),              ],
//               centerTitle: false,
//               pinned: true,
//               floating: true,
//               bottom: TabBar(
//                 isScrollable: true,
//                 indicatorColor: Theme.of(context).colorScheme.primary,
//                 labelColor: Theme.of(context).colorScheme.primary,
//                 unselectedLabelColor: Theme.of(context).colorScheme.onPrimary,
//                 labelStyle: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
//                 unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w400),
//                 controller: _tabController,
//                 tabs: [
//                   Tab(text: '코디'),
//                   Tab(text: '아우터'),
//                   Tab(text: '상의'),
//                   Tab(text: '하의'),
//                   Tab(text: '신발'),
//                   Tab(text: '악세사리'),
//                 ],
//               ),
//               // TabBar(
//               //   indicatorColor: Theme
//               //       .of(context)
//               //       .colorScheme
//               //       .primary,
//               //   labelColor: Theme
//               //       .of(context)
//               //       .colorScheme
//               //       .onPrimary,
//               //   labelStyle: TextStyle(fontWeight: FontWeight.w600),
//               //   unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w400),
//               //
//               //   labelPadding: const EdgeInsets.only(
//               //     bottom: 16,
//               //   ),
//               //   controller: _tabController,
//               //   tabs: [
//               //     Tab(text: '코디'),
//               //     Tab(text: '옷장'),
//               //   ],
//               // ),
//             ),
//           ];
//         },
//         body: TabBarView(
//           children: [
//             TabA(),
//             cody(),
//             Icon(Icons.directions_bike),
//             Icon(Icons.directions_car),
//             Icon(Icons.directions_transit),
//             Icon(Icons.directions_bike),
//           ],
//         ),
//       ),
//       floatingActionButton: FancyFab(),
//     );
//   }
//
//   Widget cody() {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.fromLTRB(4, 20, 330, 0),
//             child: Text('상의'),
//           ),
//           Container(
//             margin: EdgeInsets.symmetric(vertical: 0.0),
//             height: 200.0,
//             child: ListView(
//               scrollDirection: Axis.horizontal,
//               children: <Widget>[
//                 Container(
//                   width: 160.0,
//                   height: 160,
//                   child: Image.asset('assets/top1.JPG'),),
//                 Container(
//                   width: 160.0,
//                   height: 160,
//                   child: Image.asset('assets/top2.JPG'),),
//
//
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.fromLTRB(4, 0, 330, 0),
//             child: Text('하의'),
//           ),
//           Container(
//             margin: EdgeInsets.symmetric(vertical: 0.0),
//             height: 200.0,
//             child: ListView(
//               scrollDirection: Axis.horizontal,
//               children: <Widget>[
//                 Container(
//                   width: 160.0,
//                   height: 160,
//                   child: Image.asset('assets/bottom1.JPG'),
//                 ),
//                 Container(
//                   width: 160.0,
//                   height: 160,
//                   child: Image.asset('assets/bottom2.JPG'),
//                 ),
//                 Container(
//                   width: 160.0,
//                   height: 160,
//                   child: Image.asset('assets/bottom3.JPG'),
//                 ),
//
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.fromLTRB(4, 0, 330  , 0),
//             child: Text('신발'),
//           ),
//           Container(
//             margin: EdgeInsets.symmetric(vertical: 0.0),
//             height: 200.0,
//             child: ListView(
//               scrollDirection: Axis.horizontal,
//               children: <Widget>[
//                 Container(
//                   width: 160.0,
//                   height: 160,
//                   child: Image.asset('assets/sho1.JPG'),
//                 ),
//                 Container(
//                   width: 160.0,
//                   height: 160,
//                   child: Image.asset('assets/sho2.JPG'),
//                 ),
//
//
//               ],
//             ),
//           ),
//
//         ],),
//     );
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
// }
//
// class TabA extends StatelessWidget {
//   final List<Widget> _setList = <Widget>[];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scrollbar(
//         child: GridView.count(
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
//             ])
//     );
//   }
//
//   Widget _buildCardList() {
//     return StreamBuilder<Set<Widget>>(
//       stream: bloc.selectedStream,
//       builder: (context, snapshot) {
//         return GridView.count(
//           crossAxisCount: 2,
//           padding: EdgeInsets.all(16.0),
//           childAspectRatio: 8.0 / 9.0,
//           children: <Widget>[
//             ListView.builder(itemBuilder: (context, index) {
//               return _buildCard(snapshot.data, _setList[index]);
//             }),
//           ],
//         );
//       },
//     );
//   }
//
//   Widget _buildCard(Set<Card> selected, Widget card) {
//
//   }
// }