import 'package:weather/models/weatherApi_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'files/progress_indicator.dart';
import 'models/weatherapi_client_response.dart';
import 'package:flutter/services.dart';
import 'files/locations.dart';

void main() {
  runApp(const MyWeatherApp());
}

class MyWeatherApp extends StatefulWidget {
  const MyWeatherApp({Key? key}) : super(key: key);

  @override
  State<MyWeatherApp> createState() => _MyWeatherAppState();
}

class _MyWeatherAppState extends State<MyWeatherApp> {
  double? latitude;
  double? longitude;
  WeatherApiClient client = WeatherApiClient();
  Weather? data;

  Future<void> getData() async {
    Location getLocation = Location();
    await getLocation.locations();
    latitude = getLocation.latt;
    longitude = getLocation.long;
    data = await client.getUserDate(latitude, longitude);
  }

  Widget textWidget({final name, var fontweight, var fontsize}) {
    return Text(
      name.toString(),
      style: GoogleFonts.openSans(
        textStyle: TextStyle(
            fontSize: fontsize, fontWeight: fontweight, color: Colors.white),
      ),
    );
  }

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blue.shade300,
        appBar: AppBar(
          title: Text(
            '  Weather ⛅',
            style: GoogleFonts.sen(
              textStyle: const TextStyle(
                  fontSize: 25.0,
                  // fontWeight: FontWeight.w100,
                  color: Colors.white),
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.blue.shade300,
          elevation: 0,
        ),
        body: RefreshIndicator(
          displacement: 70.0,
          backgroundColor: Colors.blue.shade400,
          color: Colors.white10,
          onRefresh: () async {
            await Future.delayed(const Duration(milliseconds: 450));
            setState(() {});
          },
          child: FutureBuilder(
            future: getData(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return AlertDialog(
                  title: const Text('No Connection'),
                  titleTextStyle:
                      const TextStyle(fontSize: 20.0, letterSpacing: 1),
                  content: const Text(
                      'You are currently offline, please connect to internet. And check location Permissions of your device. '),
                  backgroundColor: Colors.blue,
                  contentTextStyle: const TextStyle(
                    fontSize: 16.0,
                  ),
                  icon: const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60.0,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        SystemNavigator.pop();
                      },
                      child: const Text(
                        'Exit',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                );
              }
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView(
                  children: [
                    // Container(
                    //   height: 60.0,
                    //   // margin: const EdgeInsets.only(
                    //   //     left: 15.0, right: 15.0, top: 25.0),
                    //   // padding: const EdgeInsets.only(
                    //   //     left: 15.0, right: 15.0, top: 25.0),
                    //   decoration: BoxDecoration(
                    //     color: Colors.blue.shade400,
                    //     borderRadius: BorderRadius.only(
                    //       bottomLeft: Radius.circular(30.0),
                    //       bottomRight: Radius.circular(30.0),
                    //     ),
                    //   ),
                    //   child: Center(
                    //     child: Text(
                    //       '  Weather ⛅',
                    //       style: GoogleFonts.sen(
                    //         textStyle: const TextStyle(
                    //             fontSize: 25.0,
                    //             // fontWeight: FontWeight.w100,
                    //             color: Colors.white),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      height: 200.0,
                      width: double.infinity,
                      child: Image.asset(
                        'assets/${data!.description}1.gif',
                        height: 150.0,
                        width: 200.0,
                      ),
                    ),
                    const SizedBox(
                      height: 50.0,
                    ),
                    Container(
                      height: 40.0,
                      margin: const EdgeInsets.only(
                          left: 15.0, right: 15.0, top: 25.0),
                      // padding: const  EdgeInsets.only(
                      //     left: 15.0, right: 15.0, top: 25.0),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade400,
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //

                          const Icon(
                            Icons.location_on,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 2.0,
                          ),
                          textWidget(
                              name: '${data!.cityname},',
                              fontsize: 18.0,
                              fontweight: FontWeight.w500),
                          const SizedBox(
                            width: 2.0,
                          ),
                          textWidget(
                              name: data!.country,
                              fontsize: 18.0,
                              fontweight: FontWeight.w500),
                          const SizedBox(
                            height: 10.0,
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          left: 15.0, right: 15.0, top: 25.0),
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15.0, top: 25.0),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade400,
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const SizedBox(
                                height: 10.0,
                              ),
                              textWidget(
                                  name: data!.description,
                                  fontsize: 18.0,
                                  fontweight: FontWeight.w500),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Image.asset(
                                'assets/${data!.description}.png',
                                height: 100.0,
                                width: 80.0,
                              ),
                              const SizedBox(
                                width: 2.0,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Column(
                            children: [
                              textWidget(
                                  name: data!.temp,
                                  fontsize: 65.0,
                                  fontweight: FontWeight.w500),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                '℃',
                                style: GoogleFonts.sen(
                                  textStyle: const TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          left: 15.0, right: 15.0, top: 15.0, bottom: 15.0),
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15.0, top: 15.0, bottom: 15.0),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade400,
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              textWidget(
                                  name: 'Sunrise',
                                  fontsize: 16.0,
                                  fontweight: FontWeight.w600),
                              Text(
                                DateFormat.jm().format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      data!.sunrise! * 1000,
                                      isUtc: false),
                                ),
                                style: GoogleFonts.sen(
                                  textStyle: const TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              textWidget(
                                  name: 'Sunset',
                                  fontsize: 16.0,
                                  fontweight: FontWeight.w600),
                              Text(
                                DateFormat.jm().format(
                                    DateTime.fromMillisecondsSinceEpoch(
                                        data!.sunset! * 1000,
                                        isUtc: false)),
                                style: GoogleFonts.sen(
                                  textStyle: const TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 250.0,
                      width: double.infinity,
                      margin: const EdgeInsets.only(
                          left: 15.0, right: 15.0, top: 25.0),
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15.0, top: 25.0),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade400,
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  textWidget(
                                      name: 'Feels like',
                                      fontsize: 16.0,
                                      fontweight: FontWeight.w600),
                                  const Icon(
                                    Icons.thermostat,
                                    color: Colors.white,
                                    size: 35.0,
                                  ),
                                  textWidget(
                                      name: ("${data!.feelslike} °c"),
                                      fontsize: 18.0,
                                      fontweight: FontWeight.w600),
                                ],
                              ),
                              Column(
                                children: [
                                  textWidget(
                                      name: 'Humidity',
                                      fontsize: 16.0,
                                      fontweight: FontWeight.w600),
                                  const Icon(
                                    Icons.water,
                                    color: Colors.white,
                                    size: 35.0,
                                  ),
                                  textWidget(
                                      name: ("${data!.humidity}%"),
                                      fontsize: 18.0,
                                      fontweight: FontWeight.w600),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  textWidget(
                                      name: 'Pressure',
                                      fontsize: 16.0,
                                      fontweight: FontWeight.w600),
                                  const Icon(
                                    Icons.compress,
                                    color: Colors.white,
                                    size: 35.0,
                                  ),
                                  textWidget(
                                      name: ("${data!.pressure} mbar"),
                                      fontsize: 18.0,
                                      fontweight: FontWeight.w600),
                                  const SizedBox(
                                    height: 15.0,
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  textWidget(
                                      name: 'Wind Speed',
                                      fontsize: 16.0,
                                      fontweight: FontWeight.w600),
                                  const Icon(
                                    Icons.air,
                                    color: Colors.white,
                                    size: 35.0,
                                  ),
                                  textWidget(
                                      name: ("${data!.windSpeed} m/s"),
                                      fontsize: 18.0,
                                      fontweight: FontWeight.w600),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 65.0,
                    ),
                  ],
                );
              }
              return const MyProgressindicator();
            },
          ),
        ),
      ),
    );
  }
}
