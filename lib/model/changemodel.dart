import 'package:flutter/material.dart';

import '../apicall/apirequest.dart';
import '../main.dart';

class ChangeModel extends StatefulWidget {
  const ChangeModel({super.key});

  @override
  State<ChangeModel> createState() => _ChangeModelState();
}

class _ChangeModelState extends State<ChangeModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose Model"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 27, 37, 53)
      ),
      body: Stack(children: [
        Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("lib/assets/background.png"),
                  fit: BoxFit.cover)),
        ),
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height*0.4,
          
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width * 0.5,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      modelno = 0;
                    });

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyHomepage()),
                    );
                  },
                  child: const Text("Single LSTM Model"),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width * 0.5,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      modelno = 1;
                    });

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyHomepage()),
                    );
                  },
                  child: const Text("Hybrid QLSTM Model"),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width * 0.5,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      modelno = 2;
                    });

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyHomepage()),
                    );
                  },
                  child: const Text("BILSTM Model"),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width * 0.5,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      modelno = 3;
                    });

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyHomepage()),
                    );
                  },
                  child: const Text("Stacked LSTM Model"),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
