import 'dart:convert';
import 'package:demuk/auto_picture.dart';
import 'package:demuk/videoplayer.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  String url = "weather link api";

  List data = [];
  List<String> datetime = [];
  bool loadData = false;
  String? city;
  Map<String, dynamic>? response;

  String timeConvert(int stamp) {
    // int stamp = int.parse(timestamp);
    DateTime tm = DateTime.fromMillisecondsSinceEpoch(stamp * 1000);
    String time = DateFormat('EEE, dd/MM/yyyy, HH:mm').format(tm);
    return time;
  }

  getData() async {
    var res = await http.post(Uri.parse(url));
    response = jsonDecode(res.body);
    print(response.toString());
    print('*****************************************************************');
    print(response!.length);
    List listdata = response!['list'];
    print('*****************************************************************');
    print(listdata.length);
    city = response!['city']['name'];
    print(city);
    print(listdata.toString());
    // List<String> datetime = [];
    // listdata.forEach((element) {
    //   datetime.add(timeConvert(element['dt']));
    // });
    setState(() {
      data = listdata;
      loadData = true;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton.icon(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => autoPlayPicture()));
            },
            icon: const Icon(
              Icons.play_circle_outline,
              color: Colors.red,
            ),
            label: const Text(
              'picture play',
              style: TextStyle(color: Colors.red),
            ),
          ),
          TextButton.icon(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => videoplayer()));
              },
              icon: const Icon(
                Icons.play_circle_outline,
                color: Colors.white,
              ),
              label: const Text(
                'video player',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      'https://cdn.pixabay.com/photo/2017/01/16/19/40/mountains-1985027_1280.jpg'),
                  fit: BoxFit.cover),
            ),
          ),
          loadData
              ? Column(
                  children: [
                    Container(
                      height: 200,
                      // color: Colors.blue[200],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            city!,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 32,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${(data[0]['main']['temp'] - 273.15).toStringAsFixed(2)} °C',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 28,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                              'High:${(data[0]['main']['temp_max'] - 273.15).toStringAsFixed(2)} Low:${(data[0]['main']['temp_min'] - 273.15).toStringAsFixed(2)}'),
                          Text(
                              'lat:${response!['city']['coord']['lat']} lng:${response!['city']['coord']['lon']}'),
                          Text(
                              'population: ${response!['city']['population']} '),
                          Text('timezone:${response!['city']['timezone']}'),
                          Text(
                              'sunrise: ${(timeConvert(response!['city']['sunrise']).split(',')[2])} sunset: ${(timeConvert(response!['city']['sunset']).split(',')[2])}')
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              Container(
                                height: 150,
                                width: MediaQuery.of(context).size.width * 0.9,
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.5),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15))),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      //
                                      // data[index]['dt_txt'],
                                      timeConvert(data[index]['dt']),
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                    Text(
                                      'temperature : ${(data[index]['main']['temp'] - 273.15).toStringAsFixed(2)} °C',
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                    Text(
                                      'weather : ${data[index]['weather'][0]['description']}',
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                )
              : const CircularProgressIndicator(),
        ],
      ),
    );
  }
}
