import 'dart:convert';
import 'file:///C:/Users/82106/Desktop/gitFlutter/project/closet/lib/data/weather/dust.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geolocator_platform_interface/geolocator_platform_interface.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'weather/UVdata.dart';
import 'location.dart';
import '../weatherPage.dart';

class WeatherData {
  final String name;
  final num temp;
  final num temp_max;
  final num temp_min;
  final num feels_like;
  final int humidity;
  final int currentCondition;
  final String weather;

  WeatherData(this.name, this.temp, this.feels_like, this.humidity,
      this.temp_max, this.temp_min, this.currentCondition, this.weather);

  WeatherData.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        temp = json['main']['temp'],
        temp_max = json['main']['temp_max'],
        temp_min = json['main']['temp_min'],
        feels_like = json['main']['feels_like'],
        humidity = json['main']['humidity'],
        currentCondition = json['weather'][0]['id'],
        weather = json['weather'][0]['main'];

  Map<String, dynamic> toJson() => {
    'name': name,
    'temp': temp,
    'temp_max': temp_max,
    'temp_min': temp_min,
    'feels_like': feels_like,
    'humidity': humidity,
    'currentCondition': currentCondition,
    'weather': weather,
  };
}

// class Forecast {
//   final num temp1;
//   final num temp2;
//   final num temp3;
//   final num temp4;
//   final num temp5;
//   final String time1;
//   final String time2;
//   final String time3;
//   final String time4;
//   final String time5;
//
//   Forecast(this.temp1, this.temp2, this.temp3, this.temp4,
//       this.temp5, this.time1, this.time2, this.time3, this.time4, this.time5);
//
//   Forecast.fromJson(Map<String, dynamic> json)
//       : temp1 = json[0]['main']['temp'],
//         temp2 = json[1]['main']['temp'],
//         temp3 = json[2]['main']['temp'],
//         temp4 = json[3]['main']['temp'],
//         temp5 = json[4]['main']['temp'],
//         time1 = json[0]['dt_txt'],
//         time2 = json[1]['dt_txt'],
//         time3 = json[2]['dt_txt'],
//         time4 = json[3]['dt_txt'],
//         time5 = json[4]['dt_txt'];
//
//
//   Map<String, dynamic> toJson() => {
//       'temp1': temp1,
//       'temp2': temp2,
//       'temp3': temp3,
//       'temp4': temp4,
//       'temp5': temp5,
//       'time1': time1,
//       'time2': time2,
//       'time3': time3,
//       'time4': time4,
//       'time5': time5,
//   };
// }



class weatherBar extends StatefulWidget {
  @override
  _weatherBarState createState() => _weatherBarState();
}

class _weatherBarState extends State<weatherBar> {
  double lat; //위도
  double lon; //경도
  String _openweatherkey = "f781792aecfebe7bcce77b83a692ff4b";
  var weatherData;
  String uvData;
  String dustData;

  // _weatherBarState() {
  //   getWeatherData().then((value) => setState(() {}));
  // }

