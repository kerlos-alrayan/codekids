import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CourseVideoScreen extends StatefulWidget {
  final String videoUrl;
  final String courseTitle;

  const CourseVideoScreen({
    super.key,
    required this.videoUrl,
    required this.courseTitle,
  });

  @override
  State<CourseVideoScreen> createState() => _CourseVideoScreenState();
}

class _CourseVideoScreenState extends State<CourseVideoScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
        _controller.play(); // يبدأ تلقائيًا
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildVideoPlayer() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: VideoPlayer(_controller),
          ),
        ),
        const SizedBox(height: 12),
        VideoProgressIndicator(
          _controller,
          allowScrubbing: true,
          colors: VideoProgressColors(
            playedColor: Colors.purple,
            backgroundColor: Colors.purple.shade100,
            bufferedColor: Colors.purple.shade300,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF5E4), // خلفية طفولية
      appBar: AppBar(
        backgroundColor: const Color(0xFFFD8A8A),
        title: Text(
          widget.courseTitle,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _controller.value.isInitialized
              ? _buildVideoPlayer()
              : const CircularProgressIndicator(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFA8D1D1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          size: 32,
          color: Colors.white,
        ),
      ),
    );
  }
}
