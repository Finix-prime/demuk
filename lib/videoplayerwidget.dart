import 'package:demuk/BasicOverlayWidget.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatelessWidget {
  final VideoPlayerController? controller;
  const VideoPlayerWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return controller != null && controller!.value.isInitialized
        ? Column(
            children: [
              Container(
                alignment: Alignment.center,
                child: buildVideo(),
              ),
              // MaterialApp(
              //     home: Container(
              //   child: IconButton(
              //       onPressed: () {},
              //       icon: const Icon(
              //         Icons.stop,
              //         color: Colors.red,
              //       )),
              // ))
            ],
          )
        : Container(
            height: 200,
            child: CircularProgressIndicator(),
          );
  }

  Widget buildVideo() => Stack(
        children: [
          buildVideoPlayer(),
          Positioned.fill(child: BasicOverlayWidget(controller: controller!))
        ],
      );

  Widget buildVideoPlayer() => AspectRatio(
      aspectRatio: controller!.value.aspectRatio,
      child: VideoPlayer(controller!));
}
