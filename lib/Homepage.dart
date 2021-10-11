import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var data;

  @override
  void initState() {
    super.initState();
    this.getJSONdata();
  }

  Future<void> getJSONdata() async {
    var response = await http.get(Uri.parse(
        'https://api.apify.com/v2/key-value-stores/toDWvRj1JpTXiM8FF/records/LATEST?disableRedirect=true'));
    var result = jsonDecode(response.body);
    setState(() {
      data = result["regionData"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Covid19 App'),
        backgroundColor: Colors.tealAccent[700],
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  color: Colors.amber[100],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Text(
                          data[index]["region"],
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        padding: EdgeInsets.all(10),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              child: Text(
                                'Active',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              padding: EdgeInsets.only(
                                  top: 10, left: 30, bottom: 10, right: 10)),
                          Container(
                              child: Text(
                                data[index]["activeCases"].toString(),
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              ),
                              padding: EdgeInsets.only(
                                  top: 10, left: 10, bottom: 10, right: 40)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              child: Text(
                                'Recovered',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              padding: EdgeInsets.only(
                                  top: 10, left: 30, bottom: 10, right: 10)),
                          Container(
                              child: Text(
                                data[index]["newRecovered"].toString(),
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green),
                              ),
                              padding: EdgeInsets.only(
                                  top: 10, left: 10, bottom: 10, right: 40)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              child: Text(
                                'Total',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              padding: EdgeInsets.only(
                                  top: 10, left: 30, bottom: 10, right: 10)),
                          Container(
                              child: Text(
                                data[index]["totalInfected"].toString(),
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                              ),
                              padding: EdgeInsets.only(
                                  top: 10, left: 10, bottom: 10, right: 40)),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
