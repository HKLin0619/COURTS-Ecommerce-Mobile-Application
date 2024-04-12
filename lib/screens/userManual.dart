import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class UserManualWidget extends StatefulWidget {
  const UserManualWidget({Key? key}) : super(key: key);

  @override
  _UserManualWidgetState createState() => _UserManualWidgetState();
}

class _UserManualWidgetState extends State<UserManualWidget> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    );
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: false,
      looping: false,
    );
    _initializeVideoPlayer();
  }

  void _initializeVideoPlayer() async {
    await _videoPlayerController.initialize();
    setState(() {}); // Update the state to rebuild the widget
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_videoPlayerController.value.isInitialized) {
      return Scaffold(
        appBar: AppBar(
          title: Text('User Manual'),
          backgroundColor: Colors.amber,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_rounded),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Chewie(controller: _chewieController),
      );
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }
}
