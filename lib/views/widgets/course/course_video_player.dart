import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CourseVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final UniqueKey newKey;

  const CourseVideoPlayer(this.videoUrl, this.newKey) : super(key: newKey);

  @override
  _CourseVideoPlayerState createState() => _CourseVideoPlayerState();
}

class _CourseVideoPlayerState extends State<CourseVideoPlayer> {
  late VideoPlayerController _controller;
  late ChewieController chewieController;
  late Duration? position;
  bool _isLoading = true;

  void checkVideoPosition() {
    setState(() {
      position = _controller.value.position;
    });
  }

  @override
  void initState() {
    super.initState();
    initController();
    // print('course_video_player initState');
  }

  Future<void> initController() async {
    _controller =
        VideoPlayerController.network(widget.videoUrl, videoPlayerOptions: VideoPlayerOptions(mixWithOthers: false));
    await _controller.initialize();
    _controller.addListener(checkVideoPosition);

    chewieController = ChewieController(videoPlayerController: _controller, autoPlay: true, looping: false);
    setState(() => _isLoading = false);
  }

  @override
  void dispose() {
    _controller.dispose();
    chewieController.dispose();
    super.dispose();
    // print('*CourseVideoPlayer disposed');
  }

  @override
  Widget build(BuildContext context) {
    // print('*CourseVideoPlayer Build');
    return AspectRatio(
        aspectRatio: 16 / 9,
        // aspectRatio: _controller.value.aspectRatio,
        child: _isLoading ? Center(child: CircularProgressIndicator()) : Chewie(controller: chewieController));
  }
}
