import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/screens/city_screen.dart';
import 'package:weather_app/services/weather_model.dart';

class LocationScreen extends StatefulWidget {
  final Map<String, dynamic> weatherData;

  const LocationScreen({Key? key, required this.weatherData}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = WeatherModel();
  ImageProvider networkImage =
  const NetworkImage('https://source.unsplash.com/random/?cloud');

  ImageProvider assetImage = const AssetImage('images/location_background.jpg');
  bool doneLoading = false;

  late num temp;
  late String cityName;
  late int condition;
  late String description;
  late String iconWeather;

  void updateUi(var wData) {
    setState(() {
      temp = wData['main']['temp'];
      cityName = wData['name'];
      condition = wData['weather'][0]['id'];
      iconWeather = weatherModel.getWeatherIcon(condition);
      description = weatherModel.getMessage(temp.toDouble());
    });
  }

  @override
  void initState() {
    networkImage.resolve(const ImageConfiguration()).addListener(
        ImageStreamListener((image, synchronousCall) {
          setState(() {
            doneLoading = true;
          });
        }));
    updateUi(widget.weatherData);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          Container(
              decoration:  BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: !doneLoading ?assetImage:networkImage)),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6.0),
                child: Container(
                  decoration:
                      BoxDecoration(color: Colors.white.withOpacity(0.2)),
                ),
              )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 60),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          padding: const EdgeInsets.only(left: 5),
                          onPressed: () {
                            setState(() {
                              updateUi(widget.weatherData);
                            });
                          },
                          icon: const Icon(
                            Icons.near_me,
                            color: Colors.blue,
                            size: 40,
                          )),
                      IconButton(
                          padding: const EdgeInsets.only(right: 5),
                          onPressed: () async {
                            var result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const CityScreen(),
                                ));
                            updateUi(result);
                          },
                          icon: const Icon(
                            Icons.location_city,
                            color: Colors.blue,
                            size: 40,
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  Text(
                    iconWeather,
                    style: const TextStyle(
                      fontSize: 120,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 17),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          temp.round().toString(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 100,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 35,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.white, width: 10),
                                  shape: BoxShape.circle),
                            ),
                            Container(
                              width: 35,
                              height: 5,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.white, width: 10),
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            const Text(
                              'now',
                              style: TextStyle(
                                  color: Colors.white54,
                                  letterSpacing: 3,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  Text(
                    '$description in $cityName',
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
