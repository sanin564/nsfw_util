import 'dart:io';

import 'package:video_compress/video_compress.dart';
import 'package:video_player/video_player.dart';

class VideoUtils {
  const VideoUtils._();

  static Future<List<File>> getVideoFrames(
    String videoPath, {
    int numberOfFrames = 5,
  }) async {
    final List<File> frames = [];
    final controller = VideoPlayerController.file(File(videoPath));
    await controller.initialize();

    final dur = controller.value.duration.inMilliseconds;
    final interval = dur / numberOfFrames;

    for (int i = 0; i < numberOfFrames; i++) {
      final frame = await VideoCompress.getFileThumbnail(
        videoPath,
        quality: 50,
        position: (i * interval).toInt(),
      );
      frames.add(frame);
    }

    await controller.dispose();

    return frames;
  }
}