  @override
  void initState() {
    super.initState();
    getWeatherData().then((value) => setState(() {
      weatherData = value;
    }));
    // UVData().getUVData(lat: lat.toString(), lon: lon.toString())
    //     .then((value) => uvData = value);
    // DustData().getDustData(lat: lat.toString(), lon: lon.toString())
    //     .then((value) => dustData = value);
    print("UV: $uvData");
    print("dust: $dustData");
    // weatherPage.getFiveDaysWeather();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
            future: getWeatherData(),
            builder: (context, AsyncSnapshot<WeatherData> snapshot) {
              if (snapshot.hasData == false) {
                if(weatherData != null) {
                  print("llll");
                  return CreateWeatherBar(weatherData, size);
                } else {
                  print('asdfhjdh');
                  return Center(
                    child: Container(
                      height: 40.0,
                      width: 40.0,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Theme.of(context).colorScheme.primary),
                      ),
                    ),
                  );
                }
              }
              else {
                return CreateWeatherBar(weatherData, size);
              }
            },
          ),
        ));
  }


  Widget CreateWeatherBar(WeatherData weatherData, size) {
    return Container(
      height: size.height * 0.101,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: weatherBarBackground(weatherData),
          fit: BoxFit.fill,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            // SizedBox(width: 10),
            weatherIcon(weatherData, size.width * 0.1),
            Text(
              '${weatherData.temp.toStringAsFixed(0)}°c',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
              ),
            ),
            SizedBox(width: size.width * 0.05),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Text(
                  '${weatherData.temp_min.toStringAsFixed(0)}°/${weatherData.temp_max.toStringAsFixed(0)}°',
                  style: TextStyle(
                    // fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),
                ),
                Text(
                  '${weatherData.name.toString()}',
                  style: TextStyle(
                    // fontSize: 30,
                    // fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),
                ),
              ],
            ),
            SizedBox(width: size.width * 0.2),
          ],
        ),
      ),
    );
  }


  Widget weatherIcon(WeatherData weatherData, size) {
    return weatherData.weather == 'Rain'
        ? Image(
      image: AssetImage("assets/weather/rain.png"),
      width: size,
      fit: BoxFit.scaleDown,
    )
        : weatherData.weather == 'Snow'
        ? Image(
      image: AssetImage("assets/weather/snow.png"),
      width: size,
      fit: BoxFit.scaleDown,
    )
        : weatherData.currentCondition < 600
        ? Image(
      image: AssetImage("assets/weather/cloudy.png"),
      width: size,
      fit: BoxFit.scaleDown,
    )
        : ((18 < DateTime.now().hour) || (DateTime.now().hour < 8))
        ? Image(
      image: AssetImage("assets/weather/moon.png"),
      width: size,
      fit: BoxFit.scaleDown,
    )
        : Image(
      image: AssetImage("assets/weather/sunny.png"),
      width: size,
      fit: BoxFit.scaleDown,
    );
  }

  AssetImage weatherBarBackground(WeatherData weather) {
    return weatherData.weather == 'Rain'
        ? AssetImage("assets/weather/background_rain.png")
        : weatherData.weather == 'Snow'
        ? AssetImage("assets/weather/background_snow.png")
        : weatherData.currentCondition < 600
        ? AssetImage("assets/weather/background_cloudy.png")
        : ((18 < DateTime.now().hour) || (DateTime.now().hour < 8))
        ? AssetImage("assets/weather/background_night.png")
        : AssetImage("assets/weather/background_sunny.png");
  }


  Future<WeatherData> getWeatherData() async {
    final Position position = await Location().getCurrentLocation();

    lat = position.latitude;
    lon = position.longitude;
    var str =
        'http://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$_openweatherkey&units=metric&&lang=kr';
    // print(str);
    var response = await http.get(str);

    if (response.statusCode == 200) {
      var data = response.body;
      // print(data);
      Map dataJson = jsonDecode(data);
      weatherData = WeatherData.fromJson(dataJson);

      return weatherData;

    } else {
      print('response status code = ${response.statusCode}');
    }
  }
}


