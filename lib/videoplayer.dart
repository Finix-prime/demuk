import 'dart:math';

import 'package:demuk/videoplayerwidget.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class videoplayer extends StatefulWidget {
  const videoplayer({super.key});

  @override
  State<videoplayer> createState() => _videoplayerState();
}

class _videoplayerState extends State<videoplayer> {
  final List<String> _videoAssets = const [
    'assets/OfficialMV.mp4',
    'assets/Mutmee.mp4'
  ];
  VideoPlayerController? controller;
  int i = 0;

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    controller = VideoPlayerController.asset(_videoAssets[i])
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((_) {
        // controller!.addListener(() {
        //   if (controller!.value.position == controller!.value.duration) {
        //     // int nextIndex = (_videoAssets.indexOf(controller!.dataSource) + 1) %
        //     //     _videoAssets.length;
        //     i += 1;
        //     if (i > _videoAssets.length) {
        //       i = 0;
        //     }
        //     controller = VideoPlayerController.asset(_videoAssets[i]);
        //   }
        // });
        controller!.play();
      });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            VideoPlayerWidget(controller: controller),
            const SizedBox(height: 32),
            if (controller != null && controller!.value.isInitialized)
              CircleAvatar(
                backgroundColor: Colors.red,
                child: IconButton(
                    onPressed: () {
                      controller!.dispose();
                      startVideo();
                    },
                    icon: const Icon(
                      Icons.stop,
                      color: Colors.white,
                    )),
              )
          ],
        ),
      ),
    );
  }

  startVideo() {
    controller = VideoPlayerController.asset(_videoAssets[i])
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((_) {
        controller!.pause();
      });
  }
}
