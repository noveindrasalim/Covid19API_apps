import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vid1/section5/vid2.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController nCont = TextEditingController();
  TextEditingController jCont = TextEditingController();
  String dataAkhir = "";

  @override
  void initState() {
    dataAkhir = "Data Anda adalah sebagai berikut";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post API"),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            controller: nCont,
            autocorrect: false,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              label: Text("Nama"),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: jCont,
            autocorrect: false,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              label: Text("Job"),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () async {
              var dataUser = await http.patch(
                  Uri.parse("https://reqres.in/api/users"),
                  body: {"name": nCont.text, "job": jCont.text});
              Map<String, dynamic> response =
                  json.decode(dataUser.body) as Map<String, dynamic>;

              setState(() {
                dataAkhir = "${response['name']} - ${response['job']}";
              });
            },
            child: Text("Submit"),
          ),
          SizedBox(
            height: 20,
          ),
          Divider(
            color: Colors.black,
          ),
          Text(dataAkhir),
        ],
      ),
    );
  }
}
