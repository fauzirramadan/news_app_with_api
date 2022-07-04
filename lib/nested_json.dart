import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NestedJson extends StatefulWidget {
  const NestedJson({Key? key}) : super(key: key);

  @override
  State<NestedJson> createState() => _NestedJsonState();
}

class _NestedJsonState extends State<NestedJson> {
  // data from jsonPlaceholder website
  List listUser = [];
  bool isLoading = false;

  Future<List?> getData() async {
    try {
      setState(() {
        isLoading = true;
      });
      var res = await http
          .get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
      List data = jsonDecode(res.body);
      setState(() {
        isLoading = false;
        listUser = data;
        log('data user $listUser');
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: listUser.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    trailing: Text('${listUser[index]['address']['street']}'),
                    title: Text('${listUser[index]['name']}'),
                    subtitle: Text('${listUser[index]['username']}'),
                  ),
                );
              }),
    );
  }
}
