import 'package:weather/models/weatherApi_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherApiClient {
  Future<Weather>? getUserDate(double? latitude, double? longitude) async {
    Uri url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=1a427759cc8aa79f89e48bf75ddd5af6&units=metric');
    var response = await http.get(url);

    var body = await jsonDecode(response.body);

    Weather users = Weather.fromJson(body);

    return users;
  }
}
