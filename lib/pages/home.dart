import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/utils.dart';
import 'package:meteoapp/Model/meteoModel.dart';
import 'package:meteoapp/Services/services.dart';
import 'package:meteoapp/theme/appColors.dart';
import 'package:intl/intl.dart';
import 'package:meteoapp/theme/themeController.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  late WeatherData weatherInfo;
  bool isLoading = false;

  void _rechercheVille(String ville) {
    WeatherServices().fetchWeaterByName(ville).then((value) {
      setState(() {
        weatherInfo = value;
        isLoading = true;
      });
    });
  }

  myWeather() {
    isLoading = false;
    WeatherServices().fetchWeather().then((value) {
      setState(() {
        weatherInfo = value;
        isLoading = true;
      });
    });
  }

  final TextEditingController _controller = TextEditingController();
  void initState() {
    // TODO: implement initState

    // fetchWeaterByN(_controller.text);

    weatherInfo = WeatherData(
      name: '',
      temperature: Temperature(current: 0.0),
      humidity: 0,
      wind: Wind(speed: 0.0),
      maxTemperature: 0,
      minTemperature: 0,
      pressure: 0,
      seaLevel: 0,
      weather: [],
    );

    myWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat(
      'EEEE d, MMMM yyyy',
    ).format(DateTime.now());
    String formattedTime = DateFormat('hh:mm a').format(DateTime.now());
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 40,
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'Rechercher...',
              suffixIcon: IconButton(
                onPressed: () {
                  _rechercheVille(_controller.text);
                },
                icon: Icon(Icons.search),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Get.find<Themecontroller>().switchTheme();
          },
          icon: Icon(Icons.brightness_6),
        ),
      ),

      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 15),
          child: Center(
            child: Column(
              children: [
                isLoading
                    ? WeatherDetail(
                      weather: weatherInfo,
                      formattedDate: formattedDate,
                      formattedTime: formattedTime,
                    )
                    : CircularProgressIndicator(),
                // Text('Paris', style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WeatherDetail extends StatelessWidget {
  final WeatherData weather;
  final String formattedDate;
  final String formattedTime;
  const WeatherDetail({
    super.key,
    required this.weather,
    required this.formattedDate,
    required this.formattedTime,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // for current address name
        Text(
          weather.name,
          style: const TextStyle(
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        // for current temperature of my location
        Text(
          "${weather.temperature.current.toStringAsFixed(2)}°C",
          style: const TextStyle(
            fontSize: 40,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        // fpr weather condition
        if (weather.weather.isNotEmpty)
          Text(
            weather.weather[0].main,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        const SizedBox(height: 15),
        // for current date and time
        Text(
          formattedDate,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          formattedTime,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 15),
        Container(
          height: 150,
          width: 150,
          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/cloudy.png")),
          ),
        ),
        const SizedBox(height: 15),
        // for more weather detail
        Container(
          height: 220,
          decoration: BoxDecoration(
            color: Colors.deepPurple,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.wind_power, color: Colors.white),
                        const SizedBox(height: 5),
                        weatherInfoCard(
                          title: "Wind",
                          value: "${weather.wind.speed}km/h",
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.sunny, color: Colors.white),
                        const SizedBox(height: 5),
                        weatherInfoCard(
                          title: "Max",
                          value:
                              "${weather.maxTemperature.toStringAsFixed(2)}°C",
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.wind_power, color: Colors.white),
                        const SizedBox(height: 5),
                        weatherInfoCard(
                          title: "Min",
                          value:
                              "${weather.minTemperature.toStringAsFixed(2)}°C",
                        ),
                      ],
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.water_drop, color: Colors.amber),
                        const SizedBox(height: 5),
                        weatherInfoCard(
                          title: "Humidity",
                          value: "${weather.humidity}%",
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.air, color: Colors.amber),
                        const SizedBox(height: 5),
                        weatherInfoCard(
                          title: "Pressure",
                          value: "${weather.pressure}hPa",
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.leaderboard, color: Colors.amber),
                        const SizedBox(height: 5),
                        weatherInfoCard(
                          title: "Sea-Level",
                          value: "${weather.seaLevel}m",
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Column weatherInfoCard({required String title, required String value}) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
