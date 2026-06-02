import '../data/models/biometrics_baseline.dart';
import '../data/models/stress_inference_result.dart';

class StressInferenceEngine {
  const StressInferenceEngine();

  StressInferenceResult evaluate({
    required int? heartRate,
    required double? hrv,
    required BiometricsBaseline? baseline,
  }) {
    if (heartRate == null) {
      return StressInferenceResult.fallback(
        score: 0,
        label: 'Нет данных',
        reasonCodes: const ['no_heart_rate'],
      );
    }

    final safeBaseline = baseline ?? BiometricsBaseline.empty();
    final hasReliableBaseline = safeBaseline.isReliable &&
        safeBaseline.restingHeartRate != null &&
        safeBaseline.restingHeartRate! > 0;

    if (!hasReliableBaseline) {
      return _fallbackFromAbsoluteHeartRate(
        heartRate: heartRate,
        hrv: hrv,
      );
    }

    final restingHeartRate = safeBaseline.restingHeartRate!;
    final deviationPercent =
        ((heartRate - restingHeartRate) / restingHeartRate) * 100;

    final hrvBaseline = safeBaseline.hrvBaseline;
    final hrvSuppressed = hrv != null &&
        hrvBaseline != null &&
        hrvBaseline > 0 &&
        hrv < (hrvBaseline * 0.8);

    int score;
    String label;

    if (deviationPercent >= 35 || heartRate >= restingHeartRate + 30) {
      score = 4;
      label = 'Критично';
    } else if (deviationPercent >= 20 || heartRate >= restingHeartRate + 18) {
      score = 3;
      label = 'Напряжение';
    } else if (deviationPercent >= 8 || heartRate >= restingHeartRate + 8) {
      score = 2;
      label = 'Норма';
    } else {
      score = 1;
      label = 'Спокойно';
    }

    if (hrvSuppressed && score < 4) {
      score += 1;
      label = _labelForScore(score);
    }

    final reasons = <String>[
      if (deviationPercent >= 35) 'hr_deviation_very_high',
      if (deviationPercent >= 20 && deviationPercent < 35) 'hr_deviation_high',
      if (deviationPercent >= 8 && deviationPercent < 20) 'hr_deviation_mild',
      if (hrvSuppressed) 'hrv_suppressed',
      if (score == 1) 'within_baseline',
    ];

    final confidence = hrvBaseline != null || hrv != null ? 0.82 : 0.72;

    return StressInferenceResult(
      score: score,
      label: label,
      confidence: confidence,
      deviationPercent: deviationPercent,
      elevatedHeartRate: deviationPercent >= 20,
      hrvSuppressed: hrvSuppressed,
      baselineUsed: true,
      reasonCodes: reasons,
    );
  }

  StressInferenceResult _fallbackFromAbsoluteHeartRate({
    required int heartRate,
    required double? hrv,
  }) {
    int score;
    String label;

    if (heartRate >= 110) {
      score = 4;
      label = 'Критично';
    } else if (heartRate >= 90) {
      score = 3;
      label = 'Напряжение';
    } else if (heartRate >= 75) {
      score = 2;
      label = 'Норма';
    } else {
      score = 1;
      label = 'Спокойно';
    }

    return StressInferenceResult(
      score: score,
      label: label,
      confidence: hrv != null ? 0.58 : 0.45,
      deviationPercent: 0,
      elevatedHeartRate: score >= 3,
      hrvSuppressed: false,
      baselineUsed: false,
      reasonCodes: const ['absolute_heart_rate_fallback'],
    );
  }

  String _labelForScore(int score) {
    switch (score) {
      case 4:
        return 'Критично';
      case 3:
        return 'Напряжение';
      case 2:
        return 'Норма';
      case 1:
      default:
        return 'Спокойно';
    }
  }
}