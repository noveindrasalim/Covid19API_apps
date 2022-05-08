import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vid1/section5/models/userModel.dart';

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

class HomePage extends StatelessWidget {
  List<UserModel> fullUser = [];
  Future getAllUsers() async {
    try {
      var users = await http.get(Uri.parse("https://reqres.in/api/users"));
      List data = (json.decode(users.body) as Map<String, dynamic>)["data"];
      data.forEach((element) {
        fullUser.add(UserModel.fromJson(element));
      });
    } catch (e) {
      print("Error kode ini adalah ${e}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Future Builder API"),
      ),
      body: FutureBuilder(
          future: getAllUsers(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Text("Loading..."),
              );
            } else {
              if (fullUser.length == 0) {
                Center(
                  child: Text("tidak ada data"),
                );
              }
              return ListView.builder(
                  itemCount: fullUser.length,
                  itemBuilder: ((context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage("${fullUser[index].avatar}"),
                      ),
                      title: Text(
                          "${fullUser[index].firstName} ${fullUser[index].lastName}"),
                      subtitle: Text("${fullUser[index].email}"),
                    );
                  }));
            }
          }),
    );
  }
}
