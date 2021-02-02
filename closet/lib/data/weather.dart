import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geolocator_platform_interface/geolocator_platform_interface.dart';
import 'package:weather/weather.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';
import '../location.dart';

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

class weatherBar extends StatefulWidget {
  @override
  _weatherBarState createState() => _weatherBarState();
}

class _weatherBarState extends State<weatherBar> {
  double lat; //위도
  double lon; //경도
  String _openweatherkey = "f781792aecfebe7bcce77b83a692ff4b";
  var weatherData;

  _weatherBarState() {
    getWeatherData().then((value) => setState(() {}));
  }

  @override
  void initState() {
    super.initState();
    getWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    // print('!@!@!@!@!@!@: ${weatherData.toString()}');
    // print('!@!@!@!@!@!@: ${weatherData.name.toString()}');
    // print('!@!@!@!@!@!@: ${weatherData.temp.toString()}');
    // print('!@!@!@!@!@!@: ${weatherData.feels_like.toString()}');

    return Container(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder(
        future: getWeatherData(),
        builder: (context, AsyncSnapshot<WeatherData> snapshot) {
          if (snapshot.hasData == false) {
            return CircularProgressIndicator();
          }
          return Container(
            height: size.height * 0.101,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/weather/background_snow.png'),
                  fit: BoxFit.fill,
                ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  // SizedBox(width: 10),
                  weatherIcon(weatherData, size),
                  Text(
                    '${weatherData.temp.toStringAsFixed(0)}°c',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                      SizedBox(width: 30),
                    ],
                  ),
                  SizedBox(width: 30),
                ],
              ),
            ),
          );
        },
      ),
    ));
  }


  Widget weatherIcon(WeatherData weatherData, size) {
    return weatherData.weather == 'Rain'
        ? Image(
            image: AssetImage("assets/weather/rain.png"),
            width: size.width * 0.1,
            fit: BoxFit.scaleDown,
          )
        : weatherData.weather == 'Snow'
            ? Image(
                image: AssetImage("assets/weather/snow.png"),
                width: size.width * 0.1,
                fit: BoxFit.scaleDown,
              )
            : weatherData.currentCondition < 600
                ? Image(
                    image: AssetImage("assets/weather/cloudy.png"),
                    width: size.width * 0.1,
                    fit: BoxFit.scaleDown,
                  )
                : DateTime.now().hour >= 15
                    ? Image(
                        image: AssetImage("assets/weather/moon.png"),
                        width: size.width * 0.1,
                        fit: BoxFit.scaleDown,
                      )
                    : Image(
                        image: AssetImage("assets/weather/sunny.png"),
                        width: size.width * 0.1,
                        fit: BoxFit.scaleDown,
                      );
  }

  Future<WeatherData> getWeatherData() async {
    final Position position = await Location().getCurrentLocation();

    lat = position.latitude;
    lon = position.longitude;
    var str =
        'http://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$_openweatherkey&units=metric';
    print(str);
    var response = await http.get(str);

    if (response.statusCode == 200) {
      var data = response.body;
      print(data);
      Map dataJson = jsonDecode(data);
      weatherData = WeatherData.fromJson(dataJson);

      return weatherData;

      // print('??? : ${weatherData['name']}');
    } else {
      print('response status code = ${response.statusCode}');
    }
  }
}

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
