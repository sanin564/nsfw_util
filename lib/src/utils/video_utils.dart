import 'dart:io';
import 'dart:typed_data';

import 'package:video_compress/video_compress.dart';
import 'package:video_player/video_player.dart';

class VideoUtils {
  const VideoUtils._();

  static Future<List<Uint8List>> getVideoFrames(
    String videoPath, {
    int numberOfFrames = 5,
  }) async {
    final List<Uint8List> videoFrames = [];
    final controller = VideoPlayerController.file(File(videoPath));
    await controller.initialize();

    final dur = controller.value.duration.inMilliseconds;
    final interval = dur / numberOfFrames;

    for (int i = 0; i < numberOfFrames; i++) {
      final frame = await VideoCompress.getByteThumbnail(
        videoPath,
        quality: 50,
        position: (i * interval).toInt(),
      );
      if (frame != null) videoFrames.add(frame);
    }

    await controller.dispose();

    return videoFrames;
  }
}
