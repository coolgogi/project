import 'package:closet/closet.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geolocator_platform_interface/geolocator_platform_interface.dart'
    as locator;
import 'package:weather/weather.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'location.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

class weatherPage extends StatefulWidget {
  @override
  _weatherPageState createState() => _weatherPageState();
}

class _weatherPageState extends State<weatherPage> {
  String _key = "f781792aecfebe7bcce77b83a692ff4b";

  // String cityName = 'Kongens Lyngby';
  WeatherFactory wf;
  Weather weather;
  List<Weather> forecasts;

  @override
  void initState() {
    super.initState(); // super : 자식 클래스에서 부모 클래스의 멤버변수 참조할 때 사용
    wf = new WeatherFactory(_key, language: Language.KOREAN);
    getWeather();
  }

  Future<List<Weather>> getWeather() async {
    final locator.Position position = await Location().getCurrentLocation();
    double lat = position.latitude;
    double lon = position.longitude;

    List<Weather> _WeatherData = [];
    weather = await wf.currentWeatherByLocation(lat, lon);
    setState(() {
      _WeatherData = [weather];
      print("########### $_WeatherData");
      print("*********** $weather");
    });
  }

  Future<List<Weather>> getFiveDaysWeather() async {
    final locator.Position position = await Location().getCurrentLocation();
    double lat = position.latitude;
    double lon = position.longitude;

    forecasts = await wf.fiveDayForecastByLocation(lat, lon);
    // List<String> forecastData = [
    //  forecasts[0].temperature.toString(),
    //
    // ];
    print(">>>>>>>>>>>>>>>>>>>>>>>>>>>> ${forecasts[0].temperature}");
    print(">>>>>>>>>>>>>>>>>>>>>>>>>>>> ${forecasts[1].date}");
    print(">>>>>>>>>>>>>>>>>>>>>>>>>>>> ${forecasts[2].date}");
    print(">>>>>>>>>>>>>>>>>>>>>>>>>>>> ${forecasts[3].date}");
    print(">>>>>>>>>>>>>>>>>>>>>>>>>>>> ${forecasts[4].date}");
    return forecasts;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getFiveDaysWeather(),
      builder: (context, AsyncSnapshot<List<Weather>> forecasts) {
        if (forecasts.hasData == false) {
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            body: Center(
              child: SizedBox(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Theme.of(context).colorScheme.primary),
                ),
                height: 40.0,
                width: 40.0,
              ),
            ),
          );
        } else {
          return weatherInformation();
        }
      },
    );
  }

  Widget weatherInformation() {
    final Size size = MediaQuery.of(context).size;
    int temp = extractTemperature(weather.temperature.toString());
    int feelLike = extractTemperature(weather.tempFeelsLike.toString());
    int maxTemp = extractTemperature(weather.tempMax.toString());
    int minTemp = extractTemperature(weather.tempMin.toString());

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_arrow_left,
            color: Theme.of(context).colorScheme.onPrimary,
            size: 30,
          ),
          onPressed: () {
            Navigator.of(context).pop(SwipeablePageRoute(
              // onlySwipeFromEdge: true,
              builder: (BuildContext context) => closet(),
            ));
          },
        ),
        //
        title: Text(
          "날씨 추천",
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ),
        actions: [
          Icon(Icons.menu),
        ],
      ),
      body: ListView(
        // shrinkWrap: true,
        // padding: EdgeInsets.all(15.0),
        children: [
          weatherScreen(size, temp, maxTemp, minTemp, feelLike),
          Container(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  size.width * 0.0426, 8, size.width * 0.0426, 8),
              child: Row(
                children: <Widget>[
                  Text(
                    "CloDay's \nWeather News",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Image(
                  //   image: AssetImage("assets/cloy.png"),
                  //   width: size.width * 0.1
                  // ),

                  // SizedBox(width: 50),
                  // weatherMessage(weather),
                ],
              ),
            ),
          ),
          subTitle("~~님 오늘은 이런 코니 어때요?", size),
          codiRecommend(size),

          subTitle("시간대별 날씨", size),
          forecastChart(size),

          subTitle("상세날씨", size),
          detailWeatherInformation(feelLike),
          Divider(),

          subTitle("생활지수", size),
          livingIndexInformation(feelLike),
        ],
      ),
    );
  }

  Widget weatherScreen(Size size, int temp, int maxTemp, int minTemp, int feelLike) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        // height: size.height * 0.239,
        // height: size.height * 0.26,
        height: size.height * 0.32,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: detailWeatherBackground(weather),
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
            padding: EdgeInsets.fromLTRB(
                size.width * 0.0426, 8, size.width * 0.0426, 8),
            child: Column(
              children: [
                Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              size.width * 0.056, size.height * 0.024, 0, 0),
                          child: weatherIcon(weather, size.width * 0.15),
                        ),
                        SizedBox(height: 60),
                        // Padding(
                        //     padding: EdgeInsets.fromLTRB(
                        //         size.width * 0.04, size.height * 0.024, 0, 0),
                        //     child: Image(
                        //         image: AssetImage("assets/cloy.png"),
                        //         width: size.width * 0.085))
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        SizedBox(height: 50),
                        Padding(
                            padding: EdgeInsets.fromLTRB(
                                size.width * 0.04, size.height * 0.024, 0, 0),
                            child: Image(
                                image: AssetImage("assets/cloy.png"),
                                width: size.width * 0.085))
                      ],
                    ),
                    SizedBox(
                      // width: size.width * 0.3,
                      width: size.width * 0.18,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${temp.toString()}°",
                            style: TextStyle(
                              fontSize: 65,
                              fontWeight: FontWeight.bold,
                              // color: Theme.of(context).colorScheme.onPrimary,
                              color: Colors.white,
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                "${minTemp.toString()}°",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.blue,
                                ),
                              ),
                              Text(
                                "/",
                                style: TextStyle(
                                  fontSize: 12,
                                  // color: Theme.of(context).colorScheme.onPrimary,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "${maxTemp.toString()}°",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.red,
                                ),
                              ),
                              Text(
                                "  |  체감온도 ${feelLike.toString()}°",
                                style: TextStyle(
                                  fontSize: 12,
                                  // color: Theme.of(context).colorScheme.onPrimary,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "${weather.areaName}",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              // color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10),
                weatherMessage(weather),
              ],
            )
        ),
      ),
    );
  }



  Widget forecastChart(Size size) {
    return Stack(
      children: <Widget>[
        SfCartesianChart(
            enableAxisAnimation: true,
            primaryXAxis: CategoryAxis(
              labelPosition: ChartDataLabelPosition.inside,
              tickPosition: TickPosition.inside,
              axisLine: AxisLine(width: 0),
              opposedPosition: true,
              labelStyle: TextStyle(
                fontSize: 15,
                // fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            primaryYAxis: NumericAxis(
                isVisible: false,
                labelFormat: '{value}°',
                minimum: -20,
                maximum: 40,
                majorGridLines: MajorGridLines(width: 0),
                plotBands: <PlotBand>[
                  PlotBand(
                    start: 0,
                    end: 0,
                    borderColor: Colors.lightBlueAccent,
                    borderWidth: 1,
                    verticalTextPadding: '2%',
                    horizontalTextPadding: '-46%',
                    text: '0°',
                    textAngle: 0,
                    textStyle:
                    TextStyle(color: Colors.blueAccent, fontSize: 14),
                  ),
                ]),
            // Chart title
            // title: ChartTitle(text: '시간별 기온'),
            // Enable tooltip
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <LineSeries<forecastData, String>>[
              LineSeries<forecastData, String>(
                  dataSource: <forecastData>[
                    forecastData(
                        "${DateTime.parse(forecasts[0].date.toString()).hour}시",
                        extractTemperature(
                            forecasts[0].temperature.toString())),
                    forecastData(
                        "${DateTime.parse(forecasts[1].date.toString()).hour}시",
                        extractTemperature(
                            forecasts[1].temperature.toString())),
                    forecastData(
                        "${DateTime.parse(forecasts[2].date.toString()).hour}시",
                        extractTemperature(
                            forecasts[2].temperature.toString())),
                    forecastData(
                        "${DateTime.parse(forecasts[3].date.toString()).hour}시",
                        extractTemperature(
                            forecasts[3].temperature.toString())),
                    forecastData(
                        "${DateTime.parse(forecasts[4].date.toString()).hour}시",
                        extractTemperature(
                            forecasts[4].temperature.toString())),
                  ],
                  xValueMapper: (forecastData data, _) => data.time,
                  yValueMapper: (forecastData data, _) => data.temp,
                  markerSettings: MarkerSettings(isVisible: true),
                  // Enable data label
                  dataLabelSettings: DataLabelSettings(isVisible: true))
            ]),
        Padding(
          padding: EdgeInsets.only(top: 45),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              weatherIcon(forecasts[0], size.width * 0.08),
              weatherIcon(forecasts[1], size.width * 0.08),
              weatherIcon(forecasts[2], size.width * 0.08),
              weatherIcon(forecasts[3], size.width * 0.08),
              weatherIcon(forecasts[4], size.width * 0.08),
            ],
          ),
        ),
      ],
    );
  }


  Widget codiRecommend(Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image(
            width: size.width * 0.47,
            image: AssetImage('assets/codi1.jpg')),
        Image(
            width: size.width * 0.47,
            image: AssetImage('assets/codi2.jpg')),
      ],
    );
  }


  Widget detailWeatherInformation(int feelLike) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Column(
          children: <Widget>[
            SizedBox(
              height: 15,
            ),
            Icon(
              Icons.device_thermostat,
              size: 40,
            ),
            Text("$feelLike°"),
            SizedBox(
              height: 15,
            ),
            Text("체감온도"),
            Text(""),
          ],
        ),
        Column(
          children: <Widget>[
            SizedBox(
              height: 15,
            ),
            Icon(
              Icons.opacity,
              size: 40,
            ),
            Text("${weather.humidity}%"),
            SizedBox(
              height: 15,
            ),
            Text("습도"),
            Text(""),
          ],
        ),
        Column(
          children: <Widget>[
            SizedBox(
              height: 15,
            ),
            Icon(
              Icons.flag_outlined,
              size: 40,
            ),
            Text("${weather.windSpeed}m/s"),
            SizedBox(
              height: 15,
            ),
            Text("풍속"),
            Text(""),
          ],
        )
      ],
    );
  }

  Widget livingIndexInformation(int feelLike) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Column(
          children: <Widget>[
            SizedBox(
              height: 15,
            ),
            Icon(
              Icons.sick_outlined,
              size: 40,
            ),
            Text("$feelLike°"),
            SizedBox(
              height: 15,
            ),
            Text("감기"),
            Text(""),
          ],
        ),
        Column(
          children: <Widget>[
            SizedBox(
              height: 15,
            ),
            Icon(
              Icons.flare_outlined,
              size: 40,
            ),
            Text("${weather.humidity}%"),
            SizedBox(
              height: 15,
            ),
            Text("자외선"),
            Text(""),
          ],
        ),
        Column(
          children: <Widget>[
            SizedBox(
              height: 15,
            ),
            Icon(
              Icons.flag_outlined,
              size: 40,
            ),
            Text("${weather.windSpeed}m/s"),
            SizedBox(
              height: 15,
            ),
            Text("풍속"),
            Text(""),
          ],
        ),
        Column(
          children: <Widget>[
            SizedBox(
              height: 15,
            ),
            Icon(
              Icons.flag_outlined,
              size: 40,
            ),
            Text("${weather.windSpeed}m/s"),
            SizedBox(
              height: 15,
            ),
            Text("풍속"),
            Text(""),
          ],
        ),
      ],
    );
  }


  subTitle(String text, Size size) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          size.width * 0.0426, 8, size.width * 0.0426, 8
      ),
      child: Text(
        "$text",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }


  int extractTemperature(String data) {
    var parts = data.split(' ');
    var temp = parts[0].trim();
    var doubleNum = double.parse(temp);
    int result = doubleNum.round();

    return result;
  }


  Widget weatherMessage(Weather weather) {
    int temp = extractTemperature(weather.temperature.toString());
    int maxTemp = extractTemperature(weather.tempMax.toString());
    int minTemp = extractTemperature(weather.tempMin.toString());

    String codi;
    String advice;
    String tempDifference ='';

    if(maxTemp - minTemp >= 10) {
      tempDifference = '일교차 주의!';
    }

    if(27 <= temp) {
      advice = "오늘은 정말 더운날이네요!";
      codi = "추천의상: 민소매/반팔/반바지/치마";
    } else if(23 <= temp && temp <= 26) {
      advice = "오늘은 아주 여름여름한 날씨네요!";
      codi = "추천의상: 반팔/얇은 셔츠/반바지/면바지";
    } else if(20 <= temp && temp <= 22) {
      advice = "오늘은 반팔을 입긴 애매한 날씨네요!";
      codi = "추천의상: 얇은 가디건/긴팔티/면바지/슬랙스";
    } else if(17 <= temp && temp <= 19) {
      advice = "이정도면 꽤나 시원한 날씨죠!";
      codi = "추천의상: 니트/가디건/맨투맨/원피스/면바지/청바지/슬랙스";
    } else if(12 <= temp && temp <= 16) {
      advice = "추위를 타시는 편이라면 아우터도 챙겨가세요!";
      codi = "추천의상: 자켓/셔츠/가디건/야상/맨투맨/니트/스타킹";
    } else if(9 <= temp && temp <= 11) {
      advice = "오늘은 아우터도 챙겨입으시는 게 좋아요!";
      codi = "추천의상: 자켓/트렌치코트/야상/니트/스타킹/청바지/면바지";
    } else if(5 <= temp && temp <= 8) {
      advice = "오늘은 쌀쌀한 게 코트 입기 좋은 날씨군요!";
      codi = "추천의상: 코트/가죽자켓/니트/청바지/레깅스";
    } else {
      advice = "당장 가지고 계신 가장 따뜻한 아우터를 꺼내보아요!";
      codi = "추천의상: 겨울 옷(패딩/목도리/야상 등)";
    }

    return Text("$advice $tempDifference\n$codi", style: TextStyle(color: Colors.white,));
  }



  Widget weatherIcon(Weather weather, num width) {
    return weather.weatherMain == 'Rain'
        ? Image(
            image: AssetImage("assets/weather/rain.png"),
            width: width,
            fit: BoxFit.scaleDown,
          )
        : weather.weatherMain == 'Snow'
            ? Image(
                image: AssetImage("assets/weather/snow.png"),
                width: width,
                fit: BoxFit.scaleDown,
              )
            : weather.weatherConditionCode < 600
                ? Image(
                    image: AssetImage("assets/weather/cloudy.png"),
                    width: width,
                    fit: BoxFit.scaleDown,
                  )
                : ((18 < DateTime.parse(weather.date.toString()).hour) || (DateTime.parse(weather.date.toString()).hour < 8))
                    ? Image(
                        image: AssetImage("assets/weather/moon.png"),
                        width: width,
                        fit: BoxFit.scaleDown,
                      )
                    : Image(
                        image: AssetImage("assets/weather/sunny.png"),
                        width: width,
                        fit: BoxFit.scaleDown,
                      );
  }

  AssetImage detailWeatherBackground(Weather weather) {
    if((18 < DateTime.now().hour) || (DateTime.now().hour < 8)) {
      return AssetImage("assets/weather/detail_night.png");
    } else if(weather.weatherMain == 'Rain') {
        return AssetImage("assets/weather/detail_rain.png");
    } else if(weather.weatherMain == 'Snow') {
      return AssetImage("assets/weather/detail_snow.png");
    } else if(weather.weatherConditionCode < 600) {
      return AssetImage("assets/weather/detail_cloudy.png");
    } else {
      return AssetImage("assets/weather/detail_sunny.png");;
    }
    return weather.weatherMain == 'Rain'
        ? AssetImage("assets/weather/detail_rain.png")
            : weather.weatherMain == 'Snow'
              ? AssetImage("assets/weather/detail_snow.png")
              : weather.weatherConditionCode < 600
                  ? AssetImage("assets/weather/detail_cloudy.png")
                  : DateTime.now().hour >= 15
                      ? AssetImage("assets/weather/detail_night.png")
                      : AssetImage("assets/weather/detail_sunny.png");
  }
}

class forecastData {
  forecastData(this.time, this.temp);

  final String time;
  final int temp;
}
