import 'package:flutter/foundation.dart';

@immutable
class HealthMetricPoint {
  const HealthMetricPoint({
    required this.typeKey,
    required this.label,
    required this.value,
    required this.unit,
    required this.recordedAt,
    required this.sourceName,
  });

  final String typeKey;
  final String label;
  final double? value;
  final String unit;
  final DateTime? recordedAt;
  final String? sourceName;

  bool get hasValue => value != null;

  String get formattedValue {
    if (value == null) return 'Нет данных';

    final v = value!;
    if (v == v.roundToDouble()) {
      return '${v.toInt()} $unit'.trim();
    }

    return '${v.toStringAsFixed(1)} $unit'.trim();
  }
}

@immutable
class HealthStateSnapshot {
  const HealthStateSnapshot({
    required this.isAvailable,
    required this.permissionGranted,
    required this.stateScore,
    required this.stateLabel,
    required this.summary,
    required this.lastUpdatedAt,
    required this.metrics,
    required this.availableMetricCount,
    required this.missingMetricCount,
  });

  final bool isAvailable;
  final bool permissionGranted;
  final int stateScore;
  final String stateLabel;
  final String summary;
  final DateTime? lastUpdatedAt;
  final List<HealthMetricPoint> metrics;
  final int availableMetricCount;
  final int missingMetricCount;

  HealthMetricPoint? metricByKey(String key) {
    try {
      return metrics.firstWhere((m) => m.typeKey == key);
    } catch (_) {
      return null;
    }
  }
}
