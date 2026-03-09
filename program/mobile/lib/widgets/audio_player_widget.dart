import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';

class AudioPlayerWidget extends StatefulWidget {
  final String audioUrl;

  const AudioPlayerWidget({required this.audioUrl, super.key});

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  late final AudioPlayer _audioPlayer;
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    try {
      await _audioPlayer.setUrl(widget.audioUrl);
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _hasError = true;
      });
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  String _formatDuration(Duration? duration) {
    if (duration == null) return '0:00';
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds.remainder(60);
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_hasError) {
      return const Center(
        child: Text('تعذر تحميل الصوت'),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          StreamBuilder<Duration>(
            stream: _audioPlayer.positionStream,
            builder: (_, snapshot) {
              return ProgressBar(
                progress: snapshot.data ?? Duration.zero,
                total: _audioPlayer.duration ?? Duration.zero,
                buffered: _audioPlayer.bufferedPosition,
                onSeek: (duration) => _audioPlayer.seek(duration),
              );
            },
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.replay, size: 32),
                onPressed: () => _audioPlayer.seek(Duration.zero),
              ),
              const SizedBox(width: 16),
              StreamBuilder<PlayerState>(
                stream: _audioPlayer.playerStateStream,
                builder: (_, snapshot) {
                  final isPlaying = snapshot.data?.playing ?? false;
                  return FloatingActionButton(
                    heroTag: 'audio_play',
                    mini: false,
                    onPressed: () {
                      if (isPlaying) {
                        _audioPlayer.pause();
                      } else {
                        _audioPlayer.play();
                      }
                    },
                    child: Icon(
                      isPlaying ? Icons.pause : Icons.play_arrow,
                      size: 32,
                    ),
                  );
                },
              ),
              const SizedBox(width: 16),
              StreamBuilder<Duration>(
                stream: _audioPlayer.positionStream,
                builder: (_, snapshot) {
                  return Text(
                    '${_formatDuration(snapshot.data)} / ${_formatDuration(_audioPlayer.duration)}',
                    style: const TextStyle(fontSize: 14),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
