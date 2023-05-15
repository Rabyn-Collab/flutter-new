import 'package:flutter/material.dart';
import 'package:pod_player/pod_player.dart';



class MealVideo extends StatefulWidget {
  final String url;

  MealVideo({required this.url});

  @override
  State<MealVideo> createState() => _MealVideoState();
}

class _MealVideoState extends State<MealVideo> {
  late final PodPlayerController controller;

  @override
  void initState() {
    controller = PodPlayerController(
        playVideoFrom: PlayVideoFrom.youtube(widget.url),
        podPlayerConfig: const PodPlayerConfig(
            autoPlay: true,
            isLooping: false,
            videoQualityPriority: [720, 1080]
        )
    )..initialise();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  PodVideoPlayer(controller: controller);
  }
}
