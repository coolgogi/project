import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:geolocator_platform_interface/geolocator_platform_interface.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../location.dart';
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

class Forecast {
  final num temp1;
  final num temp2;
  final num temp3;
  final num temp4;
  final num temp5;
  final String time1;
  final String time2;
  final String time3;
  final String time4;
  final String time5;

  Forecast(this.temp1, this.temp2, this.temp3, this.temp4,
      this.temp5, this.time1, this.time2, this.time3, this.time4, this.time5);

  Forecast.fromJson(Map<String, dynamic> json)
      : temp1 = json[0]['main']['temp'],
        temp2 = json[1]['main']['temp'],
        temp3 = json[2]['main']['temp'],
        temp4 = json[3]['main']['temp'],
        temp5 = json[4]['main']['temp'],
        time1 = json[0]['dt_txt'],
        time2 = json[1]['dt_txt'],
        time3 = json[2]['dt_txt'],
        time4 = json[3]['dt_txt'],
        time5 = json[4]['dt_txt'];


  Map<String, dynamic> toJson() => {
      'temp1': temp1,
      'temp2': temp2,
      'temp3': temp3,
      'temp4': temp4,
      'temp5': temp5,
      'time1': time1,
      'time2': time2,
      'time3': time3,
      'time4': time4,
      'time5': time5,
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

    return Container(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder(
        future: getWeatherData(),
        builder: (context, AsyncSnapshot<WeatherData> snapshot) {
          if (snapshot.hasData == false) {
            return Center(
              child: SizedBox(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Theme.of(context).colorScheme.primary),
                ),
                height: 40.0,
                width: 40.0,
              ),
            );
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
          image: detailWeatherBackground(weatherData),
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

  AssetImage detailWeatherBackground(WeatherData weather) {
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


// import 'package:geolocator_platform_interface/geolocator_platform_interface.dart'
// as locator;
// import 'package:weather/weather.dart';
// import 'dart:async';
// import 'package:flutter/material.dart';
// import '../location.dart';
//
// class weatherBar extends StatefulWidget {
//   @override
//   _weatherBarState createState() => _weatherBarState();
// }
//
//
// class _weatherBarState extends State<weatherBar> {
//   String _key = "f781792aecfebe7bcce77b83a692ff4b";
//
//   // String cityName = 'Kongens Lyngby';
//   WeatherFactory wf;
//   Weather weather;
//
//   @override
//   void initState() {
//     super.initState(); // super : 자식 클래스에서 부모 클래스의 멤버변수 참조할 때 사용
//     wf = new WeatherFactory(_key, language: Language.KOREAN);
//   }
//
//   Future<Weather> getWeather() async {
//     final locator.Position position = await Location().getCurrentLocation();
//     double lat = position.latitude;
//     double lon = position.longitude;
//
//     weather = await wf.currentWeatherByLocation(lat, lon);
//     setState(() {
//       print("*********** $weather");
//     });
//     return weather;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery.of(context).size;
//
//     return FutureBuilder(
//       future: getWeather(),
//       builder: (context, AsyncSnapshot<Weather> weather) {
//         if (weather.hasData == false) {
//           print('ooooooooo');
//           return CircularProgressIndicator();
//         } else {
//           return createWeatherBar(size);
//         }
//       },
//     );
//   }
//
//   Widget createWeatherBar(Size size) {
//     int temp = extractTemperature(weather.temperature.toString());
//     int feelLike = extractTemperature(weather.tempFeelsLike.toString());
//     int maxTemp = extractTemperature(weather.tempMax.toString());
//     int minTemp = extractTemperature(weather.tempMin.toString());
//
//     return Container(
//       height: size.height * 0.101,
//       decoration: BoxDecoration(
//         image: DecorationImage(
//           image: weatherBarBackground(weather),
//           fit: BoxFit.fill,
//         ),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: <Widget>[
//             // SizedBox(width: 10),
//             weatherIcon(weather, size.width * 0.2),
//             Text(
//               '${temp.toString()}°c',
//               style: TextStyle(
//                   fontSize: 30,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white
//               ),
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   '${minTemp.toString()}°/${maxTemp.toString()}°',/////////////////////////////////////
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
//                 SizedBox(width: 30),
//               ],
//             ),
//             SizedBox(width: 30),
//           ],
//         ),
//       ),
//     );
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
//
//   Widget weatherIcon(Weather weather, num width) {
//     return weather.weatherMain == 'Rain'
//         ? Image(
//             image: AssetImage("assets/weather/rain.png"),
//             width: width,
//             fit: BoxFit.scaleDown,
//           )
//         : weather.weatherMain == 'Snow'
//             ? Image(
//                 image: AssetImage("assets/weather/snow.png"),
//                 width: width,
//                 fit: BoxFit.scaleDown,
//               )
//             : weather.weatherConditionCode < 600
//                 ? Image(
//                     image: AssetImage("assets/weather/cloudy.png"),
//                     width: width,
//                     fit: BoxFit.scaleDown,
//                   )
//                 : DateTime.now().hour >= 15
//                     ? Image(
//                         image: AssetImage("assets/weather/moon.png"),
//                         width: width,
//                         fit: BoxFit.scaleDown,
//                       )
//                     : Image(
//                         image: AssetImage("assets/weather/sunny.png"),
//                         width: width,
//                         fit: BoxFit.scaleDown,
//                       );
//   }
//
//
//   AssetImage weatherBarBackground(Weather weather) {
//     if(DateTime.now().hour >= 18) {
//       return AssetImage("assets/weather/background_night.png");
//     } else if(weather.weatherMain == 'Rain') {
//       return AssetImage("assets/weather/background_rain.png");
//     } else if(weather.weatherMain == 'Snow') {
//       return AssetImage("assets/weather/background_snow.png");
//     } else if(weather.weatherConditionCode < 600) {
//       return AssetImage("assets/weather/background_cloudy.png");
//     } else {
//       return AssetImage("assets/weather/background_sunny.png");;
//     }
//   }
// }







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
