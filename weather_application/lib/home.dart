import 'package:flutter/material.dart';
import 'apiconnect.dart';
import 'charts.dart';

class HomePage extends StatefulWidget {
  final Function toggleTheme;
  final bool isDarkMode;

  HomePage({required this.toggleTheme, required this.isDarkMode});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _cityController = TextEditingController();
  String? _cityName;
  double? _temperature;
  String? _weatherDescription;
  bool _isLoading = false;
  String? _weatherIcon;

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  void _updateWeather(String cityName) async {
    setState(() {
      _isLoading = true;
    });
    try {
      var weatherData = await fetchWeather(cityName);
      setState(() {
        _cityName = weatherData['name'];
        _temperature = weatherData['main']['temp'];
        _weatherDescription = weatherData['weather'][0]['description'];
        _weatherIcon = weatherData['weather'][0]['icon'];
      });
    } catch (e) {
      // Handle error
      setState(() {
        _isLoading = false;
        _cityName = "City not found!";
        _temperature = null;
        _weatherDescription = null;
        _weatherIcon = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching weather: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget _weatherDisplay() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: MediaQuery
              .sizeOf(context)
              .height * 0.20,
          decoration: BoxDecoration(
            image: _weatherIcon != null
                ? DecorationImage(
              image: NetworkImage(
                  "http://openweathermap.org/img/wn/$_weatherIcon@4x.png"),
              fit: BoxFit.contain,
              onError: (error, stackTrace) {
                print('Error loading image: $error');
              },
            )
                : null,
          ),
          child: _weatherIcon == null
              ? Center(
            child: Icon(
              Icons.error_outline,
              size: 50,
              color: Colors.red,
            ),
          )
              : null,
        ),
        SizedBox(height: 10),
        Text(
          _weatherDescription ?? "No description available",
          style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontFamily: 'IndieFlower'
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(
                  widget.isDarkMode ? Icons.dark_mode : Icons.light_mode),
              onPressed: () {
                widget.toggleTheme();
              }
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(widget.isDarkMode
                    ? 'Assets/images/day_sky.jpg'
                    : 'Assets/images/night_sky.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          _isLoading
              ? Center(child: CircularProgressIndicator())
              : Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Enter City Name',
                    border: OutlineInputBorder(),
                  ),
                  onSubmitted: (value) {
                    _updateWeather(value);
                  },
                ),
                SizedBox(height: 20),
                _weatherDisplay(),
                if (_cityName != null &&
                    _temperature != null &&
                    _weatherDescription != null)
                  Column(
                    children: [
                      Text(
                        'Weather in $_cityName',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      Text(
                        'Temperature: $_temperature°C',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        'Description: $_weatherDescription',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                SizedBox(height: 20),
                if (_cityName != null)
                  Expanded(
                    child: WeatherChart(cityName: _cityName!),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
