import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:geolocator_platform_interface/geolocator_platform_interface.dart';
import 'package:weather/weather.dart';
import 'data/weather.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';

// class weatherData {
//   final int main;
//   final int description;
//   final String icon;
//   final String temp;
//   final String feels_like;
//
//   weatherData({this.main, this.description, this.icon, this.temp, this.feels_like, this.body});
//
//   factory Post.fromJson(Map<String, dynamic> json) {
//     return Post(
//       userId: json['userId'],
//       id: json['id'],
//       title: json['title'],
//       body: json['body'],
//     );
//   }
// }
///////////////////////////////////////////////////////////////////////////////
// class Location {
//   double lat; //위도
//   double lon; //경도
//   Position position;
//   String _openweatherkey = "f781792aecfebe7bcce77b83a692ff4b";
//
//   Future<void> getCurrentLocation() async {
//     try {
//       print("111!!!");
//       bool isLocationServiceEnabled  = await Geolocator.isLocationServiceEnabled();
//       if(isLocationServiceEnabled) {
//         print("True!!");
//       } else {print("False!!");}
//       //이 코드는 오류가 날 수 있으니 try catch 로 오류잡기
//       print("222!!!");
//       // Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low, timeLimit: Duration(seconds: 10)); <-- 이게 문제였음. 이유는 모르겠음.
//       position = await Geolocator.getCurrentPosition(timeLimit: Duration(seconds: 10));
//       print("333!!!");
//       //라이브러리를 통해 현재 나의 GPS 호출
//       //low 부분의 정확도가 높아질수록 배터리 용량 많이 잡아먹음
//
//       lat = position.latitude; //해당값 각각 할당
//       lon = position.longitude;
//       print(lat);
//       print(lon);
//       getWeatherData(lat: lat.toString(), lon: lon.toString());
//
//     } catch (e) {
//       print("error!!!");
//       print(e);
//     }
//     // return position;
//   }
//
//   Future<void> getWeatherData({
//   @required String lat,
//   @required String lon,
// }) async {
//     var str =
//         'http://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$_openweatherkey';
//     print(str);
//     var response = await http.get(str);
//
//     if(response.statusCode == 200) {
//       var data = response.body;
//       var dataJson = jsonDecode(data);
//       var weatherData = Weather(dataJson);
//       weatherBar(weatherData);
//
//       print('data = $data');
//     }
//     else {
//       print('response status code = ${response.statusCode}');
//     }
//   }
// }


// class location {
//   double lat; //위도
//   double lon; //경도
//   Position position;
//   String _openweatherkey = "f781792aecfebe7bcce77b83a692ff4b";
//   var weatherData;
//
//   WeatherData getWeather() {
//     getCurrentLocation().then((value) => weatherData);
//   }
//
//   Future<void> getCurrentLocation() async {
//     try {
//       print("111!!!");
//       bool isLocationServiceEnabled =
//           await Geolocator.isLocationServiceEnabled();
//       if (isLocationServiceEnabled) {
//         print("True!!");
//       } else {
//         print("False!!");
//       }
//       //이 코드는 오류가 날 수 있으니 try catch 로 오류잡기
//       print("222!!!");
//       // Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low, timeLimit: Duration(seconds: 10)); <-- 이게 문제였음. 이유는 모르겠음.
//       position =
//           await Geolocator.getCurrentPosition(timeLimit: Duration(seconds: 10));
//       print("333!!!");
//       //라이브러리를 통해 현재 나의 GPS 호출
//       //low 부분의 정확도가 높아질수록 배터리 용량 많이 잡아먹음
//
//       lat = position.latitude; //해당값 각각 할당
//       lon = position.longitude;
//       print(lat);
//       print(lon);
//       await getWeatherData(lat: lat.toString(), lon: lon.toString());
//       print('과연??: ${weatherData.toString()}');
//       print('과연??!!: ${weatherData.name.toString()}');
//       print('과연?!!!: ${weatherData.temp.toString()}');
//     } catch (e) {
//       print("error!!!");
//       print(e);
//     }
//     // return position;
//   }
//
//   Future<void> getWeatherData({
//     @required String lat,
//     @required String lon,
//   }) async {
//     var str =
//         'http://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$_openweatherkey';
//     print(str);
//     var response = await http.get(str);
//
//     if (response.statusCode == 200) {
//       var data = response.body;
//       Map dataJson = jsonDecode(data);
//       weatherData = WeatherData.fromJson(dataJson);
//       print('~~~~~~~~~~~~~: ${weatherData.humidity.toString()}');
//
//       print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ data = $data');
//       print('!!!! : ${dataJson['main']['temp']}');
//       print('??? : ${dataJson['name']}');
//
//       // print('??? : ${weatherData['name']}');
//     } else {
//       print('response status code = ${response.statusCode}');
//     }
//   }
//
// }


