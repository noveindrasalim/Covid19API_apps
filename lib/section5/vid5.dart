import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vid1/main.dart';
import 'package:http/http.dart' as http;

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
  String nama = "Nama anda adalah : ";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Delete API"),
        actions: [
          IconButton(
            onPressed: () async {
              var dataUser = await http.get(
                Uri.parse("https://reqres.in/api/users/2"),
              );
              Map<String, dynamic> dataFull = json.decode(dataUser.body);
              setState(() {
                nama = "nama anda adalah = ${dataFull['data']['first_name']}";
              });
            },
            icon: Icon(Icons.download),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Text(nama),
          ElevatedButton(
            onPressed: () async {
              var hapusData =
                  await http.delete(Uri.parse("https://reqres.in/api/users/2"));
              if (hapusData.statusCode == 204) {
                setState(() {
                  nama = "data berhasil dihapus";
                });
              } else {
                setState(() {
                  nama = "data gagal dihapus";
                });
              }
            },
            child: Text("Delete"),
          ),
        ],
      ),
    );
  }
}
