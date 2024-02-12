

import 'package:flutter/material.dart';
import 'package:weatherforecasting/apicall/apirequest.dart';
import 'package:fl_chart/fl_chart.dart';

import 'main.dart';

List<String> days = [
  "Day 1",
  "Day 2",
  "Day 3",
  "Day 4",
  "Day 5",
  "Day 6",
  "Day 7",
];

class Visualize extends StatefulWidget {
  const Visualize({super.key});

  @override
  State<Visualize> createState() => _VisualizeState();
}

class _VisualizeState extends State<Visualize> {
  List Title = [ "Pressure","WindSpeed","Humidity", "Temperature" ];
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
            
            for (int i = 0; i < 4; i++) {
           
              List<FlSpot> chartData = [
                FlSpot(1, data[days[0]][0][i].toDouble()),
                FlSpot(2, data[days[1]][0][i].toDouble()),
                FlSpot(3, data[days[2]][0][i].toDouble()),
                FlSpot(4, data[days[3]][0][i].toDouble()),
                FlSpot(5, data[days[4]][0][i].toDouble()),
                FlSpot(6, data[days[5]][0][i].toDouble()),
                FlSpot(7, data[days[6]][0][i].toDouble()),
              ];
              chartDatas.add(chartData);
            }
            return Container(
              color: Colors.white,
              // padding: const EdgeInsets.all(10),
              width: double.infinity,
              height: double.infinity,
              child: Column(children: [
                Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(10),
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.9,
                    child: ListView.builder(
                        itemCount: 4,
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
                                      // maxX: 7,
                                      // maxY: 79,
                                      // minY: 78,
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
