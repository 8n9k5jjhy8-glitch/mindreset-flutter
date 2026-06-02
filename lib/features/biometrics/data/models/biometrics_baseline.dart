class BiometricsBaseline {
  const BiometricsBaseline({
    required this.restingHeartRate,
    required this.hrvBaseline,
    required this.lastCalculatedAt,
    required this.sampleDays,
    required this.isReliable,
  });

  final int? restingHeartRate;
  final double? hrvBaseline;
  final DateTime? lastCalculatedAt;
  final int sampleDays;
  final bool isReliable;

  factory BiometricsBaseline.empty() {
    return const BiometricsBaseline(
      restingHeartRate: null,
      hrvBaseline: null,
      lastCalculatedAt: null,
      sampleDays: 0,
      isReliable: false,
    );
  }

  BiometricsBaseline copyWith({
    int? restingHeartRate,
    double? hrvBaseline,
    DateTime? lastCalculatedAt,
    int? sampleDays,
    bool? isReliable,
  }) {
    return BiometricsBaseline(
      restingHeartRate: restingHeartRate ?? this.restingHeartRate,
      hrvBaseline: hrvBaseline ?? this.hrvBaseline,
      lastCalculatedAt: lastCalculatedAt ?? this.lastCalculatedAt,
      sampleDays: sampleDays ?? this.sampleDays,
      isReliable: isReliable ?? this.isReliable,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'resting_heart_rate': restingHeartRate,
      'hrv_baseline': hrvBaseline,
      'last_calculated_at': lastCalculatedAt?.toIso8601String(),
      'sample_days': sampleDays,
      'is_reliable': isReliable,
    };
  }

  factory BiometricsBaseline.fromJson(Map<String, dynamic> json) {
    return BiometricsBaseline(
      restingHeartRate: (json['resting_heart_rate'] as num?)?.toInt(),
      hrvBaseline: (json['hrv_baseline'] as num?)?.toDouble(),
      lastCalculatedAt: json['last_calculated_at'] != null
          ? DateTime.tryParse(json['last_calculated_at'].toString())
          : null,
      sampleDays: (json['sample_days'] as num?)?.toInt() ?? 0,
      isReliable: json['is_reliable'] == true,
    );
  }
}