////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
// import 'dart:convert';
// import 'package:geolocator/geolocator.dart';
// import 'package:geolocator_platform_interface/geolocator_platform_interface.dart';
// import 'dart:async';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'location.dart';
// import '../weatherPage.dart';
//
//
// import 'dart:io';
//
// import 'package:closet/closet.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:geolocator_platform_interface/geolocator_platform_interface.dart'
// as locator;
// import 'dart:async';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:syncfusion_flutter_charts/sparkcharts.dart';
// import 'package:swipeable_page_route/swipeable_page_route.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:async/async.dart';
//
// // class WeatherData {
// //   final String name;
// //   final num temp;
// //   final num temp_max;
// //   final num temp_min;
// //   final num feels_like;
// //   final int humidity;
// //   final int currentCondition;
// //   final String weather;
// //
// //   WeatherData(this.name, this.temp, this.feels_like, this.humidity,
// //       this.temp_max, this.temp_min, this.currentCondition, this.weather);
// //
// //   WeatherData.fromJson(Map<String, dynamic> json)
// //       : name = json['name'],
// //         temp = json['main']['temp'],
// //         temp_max = json['main']['temp_max'],
// //         temp_min = json['main']['temp_min'],
// //         feels_like = json['main']['feels_like'],
// //         humidity = json['main']['humidity'],
// //         currentCondition = json['weather'][0]['id'],
// //         weather = json['weather'][0]['main'];
// //
// //   Map<String, dynamic> toJson() => {
// //         'name': name,
// //         'temp': temp,
// //         'temp_max': temp_max,
// //         'temp_min': temp_min,
// //         'feels_like': feels_like,
// //         'humidity': humidity,
// //         'currentCondition': currentCondition,
// //         'weather': weather,
// //       };
// // }
//
// // class Forecast {
// //   final num temp1;
// //   final num temp2;
// //   final num temp3;
// //   final num temp4;
// //   final num temp5;
// //   final String time1;
// //   final String time2;
// //   final String time3;
// //   final String time4;
// //   final String time5;
// //
// //   Forecast(this.temp1, this.temp2, this.temp3, this.temp4,
// //       this.temp5, this.time1, this.time2, this.time3, this.time4, this.time5);
// //
// //   Forecast.fromJson(Map<String, dynamic> json)
// //       : temp1 = json[0]['main']['temp'],
// //         temp2 = json[1]['main']['temp'],
// //         temp3 = json[2]['main']['temp'],
// //         temp4 = json[3]['main']['temp'],
// //         temp5 = json[4]['main']['temp'],
// //         time1 = json[0]['dt_txt'],
// //         time2 = json[1]['dt_txt'],
// //         time3 = json[2]['dt_txt'],
// //         time4 = json[3]['dt_txt'],
// //         time5 = json[4]['dt_txt'];
// //
// //
// //   Map<String, dynamic> toJson() => {
// //       'temp1': temp1,
// //       'temp2': temp2,
// //       'temp3': temp3,
// //       'temp4': temp4,
// //       'temp5': temp5,
// //       'time1': time1,
// //       'time2': time2,
// //       'time3': time3,
// //       'time4': time4,
// //       'time5': time5,
// //   };
// // }
//
//
//
// class weatherBar extends StatefulWidget {
//   @override
//   _weatherBarState createState() => _weatherBarState();
// }
//
// class _weatherBarState extends State<weatherBar> {
//   WeatherFactory wf;
//   Weather weather;
//   double lat; //위도
//   double lon; //경도
//   String _openweatherkey = "f781792aecfebe7bcce77b83a692ff4b";
//   var weatherData;
//   final AsyncMemoizer _memoizer = AsyncMemoizer();
//
//   // _weatherBarState() {
//   //   getWeatherData().then((value) => setState(() {}));
//   // }
//
//   @override
//   void initState() {
//     super.initState();
//     wf = new WeatherFactory(_openweatherkey, language: Language.KOREAN);
//     getWeatherData();
//     // weatherPage.getFiveDaysWeather();
//   }
//
//   Future<Weather> getWeatherData() {
//     return this._memoizer.runOnce(() async {
//       final locator.Position position = await Location().getCurrentLocation();
//       double lat = position.latitude;
//       double lon = position.longitude;
//
//       weather = await wf.currentWeatherByLocation(lat, lon);
//       setState(() {
//         print("*********** $weather");
//       });
//
//       return weather;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery
//         .of(context)
//         .size;
//
//     return Container(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: FutureBuilder(
//             future: getWeatherData(),
//             // builder: (context, AsyncSnapshot<WeatherData> snapshot) {
//             builder: (context, AsyncSnapshot<Weather> snapshot) {
//               if (snapshot.hasData == false) {
//                 if (weather != null) {
//                   print("llll");
//                   return CreateWeatherBar(size);
//                 } else {
//                   return Center(
//                     child: SizedBox(
//                       child: CircularProgressIndicator(
//                         valueColor: AlwaysStoppedAnimation(Theme
//                             .of(context)
//                             .colorScheme
//                             .primary),
//                       ),
//                       height: 40.0,
//                       width: 40.0,
//                     ),
//                   );
//                 }
//               }
//               else {
//                 return CreateWeatherBar(size);
//               }
//               return CreateWeatherBar(size);
//             },
//           ),
//         ));
//   }
//
//
//   Widget CreateWeatherBar(Size size) {
//     int temp = extractTemperature(weather.temperature.toString());
//     int feelLike = extractTemperature(weather.tempFeelsLike.toString());
//     int maxTemp = extractTemperature(weather.tempMax.toString());
//     int minTemp = extractTemperature(weather.tempMin.toString());
//     print("temp: ${temp.toString()}");
//
//     return Container(
//       height: size.height * 0.101,
//       decoration: BoxDecoration(
//         image: DecorationImage(
//           image: detailWeatherBackground(weather),
//           fit: BoxFit.fill,
//         ),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: <Widget>[
//             // SizedBox(width: 10),
//             weatherIcon(weather, size.width * 0.1),
//             Text(
//               '${temp.toString()}°c',
//               style: TextStyle(
//                   fontSize: 30,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white
//               ),
//             ),
//             SizedBox(width: size.width * 0.05),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: 10),
//                 Text(
//                   '${minTemp.toString()}°/${maxTemp.toString()}°',
//                   style: TextStyle(
//                     // fontSize: 30,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white
//                   ),
//                 ),
//                 Text(
//                   '${weather.areaName}',
//                   style: TextStyle(
//                     // fontSize: 30,
//                     // fontWeight: FontWeight.bold,
//                       color: Colors.white
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(width: size.width * 0.2),
//           ],
//         ),
//       ),
//     );
//   }
//
//
//   Widget weatherIcon(Weather weather, width) {
//     if (weather.weatherMain == 'Rain') {
//       return Image(
//         image: AssetImage("assets/weather/rain.png"),
//         width: width,
//         fit: BoxFit.scaleDown,
//       );
//     } else if (weather.weatherMain == 'Snow') {
//       return Image(
//         image: AssetImage("assets/weather/snow.png"),
//         width: width,
//         fit: BoxFit.scaleDown,
//       );
//     } else if ((weather.weatherConditionCode < 600) ||
//         (weather.weatherConditionCode == 804)) {
//       return Image(
//         image: AssetImage("assets/weather/cloudy.png"),
//         width: width,
//         fit: BoxFit.scaleDown,
//       );
//     } else if (weather.weatherConditionCode == 801) {
//       if ((18 < DateTime
//           .parse(weather.date.toString())
//           .hour) || (DateTime
//           .parse(weather.date.toString())
//           .hour < 8)) {
//         return Image(
//           image: AssetImage("assets/weather/few_clouds_night.png"),
//           width: width,
//           fit: BoxFit.scaleDown,
//         );
//       } else {
//         return Image(
//           image: AssetImage("assets/weather/few_clouds.png"),
//           width: width,
//           fit: BoxFit.scaleDown,
//         );
//       }
//     } else if ((weather.weatherConditionCode == 802) ||
//         (weather.weatherConditionCode == 803)) {
//       if ((18 < DateTime
//           .parse(weather.date.toString())
//           .hour) || (DateTime
//           .parse(weather.date.toString())
//           .hour < 8)) {
//         return Image(
//           image: AssetImage("assets/weather/broken_clouds_night.png"),
//           width: width,
//           fit: BoxFit.scaleDown,
//         );
//       } else {
//         return Image(
//           image: AssetImage("assets/weather/broken_clouds.png"),
//           width: width,
//           fit: BoxFit.scaleDown,
//         );
//       }
//     } else if ((18 < DateTime
//         .parse(weather.date.toString())
//         .hour) || (DateTime
//         .parse(weather.date.toString())
//         .hour < 8)) {
//       return Image(
//         image: AssetImage("assets/weather/moon.png"),
//         width: width,
//         fit: BoxFit.scaleDown,
//       );
//     } else {
//       return Image(
//         image: AssetImage("assets/weather/sunny.png"),
//         width: width,
//         fit: BoxFit.scaleDown,
//       );
//     }
//   }
//
//   AssetImage detailWeatherBackground(Weather weather) {
//     if ((18 < DateTime
//         .now()
//         .hour) || (DateTime
//         .now()
//         .hour < 8)) {
//       return AssetImage("assets/weather/background_night.png");
//     } else if (weather.weatherMain == 'Rain') {
//       return AssetImage("assets/weather/background_rain.png");
//     } else if (weather.weatherMain == 'Snow') {
//       return AssetImage("assets/weather/background_snow.png");
//     } else if (weather.weatherConditionCode < 600) {
//       return AssetImage("assets/weather/background_cloudy.png");
//     } else {
//       return AssetImage("assets/weather/background_sunny.png");;
//     }
//   }
//
//
//   int extractTemperature(String data) {
//     var parts = data.split(' ');
//     var temp = parts[0].trim();
//     var doubleNum = double.parse(temp);
//     int result = doubleNum.round();
//
//     return result;
//   }
// }
