import 'package:country_state_city_pro/country_state_city_pro.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/services/networking.dart';
import 'package:weather_app/services/weather_model.dart';

class CityScreen extends StatefulWidget {
  const CityScreen({Key? key}) : super(key: key);

  @override
  State<CityScreen> createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
 late TextEditingController country ;
 late TextEditingController state ;
 late TextEditingController cityC ;
  WeatherModel weatherModel = WeatherModel();
  String? city;
@override
  void initState() {
    super.initState();
    country =TextEditingController();
    state =TextEditingController();
    cityC =TextEditingController();
  }
  @override
  void dispose() {
  country.dispose();
  state.dispose();
  cityC.dispose();
    super.dispose();
  }
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

                    CountryStateCityPicker(
                        country: country,
                        state: state,
                        city: cityC,
                        dialogColor: Colors.grey.shade200,
                        textFieldDecoration: InputDecoration(
                            fillColor: Colors.blueGrey.shade100,
                            filled: true,
                            suffixIcon: const Icon(Icons.arrow_downward_rounded),
                            border: const OutlineInputBorder(borderSide: BorderSide.none))
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: TextButton(
                          onPressed: () async {
                            Map<String, dynamic> weatherData =
                                await NetworkHelper().getCityData(country.text);
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
