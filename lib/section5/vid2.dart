import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as httpRequest;

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
  late String dataUser;
  late String id;
  late String name;
  late String email;

  @override
  void initState() {
    dataUser = "Data anda";
    id = "Id anda = ";
    name = "Nama anda = ";
    email = "Email anda = ";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Api Request"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(id),
            Text(name),
            Text(email),
            Text(dataUser),
            ElevatedButton(
              onPressed: () async {
                var dataFull = await httpRequest.get(
                  Uri.parse("https://reqres.in/api/users/2"),
                );
                Map<String, dynamic> data =
                    json.decode(dataFull.body) as Map<String, dynamic>;
                if (dataFull.statusCode == 200) {
                  // data berhasil didapatkan
                  setState(() {
                    id = data["data"]["id"].toString();
                    name =
                        "${data['data']['first_name']} & ${data['data']['last_name']}"
                            .toString();
                    email = data["data"]['email'].toString();
                  });
                } else {
                  // data gagal didapatkan
                }
              },
              child: Text("Info data anda"),
            ),
          ],
        ),
      ),
    );
  }
}
