import 'dart:convert';

import 'package:flutter/material.dart';
import '../models/CovidModel.dart';
import '../widgets/cardwidgets.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatelessWidget {
  late CovidModel dataCovid;

  Future getDataCovid() async {
    try {
      var apiData = await http.get(Uri.parse("https://covid19.mathdro.id/api"));
      Map<String, dynamic> data =
          json.decode(apiData.body) as Map<String, dynamic>;

      dataCovid = CovidModel.fromJson(data);
      print(dataCovid);
    } catch (e) {
      print("Data Api gagal didapatkan ${e}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.person_rounded),
        centerTitle: true,
        title: Text("Covid 19 Cases"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.menu),
          ),
        ],
      ),
      body: FutureBuilder(
          future: getDataCovid(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Text("Loading ....."),
              );
            }
            return ListView(
              scrollDirection: Axis.vertical,
              children: [
                Container(
                  child: Column(
                    children: [
                      cardList("Confirmed", "${dataCovid.confirmed.value}",
                          Colors.red),
                      cardList(
                          "Deaths", "${dataCovid.deaths.value}", Colors.amber),
                      cardList("Recovered", "${dataCovid.recovered.value}",
                          Colors.green),
                      Container(
                        width: double.infinity,
                        height: 300,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage("${dataCovid.image}")),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}
