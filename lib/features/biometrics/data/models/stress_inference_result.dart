class StressInferenceResult {
  const StressInferenceResult({
    required this.score,
    required this.label,
    required this.confidence,
    required this.deviationPercent,
    required this.elevatedHeartRate,
    required this.hrvSuppressed,
    required this.baselineUsed,
    required this.reasonCodes,
  });

  final int score;
  final String label;
  final double confidence;
  final double deviationPercent;
  final bool elevatedHeartRate;
  final bool hrvSuppressed;
  final bool baselineUsed;
  final List<String> reasonCodes;

  bool get isHighStress => score >= 3;

  Map<String, dynamic> toJson() {
    return {
      'score': score,
      'label': label,
      'confidence': confidence,
      'deviation_percent': deviationPercent,
      'elevated_heart_rate': elevatedHeartRate,
      'hrv_suppressed': hrvSuppressed,
      'baseline_used': baselineUsed,
      'reason_codes': reasonCodes,
    };
  }

  factory StressInferenceResult.fromJson(Map<String, dynamic> json) {
    return StressInferenceResult(
      score: (json['score'] as num?)?.toInt() ?? 0,
      label: json['label']?.toString() ?? 'Нет данных',
      confidence: (json['confidence'] as num?)?.toDouble() ?? 0,
      deviationPercent: (json['deviation_percent'] as num?)?.toDouble() ?? 0,
      elevatedHeartRate: json['elevated_heart_rate'] == true,
      hrvSuppressed: json['hrv_suppressed'] == true,
      baselineUsed: json['baseline_used'] == true,
      reasonCodes: (json['reason_codes'] as List?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
    );
  }

  factory StressInferenceResult.fallback({
    required int score,
    required String label,
    List<String> reasonCodes = const [],
  }) {
    return StressInferenceResult(
      score: score,
      label: label,
      confidence: 0.35,
      deviationPercent: 0,
      elevatedHeartRate: false,
      hrvSuppressed: false,
      baselineUsed: false,
      reasonCodes: reasonCodes,
    );
  }
}