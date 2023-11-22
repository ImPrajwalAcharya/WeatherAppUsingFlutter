import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weatherforecasting/apicall/apirequest.dart';
import 'package:intl/intl.dart';
import 'package:weatherforecasting/visualization.dart';

void main() async {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // getdata();
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Weather Forecasting',
      themeMode: ThemeMode.dark,
      theme: ThemeData.dark().copyWith(
          primaryColor: Colors.white,
          hintColor: Colors.white,
          textTheme:
              const TextTheme(subtitle1: TextStyle(color: Colors.white))),
      debugShowCheckedModeBanner: false,
      home: const MyHomepage(),
    );
  }
}

int selector = 0;
bool unit = true;

class MyHomepage extends StatefulWidget {
  const MyHomepage({super.key});

  @override
  State<MyHomepage> createState() => _MyHomepageState();
}

class _MyHomepageState extends State<MyHomepage> {
  getdata() async {
    final variable = await fetchWeather();
    final res = jsonDecode(variable.body);
    return res["prediction"];
    // print(res.runtimeType);
    // print(res['prediction']);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getdata(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Scaffold(
              floatingActionButton: FloatingActionButton(backgroundColor: Colors.blue,
                onPressed: (){
                  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const Visualize()),
  );
              },
              child: Text("Visualize", style: TextStyle(fontSize: 10, color: Colors.white),),),
              backgroundColor: const Color.fromARGB(255, 27, 37, 53),
              body: Stack(children: [
                Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("lib/assets/background.png"),
                          fit: BoxFit.cover)),
                ),
                Container(
                  height: Get.height,
                  width: Get.width,
                  color: const Color.fromARGB(255, 27, 37, 53).withOpacity(0.5),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 20),
                    child: Column(children: [
                      const SizedBox(
                        height: 50,
                      ),
                      const Text(
                        "Kathmandu",
                        style: TextStyle(fontSize: 50, color: Colors.white),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            unit = !unit;
                          });
                        },
                        child: unit
                            ? Text(
                                "${(((snapshot.data as dynamic)[selector + 2]*(9/5))+32).toStringAsFixed(2)}°F",
                                style: const TextStyle(
                                    fontSize: 50, color: Colors.white),
                              )
                            : Text(
                                "${(snapshot.data as dynamic)[selector + 2]}°C",
                                style: const TextStyle(
                                    fontSize: 50, color: Colors.white),
                              ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              const Text(
                                "Humidity",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                              Text(
                                "${(snapshot.data as dynamic)[selector + 1]} gm/kg",
                                style: const TextStyle(
                                    fontSize: 30, color: Colors.white),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              const Text(
                                "WindSpeed",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                              Text(
                                "${(snapshot.data as dynamic)[selector + 4]} m/s",
                                style: const TextStyle(
                                    fontSize: 30, color: Colors.white),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              const Text(
                                "Precipitation",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                              Text(
                                "${(snapshot.data as dynamic)[selector]} mm/hour",
                                style: const TextStyle(
                                    fontSize: 30, color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              (DateFormat("MMM, EEE, yyyy").format(
                                      DateTime(2023, 1, 2, 5, 0).add(
                                          Duration(hours: (selector ~/ 5)))))
                                  .toString(),
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              (DateFormat("hh:mm a").format(DateTime(2023, 1, 2, 5, 0)
                                      .add(Duration(hours: (selector ~/ 5)))))
                                  .toString(),
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 150,
                      ),
                      ClipRect(
                          child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blueAccent.withOpacity(0.5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                const Text(
                                  "Hourly Data",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Container(
                                  margin: const EdgeInsets.all(10),
                                  height: 1,
                                  width: Get.width,
                                  color: Colors.black,
                                ),
                                SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                        padding: const EdgeInsets.all(10),
                                        scrollDirection: Axis.horizontal,
                                        itemCount: 10,
                                        itemBuilder: ((context, index) {
                                          // print(snapshot.data);
                                          return InkWell(
                                            onTap: () {
                                              setState(() {
                                                selector = index * 5;
                                              });
                                            },
                                            child: ClipRect(
                                                child: BackdropFilter(
                                              filter: ImageFilter.blur(
                                                  sigmaX: 10.0, sigmaY: 10.0),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20,
                                                        vertical: 10),
                                                margin: const EdgeInsets.only(
                                                    right: 10),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: selector ~/ 5 == index
                                                      ? Colors.blueAccent
                                                      : Color.fromARGB(
                                                              255, 6, 28, 66)
                                                          .withOpacity(0.8),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      (DateFormat("hh a")
                                                              .format(DateTime(2023, 1, 2, 5, 0)
                                                                  .add(Duration(
                                                                      hours:
                                                                          index))))
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.white),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    const Icon(
                                                      Icons.cloud,
                                                      size: 40,
                                                    ),
                                                    const SizedBox(
                                                      height: 15,
                                                    ),
                                                    Text(
                                                      '${((snapshot.data as dynamic)[2 + index * 5])}°',
                                                      style: const TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )),
                                          );
                                          // return Text('');
                                        })))
                              ],
                            ),
                          ),
                        ),
                      ))
                    ]),
                  ),
                )
              ]),
            );
          }
        });
  }
}
