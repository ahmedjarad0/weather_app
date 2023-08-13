import 'package:flutter/material.dart';
import 'package:weather_app/services/networking.dart';
import 'package:weather_app/services/weather_model.dart';

class CityScreen extends StatefulWidget {
  const CityScreen({Key? key}) : super(key: key);

  @override
  State<CityScreen> createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  WeatherModel weatherModel = WeatherModel();
  String? city;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'images/city_background.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.blue,
                          size: 50,
                        )),
                    const SizedBox(
                      height: 40,
                    ),
                    TextField(
                      onChanged: (value) {
                        setState(() {
                          city = value;
                        });
                      },
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          focusColor: Colors.grey,
                          icon: const Icon(
                            Icons.location_city,
                            color: Colors.blue,
                          ),
                          hintText: 'Enter City Name',
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          )),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: TextButton(
                          onPressed: () async {
                            Map<String, dynamic> weatherData =
                                await NetworkHelper().getCityData(city!);
                            Navigator.pop(context, weatherData);
                          },
                          child: const Text(
                            'Get Weather',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                                fontSize: 30),
                          )),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
