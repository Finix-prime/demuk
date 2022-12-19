import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class autoPlayPicture extends StatefulWidget {
  const autoPlayPicture({super.key});

  @override
  State<autoPlayPicture> createState() => _autoPlayPictureState();
}

class _autoPlayPictureState extends State<autoPlayPicture> {
  List<String> img_url = [
    'https://cdn.pixabay.com/photo/2021/12/29/19/08/christmas-6902574_1280.jpg',
    'https://cdn.pixabay.com/photo/2022/11/08/06/26/woman-7577808_1280.jpg',
    'https://cdn.pixabay.com/photo/2022/12/12/12/58/dog-7651002_640.jpg',
    'https://cdn.pixabay.com/photo/2022/12/13/13/30/bird-7653386_640.jpg',
    'https://cdn.pixabay.com/photo/2022/12/10/11/05/snow-7646952_640.jpg'
  ];
  int i = 0;
  bool play = false;
  bool pause = false;
  bool stop = true;

  startPlay() {
    print(i.toString());
    Future.delayed(const Duration(seconds: 2), () {
      if (i < img_url.length - 1) {
        setState(() {
          i += 1;
        });
      } else {
        setState(() {
          i = 0;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (play == true) {
      startPlay();
      // startTimer();
    }
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Image.network(img_url[i]),
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.play_arrow,
                  size: 50,
                  color: play ? Colors.blue : Colors.black,
                ),
                onPressed: () {
                  setState(() {
                    play = true;
                    stop = false;
                  });
                  // startPlay();
                },
              ),
              const SizedBox(width: 20),
              IconButton(
                onPressed: () {
                  setState(() {
                    play = false;
                    stop = false;
                  });
                },
                icon: Icon(
                  Icons.pause,
                  size: 50,
                  color: play
                      ? Colors.black
                      : stop
                          ? Colors.black
                          : Colors.blue,
                ),
              ),
              const SizedBox(width: 20),
              IconButton(
                  onPressed: () {
                    dispose();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => autoPlayPicture()));
                    // setState(() {
                    //   play = false;
                    //   stop = true;
                    //   i = 0;
                    // });
                  },
                  icon: Icon(
                    Icons.stop,
                    size: 50,
                    color: stop ? Colors.blue : Colors.black,
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
