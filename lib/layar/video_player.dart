import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayer extends StatefulWidget {
  final YoutubePlayerController controller;

  const VideoPlayer({Key key, this.controller}) : super(key: key);

  @override
  _VideoPlayerState createState() => _VideoPlayerState(controller);
}

class _VideoPlayerState extends State<VideoPlayer> {
  final YoutubePlayerController controller;

  _VideoPlayerState(this.controller);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          Center(
            child: YoutubePlayer(
              controller: controller,
              showVideoProgressIndicator: false,
            ),
          ),
          Positioned(
            top: 40.0,
            right: 20.0,
            child: IconButton(
              icon: Icon(
                EvaIcons.closeCircle,
                color: Colors.white,
                size: 30.0,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
    );
  }
}