class Location {
  double lat; //위도
  double lon; //경도
  Position position;

  Future<Position> getCurrentLocation() async {
    try {
      // print("111!!!");
      bool isLocationServiceEnabled =
      await Geolocator.isLocationServiceEnabled();
      if (isLocationServiceEnabled) {
        print("True!!");
      } else {
        print("False!!");
      }
      //이 코드는 오류가 날 수 있으니 try catch 로 오류잡기
      // print("222!!!");
      // Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low, timeLimit: Duration(seconds: 10)); <-- 이게 문제였음. 이유는 모르겠음.
      position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
      // print("asdf ${position.latitude}");
      // print("asdf ${position.longitude}");
      return position;

      // print("333!!!");
      //라이브러리를 통해 현재 나의 GPS 호출
      //low 부분의 정확도가 높아질수록 배터리 용량 많이 잡아먹음

      lat = position.latitude; //해당값 각각 할당
      lon = position.longitude;
      print(lat);
      print(lon);
      // await getWeatherData(lat: lat.toString(), lon: lon.toString());

      return position;
      // print('과연??: ${weatherData.toString()}');
      // print('과연??!!: ${weatherData.name.toString()}');
      // print('과연?!!!: ${weatherData.temp.toString()}');

    } catch (e) {
      print("error!!!");
      print(e);
    }
    // return position;
  }
}





/////////////////////////////////////////////////////
// class WeatherData {
//   final String name;
//   final num temp;
//   final num temp_max;
//   final num temp_min;
//   final num feels_like;
//   final int humidity;
//
//
//   WeatherData(this.name, this.temp, this.feels_like, this.humidity, this.temp_max, this.temp_min);
//
//   WeatherData.fromJson(Map<String, dynamic> json)
//       : name = json['name'],
//         temp = json['main']['temp'],
//         temp_max = json['main']['temp_max'],
//         temp_min = json['main']['temp_min'],
//         feels_like = json['main']['feels_like'],
//         humidity = json['main']['humidity'];
//
//   Map<String, dynamic> toJson() => {
//         'name': name,
//         'temp': temp,
//         'temp_max': temp_max,
//         'temp_min': temp_min,
//         'feels_like': feels_like,
//         'humidity': humidity,
//       };
// }
//
// class weatherBar extends StatefulWidget {
//   @override
//   _weatherBarState createState() => _weatherBarState();
// }
//
// class _weatherBarState extends State<weatherBar> {
//   double lat; //위도
//   double lon; //경도
//   Position position;
//   String _openweatherkey = "f781792aecfebe7bcce77b83a692ff4b";
//   var weatherData;
//
//   _weatherBarState() {
//     getCurrentLocation().then((value) => setState(() {
//       // print('두둥둥장: ${weatherData.toString()}');
//     }));
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     getCurrentLocation();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // print('!@!@!@!@!@!@: ${weatherData.toString()}');
//     // print('!@!@!@!@!@!@: ${weatherData.name.toString()}');
//     // print('!@!@!@!@!@!@: ${weatherData.temp.toString()}');
//     // print('!@!@!@!@!@!@: ${weatherData.feels_like.toString()}');
//     return Container(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: <Widget>[
//               SizedBox(width: 40),
//               Text(
//                 '${weatherData.temp.toStringAsFixed(0)}°',
//                 style: TextStyle(fontSize: 30),
//               ),
//               Column(
//                 children: [
//                   Text(
//                     '${weatherData.temp_min.toStringAsFixed(0)}°/${weatherData.temp_max.toStringAsFixed(0)}°',
//                     // style: TextStyle(fontSize: 55)
//                   ),
//                   Text(
//                     '${weatherData.name.toString()}',
//                     // style: TextStyle(fontSize: 15)
//                   ),
//                 ],
//               ),
//               SizedBox(width: 30),
//               SizedBox(width: 30),
//             ],
//           ),
//         ));
//   }
//
//   Future<Position> getCurrentLocation() async {
//     try {
//       // print("111!!!");
//       bool isLocationServiceEnabled =
//       await Geolocator.isLocationServiceEnabled();
//       if (isLocationServiceEnabled) {
//         print("True!!");
//       } else {
//         print("False!!");
//       }
//       //이 코드는 오류가 날 수 있으니 try catch 로 오류잡기
//       // print("222!!!");
//       // Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low, timeLimit: Duration(seconds: 10)); <-- 이게 문제였음. 이유는 모르겠음.
//       position =
//       await Geolocator.getCurrentPosition(timeLimit: Duration(seconds: 10));
//       // print("333!!!");
//       //라이브러리를 통해 현재 나의 GPS 호출
//       //low 부분의 정확도가 높아질수록 배터리 용량 많이 잡아먹음
//
//       lat = position.latitude; //해당값 각각 할당
//       lon = position.longitude;
//       print(lat);
//       print(lon);
//       // await getWeatherData(lat: lat.toString(), lon: lon.toString());
//
//       return position;
//       // print('과연??: ${weatherData.toString()}');
//       // print('과연??!!: ${weatherData.name.toString()}');
//       // print('과연?!!!: ${weatherData.temp.toString()}');
//
//     } catch (e) {
//       print("error!!!");
//       print(e);
//     }
//     // return position;
//   }
//
//   Future<void> getWeatherData({
//     @required String lat,
//     @required String lon,
//   }) async {
//     var str =
//         'http://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$_openweatherkey&units=metric';
//     print(str);
//     var response = await http.get(str);
//
//     if (response.statusCode == 200) {
//       var data = response.body;
//       Map dataJson = jsonDecode(data);
//       weatherData = WeatherData.fromJson(dataJson);
//
//       // print('??? : ${weatherData['name']}');
//     } else {
//       print('response status code = ${response.statusCode}');
//     }
//   }
// }
//////////////////////////////////////////////////////////



