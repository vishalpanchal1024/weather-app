class Weather {
  String? cityname;
  double? temp;
  String? description;
  double? feelslike;
  int? humidity;
  int? pressure;
  double? windSpeed;
  int? sunrise;
  int? sunset;
  String? country;

  Weather(
      {this.cityname,
      this.temp,
      this.description,
      this.feelslike,
      this.humidity,
      this.pressure,
      this.windSpeed,
      this.sunrise,
      this.sunset,
      this.country});

  Weather.fromJson(Map<String, dynamic> json) {
    cityname = json['name'];
    temp = json['main']['temp'];
    description = json['weather'][0]['main'];
    feelslike = json['main']['feels_like'];
    humidity = json['main']['humidity'];
    pressure = json['main']['pressure'];
    windSpeed = json['wind']['speed'];
    sunrise = json['sys']['sunrise'];
    sunset = json['sys']['sunset'];
    country = json['sys']['country'];
  }
}
