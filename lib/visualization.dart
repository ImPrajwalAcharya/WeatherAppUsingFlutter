import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weatherforecasting/apicall/apirequest.dart';
import 'package:fl_chart/fl_chart.dart';

class Visualize extends StatefulWidget {
  const Visualize({super.key});

  @override
  State<Visualize> createState() => _VisualizeState();
}

class _VisualizeState extends State<Visualize> {
  getdata() async {
    final variable = await fetchWeather();
    final res = jsonDecode(variable.body);
    return res["prediction"];
    // print(res.runtimeType);
    // print(res['prediction']);
  }

  List Title = [
    "Precipation",
    "Humidity",
    "Temperature",
    "Pressure",
    "WindSpeed"
  ];
  List chartDatas = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: getdata(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final data = (snapshot.data! as dynamic);
            for (int i = 0; i < 5; i++) {
              List<FlSpot> chartData = [
                FlSpot(1, data[i + 0].toDouble()),
                FlSpot(2, data[i + 5].toDouble()),
                FlSpot(3, data[i + 10].toDouble()),
                FlSpot(4, data[i + 15].toDouble()),
                FlSpot(5, data[i + 20].toDouble()),
                FlSpot(6, data[i + 25].toDouble()),
                FlSpot(7, data[i + 30].toDouble()),
                FlSpot(8, data[i + 35].toDouble()),
                FlSpot(9, data[i + 40].toDouble()),
                FlSpot(10, data[i + 45].toDouble()),
              ];
              chartDatas.add(chartData);
            }
            return Container(
              color: Colors.white,
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              height: double.infinity,
              child: Column(children: [
                Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(10),
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.9,
                    child: ListView.builder(
                        itemCount: 5,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.all(20),
                            color: Color.fromARGB(255, 117, 193, 91),
                            width: double.infinity,
                            height: 340,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    Title[index],
                                    style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  color: Colors.white,
                                  padding: const EdgeInsets.all(10),
                                  width: double.infinity,
                                  height: 250,
                                  child: LineChart(
                                    LineChartData(
                                      backgroundColor: Colors.white,
                                      clipData: FlClipData.none(),
                                      borderData: FlBorderData(show: true),
                                      lineBarsData: [
                                        LineChartBarData(
                                          spots: chartDatas[index],
                                          isCurved: true,
                                          barWidth: 3,
                                          color: Colors.blue,
                                        )
                                      ],
                                    ),
                                  ),
                                  // ),
                                )
                              ],
                            ),
                          );
                        }))
              ]),
            );
          }),
    );
  }
}
