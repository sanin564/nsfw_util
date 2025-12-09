import 'dart:io';

class InferenceScore {
  final double nsfwScore;
  final double safeScore;
  final Map<String, double> labelScores;
  final File frame;

  InferenceScore({
    required this.nsfwScore,
    required this.safeScore,
    required this.labelScores,
    required this.frame,
  });
}
