// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:weather/weather.dart';
// import '../location.dart';
//
// class weather extends StatefulWidget {
//   @override
//   _weatherState createState() => _weatherState();
// }
//
// class _weatherState extends State<weather> {
//   Position position;
//   // double lat = Location().lat;
//   // double lon = Location().lon;
//
//   List<Weather> _WeatherData = [];
//   String _key = "f781792aecfebe7bcce77b83a692ff4b";
//   // String cityName = 'Kongens Lyngby';
//   WeatherFactory wf;
//
//   @override
//   void initState() {
//     super.initState(); // super : 자식 클래스에서 부모 클래스의 멤버변수 참조할 때 사용
//     wf = new WeatherFactory(_key, language: Language.KOREAN);
//   }
//
//   Future<void> getWeather() async {
//     Weather weather = await wf.currentWeatherByLocation(lat, lon);
//     setState(() {
//       _WeatherData = [weather];
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Text('lat: $lat, lon: $lon'),
//     );
//   }
// }
//






// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// final _openweatherkey = 'f781792aecfebe7bcce77b83a692ff4b';
//
// Future<void> getWeatherData({
//   @required String lat,
//   @required String lon,
// }) async {
//   var str =
//       'http://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$_openweatherkey&units=metric';
//   print(str);
//   var response = await http.get(str);
//
//   if (response.statusCode == 200) {
//     var data = response.body;
//     var dataJson = jsonDecode(data); // string to json
//     print('data = $data');
//     print('${dataJson['main']['temp']}');
//   } else {
//     print('response status code = ${response.statusCode}');
//   }
// }


// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:http/http.dart';
//
// import '../location.dart';
//
// const _apiKey = 'f781792aecfebe7bcce77b83a692ff4b';
//
// class WeatherDisplayData {
//   Icon weatherIcon;
//   AssetImage weatherImage;
//
//   WeatherDisplayData({@required this.weatherIcon, @required this.weatherImage});
// }
//
// class WeatherData {
//   WeatherData({@required this.locationData});
//
//   LocationHelper locationData;
//   double currentTemperature;
//   int currentCondition;
//
//   Future<void> getCurrentTemperature() async {
//     Response response = await get(
//         'http://api.openweathermap.org/data/2.5/weather?lat=${locationData.latitude}&lon=${locationData.longitude}&appid=${_apiKey}&units=metric');
//
//     if (response.statusCode == 200) {
//       String data = response.body;
//       var currentWeather = jsonDecode(data);
//
//       try {
//         currentTemperature = currentWeather['main']['temp'];
//         currentCondition = currentWeather['weather'][0]['id'];
//       } catch (e) {
//         print(e);
//       }
//     } else {
//       print('Could not fetch temperature!');
//     }
//   }
//
//   WeatherDisplayData getWeatherDisplayData() {
//     if (currentCondition < 600) {
//       return WeatherDisplayData(
//         weatherIcon: Icon(
//           FontAwesomeIcons.cloud,
//           size: 75.0,
//         ),
//         weatherImage: AssetImage('assets/cloud.png'),
//       );
//     } else {
//       var now = new DateTime.now();
//
//       if (now.hour >= 15) {
//         return WeatherDisplayData(
//           weatherImage: AssetImage('assets/night.png'),
//           weatherIcon: Icon(
//             FontAwesomeIcons.moon,
//             size: 75.0,
//             color: Colors.white,
//           ),
//         );
//       } else {
//         return WeatherDisplayData(
//           weatherIcon: Icon(
//             FontAwesomeIcons.sun,
//             size: 75.0,
//             color: Colors.white,
//           ),
//           weatherImage: AssetImage('assets/sunny.png'),
//         );
//       }
//     }
//   }
// }