//
// class Location extends StatefulWidget {
//   @override
//   _LocationState createState() => _LocationState();
// }
//
// class _LocationState extends State<Location> {
//   @override
//   void initState() {
//     super.initState();
//     getPosition();
//   }
//
//
//   Future<void> getPosition() async {
//     print("GGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGG!!");
//     Position currentPosition = await Geolocator
//         .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
//     // var lastPosition = await Geolocator
//     //     .getLastKnownPosition();
//     print(currentPosition);
//     // print("lastPosition: $lastPosition");
//     getWeatherData(
//         lat: currentPosition.latitude.toString(),
//         lon: currentPosition.longitude.toString());
//     print("HHHHHHHHHHHHHHHHHHHHHHHHHH!!");
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         Row(
//           children: <Widget>[
//             Text('${weatherData['name']}',
//                 style: TextStyle(fontSize: 30)),
//             Text('${weatherData['main']['temp']}°',
//                 style: TextStyle(fontSize: 55)),
//             Text('  (feels : ${weatherData['main']['feels_like']}°)',
//                 style: TextStyle(fontSize: 15)),
//             Text('습도 : ${weatherData['main']['humidity']}%',
//                 style: TextStyle(fontSize: 55))
//           ],
//         )
//       ],
//     );
//   }
// }

// import 'package:location/location.dart';
//
// class LocationHelper {
//   double latitude;
//   double longitude;
//
//   Future<void> getCurrentLocation() async {
//     Location location = Location();
//     print("~~~~~~~~~~~~~~~~~~~~~~~``!!!");
//
//     bool _serviceEnabled;
//     PermissionStatus _permissionGranted;
//     LocationData _locationData;
//
//     // Check whether we have permissions for the location
//     _serviceEnabled = await location.serviceEnabled();
//     if (!_serviceEnabled) {
//       print("KKKKKKKKKKKKKKKKKKKKK!!!");
//       _serviceEnabled = await location.requestService();
//       if (!_serviceEnabled) {
//         print("Here!!!");
//         return;
//       }
//     }
//
//     // If permissions are not there, return
//     _permissionGranted = await location.hasPermission();
//     if (_permissionGranted == PermissionStatus.denied) {
//       print("LLLLLLLLLLLLLLLLLLLLLLLLL!!!");
//       _permissionGranted = await location.requestPermission();
//       if (_permissionGranted != PermissionStatus.granted) {
//         print("YYYYYYYYYYYYYYYYYYYY!!!");
//         return;
//       }
//     }
//
//     // If permissions are there, find the location and store the longitude and latitude
//     _locationData = await location.getLocation();
//     latitude = _locationData.latitude;
//     longitude = _locationData.longitude;
//     print(latitude.toString());
//     print(longitude.toString());
//   }
// }
//
