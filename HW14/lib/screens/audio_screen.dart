import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sizer/sizer.dart';

class AudioScreen extends StatefulWidget {
  const AudioScreen({super.key});

  @override
  State<AudioScreen> createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {
  late final AudioPlayer _player;
  bool _isLooping = true;

  final String trackTitle = 'Доброго вечора (We are from Ukraine)';
  final String artist = 'PROBASS ∆ HARDI';
  final String coverUrl = 'https://i.ytimg.com/vi/BvgNgTPTkSo/maxresdefault.jpg';
  final String audioUrl = 'https://ua-zvuk.net/uploads/files/2024-05/1716934100_probass-hardi-dobrogo-vechora.mp3';

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer()..setLoopMode(LoopMode.one);
    _player.setUrl(audioUrl);
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(title: const Text('Відтворення Аудіо')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
          child: Column(
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5.w),
                  child: Image.network(
                    coverUrl,
                    height: 33.h,
                    width: 33.h,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, progress) => progress == null
                        ? child
                        : Container(
                      height: 33.h,
                      width: 33.h,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade800,
                        borderRadius: BorderRadius.circular(5.w),
                      ),
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                    errorBuilder: (_, __, ___) => Container(
                      height: 33.h,
                      width: 33.h,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade800,
                        borderRadius: BorderRadius.circular(5.w),
                      ),
                      child: const Icon(Icons.audiotrack, size: 80, color: Colors.white54),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                trackTitle,
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 1.h),
              Text(
                artist,
                style: TextStyle(fontSize: 16.sp, color: Colors.white70),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 5.h),

              StreamBuilder<Duration?>(
                stream: _player.durationStream,
                builder: (context, durationSnap) {
                  final duration = durationSnap.data ?? Duration.zero;
                  return StreamBuilder<Duration>(
                    stream: _player.positionStream,
                    builder: (context, positionSnap) {
                      var position = positionSnap.data ?? Duration.zero;
                      if (position > duration) position = duration;

                      return Column(
                        children: [
                          Slider(
                            min: 0.0,
                            max: duration.inSeconds.toDouble().clamp(1.0, double.infinity),
                            value: position.inSeconds.toDouble().clamp(0.0, duration.inSeconds.toDouble()),
                            onChanged: (v) => _player.seek(Duration(seconds: v.toInt())),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(_formatDuration(position), style: TextStyle(fontSize: 16.sp)),
                                Text(_formatDuration(duration), style: TextStyle(fontSize: 16.sp)),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              SizedBox(height: 0.6.h),

              IntrinsicWidth(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        iconSize: 26.sp,
                        onPressed: () {
                          setState(() {
                            _isLooping = !_isLooping;
                            _player.setLoopMode(_isLooping ? LoopMode.one : LoopMode.off);
                          });
                        },
                        icon: Icon(
                          Icons.repeat,
                          color: _isLooping ? Theme.of(context).colorScheme.primary : Colors.white70,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      StreamBuilder<bool>(
                        stream: _player.playingStream,
                        builder: (context, snapshot) {
                          final playing = snapshot.data ?? false;
                          return IconButton(
                            iconSize: 36.sp,
                            onPressed: () => playing ? _player.pause() : _player.play(),
                            icon: Icon(
                              playing ? Icons.pause_circle_filled : Icons.play_circle_filled,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 2.h),

              Row(
                children: [
                  Icon(Icons.volume_up, size: 26.sp, color: Theme.of(context).colorScheme.primary,),
                  SizedBox(width: 4.w),
                  Expanded(
                    child: StreamBuilder<double>(
                      stream: _player.volumeStream,
                      builder: (context, snapshot) {
                        final volume = snapshot.data ?? 1.0;
                        return Slider(value: volume, onChanged: _player.setVolume);
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.h),
            ],
          ),
        ),
      ),
    );
  }
}