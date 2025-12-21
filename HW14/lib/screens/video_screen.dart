import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> with SingleTickerProviderStateMixin {
  late VideoPlayerController _videoController;
  bool _isInitialized = false;
  bool _isPlaying = false;
  bool _isFullScreen = false;

  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _videoController = VideoPlayerController.asset('assets/video/video.mp4');

    _videoController.initialize().then((_) {
      if (!mounted) return;
      setState(() {
        _isInitialized = true;
      });
      _videoController.addListener(() {
        if (mounted) setState(() {});
      });
    }).catchError((error) {
      debugPrint('Video initialization error: $error');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Помилка завантаження відео: $error')),
        );
      }
    });
  }

  @override
  void dispose() {
    _videoController.removeListener(() {});
    _videoController.dispose();
    _animationController.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    super.dispose();
  }

  void _playPause() {
    setState(() {
      if (_videoController.value.isPlaying) {
        _videoController.pause();
        _isPlaying = false;
      } else {
        _videoController.play();
        _isPlaying = true;
      }
    });
  }

  void _seekForward() => _seek(const Duration(seconds: 10));
  void _seekBackward() => _seek(const Duration(seconds: -10));

  void _seek(Duration duration) {
    final position = _videoController.value.position;
    final newPosition = position + duration;
    final totalDuration = _videoController.value.duration;

    if (newPosition < Duration.zero) {
      _videoController.seekTo(Duration.zero);
    } else if (newPosition > totalDuration) {
      _videoController.seekTo(totalDuration);
    } else {
      _videoController.seekTo(newPosition);
    }
  }

  void _toggleFullScreen() {
    setState(() {
      _isFullScreen = !_isFullScreen;
    });

    if (_isFullScreen) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ]);
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isBuffering = _videoController.value.isBuffering;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _isFullScreen ? null : AppBar(title: const Text('Відтворення Відео')),
      body: SafeArea(
        top: !_isFullScreen,
        bottom: !_isFullScreen,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Center(
              child: _isInitialized
                  ? AspectRatio(
                aspectRatio: _videoController.value.aspectRatio,
                child: VideoPlayer(_videoController),
              )
                  : const Center(child: CircularProgressIndicator()),
            ),

            if (isBuffering && _isInitialized)
              const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white70),
                  strokeWidth: 6,
                ),
              ),

            if (_isInitialized) _buildControlsOverlay(),

            if (_isInitialized)
              Positioned(
                top: _isFullScreen ? 16 : 8,
                right: 16,
                child: IconButton(
                  icon: Icon(
                    _isFullScreen ? Icons.fullscreen_exit : Icons.fullscreen,
                    color: Colors.white,
                    size: 32,
                  ),
                  onPressed: _toggleFullScreen,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlsOverlay() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildProgressBar(),
          _buildControlButtons(),
        ],
      ),
    );
  }

  Widget _buildControlButtons() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _animatedButton(Icons.replay_10, _seekBackward),
          SizedBox(width: 6.w),
          _animatedButton(
            _isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
            _playPause,
            size: 64,
            color: Theme.of(context).colorScheme.primary,
          ),
          SizedBox(width: 6.w),
          _animatedButton(Icons.forward_10, _seekForward),
        ],
      ),
    );
  }

  Widget _animatedButton(
      IconData icon,
      VoidCallback onPressed, {
        double size = 48,
        Color? color,
      }) {
    return MouseRegion(
      onEnter: (_) => _animationController.forward(),
      onExit: (_) => _animationController.reverse(),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: IconButton(
          iconSize: size,
          icon: Icon(icon, color: color ?? Colors.white),
          onPressed: onPressed,
        ),
      ),
    );
  }

  Widget _buildProgressBar() {
    final position = _videoController.value.position;
    final duration = _videoController.value.duration;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
        children: [
          Slider(
            value: position.inMilliseconds.toDouble().clamp(0, duration.inMilliseconds.toDouble()),
            min: 0,
            max: duration.inMilliseconds.toDouble(),
            activeColor: Theme.of(context).colorScheme.primary,
            inactiveColor: Colors.grey.shade600,
            onChanged: (value) {
              _videoController.seekTo(Duration(milliseconds: value.toInt()));
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _formatDuration(position),
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
              Text(
                _formatDuration(duration),
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}