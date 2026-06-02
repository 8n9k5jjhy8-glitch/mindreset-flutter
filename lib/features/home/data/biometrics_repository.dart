import 'package:health/health.dart';

class BiometricsSnapshot {
  const BiometricsSnapshot({
    required this.heartRate,
    required this.recordedAt,
    required this.stateLabel,
    required this.stateScore,
    required this.isAvailable,
    required this.stressIndex,
    this.restingHeartRate,
    this.hrv,
    this.respiratoryRate,
    this.sleepQualityScore,
    this.wristTemperatureDelta,
    this.activityDeviationScore,
    this.historyScore = 0,
    this.availableMetrics = const <String>[],
  });

  final int? heartRate;
  final DateTime? recordedAt;
  final String stateLabel;
  final int stateScore;
  final bool isAvailable;

  final int stressIndex;
  final int? restingHeartRate;
  final double? hrv;
  final double? respiratoryRate;
  final int? sleepQualityScore;
  final double? wristTemperatureDelta;
  final int? activityDeviationScore;
  final int historyScore;
  final List<String> availableMetrics;

  factory BiometricsSnapshot.unavailable() {
    return const BiometricsSnapshot(
      heartRate: null,
      recordedAt: null,
      stateLabel: '',
      stateScore: 0,
      isAvailable: false,
      stressIndex: 0,
    );
  }
}

class BiometricsRepository {
  BiometricsRepository({Health? health}) : _health = health ?? Health();

  final Health _health;

  bool _authorizationChecked = false;
  bool _hasAuthorization = false;

  Future<BiometricsSnapshot> fetchLatestSnapshot() async {
    try {
      final authorized = await _ensureAuthorization();
      if (!authorized) {
        return BiometricsSnapshot.unavailable();
      }

      final now = DateTime.now();
      final shortRangeFrom = now.subtract(const Duration(hours: 6));
      final sleepRangeFrom = now.subtract(const Duration(hours: 24));

      final types = <HealthDataType>[
        HealthDataType.HEART_RATE,
        HealthDataType.RESTING_HEART_RATE,
        HealthDataType.HEART_RATE_VARIABILITY_SDNN,
        HealthDataType.RESPIRATORY_RATE,
        HealthDataType.STEPS,
      ];

      final sleepTypes = <HealthDataType>[
        HealthDataType.SLEEP_ASLEEP,
        HealthDataType.SLEEP_AWAKE,
        HealthDataType.SLEEP_DEEP,
        HealthDataType.SLEEP_REM,
        HealthDataType.SLEEP_LIGHT,
        HealthDataType.SLEEP_IN_BED,
      ];


      final rawData = await _health.getHealthDataFromTypes(
        types: types,
        startTime: shortRangeFrom,
        endTime: now,
      );

      List<HealthDataPoint> rawSleepData = <HealthDataPoint>[];
      try {
        rawSleepData = await _health.getHealthDataFromTypes(
          types: sleepTypes,
          startTime: sleepRangeFrom,
          endTime: now,
        );
      } catch (_) {
        rawSleepData = <HealthDataPoint>[];
      }

      final cleaned = _health.removeDuplicates(rawData);
      final cleanedSleep = _health.removeDuplicates(rawSleepData);

      final heartRatePoint = _latestPointOfType(cleaned, HealthDataType.HEART_RATE);
      final restingHeartRatePoint = _latestPointOfType(
        cleaned,
        HealthDataType.RESTING_HEART_RATE,
      );
      final hrvPoint = _latestPointOfType(
        cleaned,
        HealthDataType.HEART_RATE_VARIABILITY_SDNN,
      );
      final respiratoryPoint = _latestPointOfType(
        cleaned,
        HealthDataType.RESPIRATORY_RATE,
      );

      final heartRate = _extractNumericValue(heartRatePoint?.value)?.round();
      final restingHeartRate =
          _extractNumericValue(restingHeartRatePoint?.value)?.round();
      final hrv = _extractNumericValue(hrvPoint?.value);
      final respiratoryRate = _extractNumericValue(respiratoryPoint?.value);

      final stepsScore = _computeActivityDeviationScore(cleaned, now);
      final sleepScore = _computeSleepQualityScore(cleanedSleep, now);
      const wristTemperatureDelta = null;
      const historyScore = 0;

      final stressIndex = _computeStressIndex(
        heartRate: heartRate,
        restingHeartRate: restingHeartRate,
        hrv: hrv,
        respiratoryRate: respiratoryRate,
        sleepQualityScore: sleepScore,
        wristTemperatureDelta: wristTemperatureDelta,
        activityDeviationScore: stepsScore,
        historyScore: historyScore,
      );

      if (heartRate == null &&
          restingHeartRate == null &&
          hrv == null &&
          respiratoryRate == null &&
          sleepScore == null &&
          stepsScore == null) {
        return BiometricsSnapshot.unavailable();
      }

      final derivedState = _mapStressIndexToState(stressIndex);

      final recordedAtCandidates = <DateTime?>[
        heartRatePoint?.dateTo,
        restingHeartRatePoint?.dateTo,
        hrvPoint?.dateTo,
        respiratoryPoint?.dateTo,
      ]..removeWhere((item) => item == null);

      final recordedAt = recordedAtCandidates.isEmpty
          ? null
          : recordedAtCandidates.cast<DateTime>().reduce(
                (a, b) => a.isAfter(b) ? a : b,
              );

      final availableMetrics = <String>[
        if (heartRate != null) 'heartRate',
        if (restingHeartRate != null) 'restingHeartRate',
        if (hrv != null) 'hrv',
        if (respiratoryRate != null) 'respiratoryRate',
        if (sleepScore != null) 'sleepQualityScore',
        if (stepsScore != null) 'activityDeviationScore',
      ];

      return BiometricsSnapshot(
        heartRate: heartRate,
        recordedAt: recordedAt,
        stateLabel: derivedState.label,
        stateScore: derivedState.score,
        isAvailable: true,
        stressIndex: stressIndex,
        restingHeartRate: restingHeartRate,
        hrv: hrv,
        respiratoryRate: respiratoryRate,
        sleepQualityScore: sleepScore,
        wristTemperatureDelta: wristTemperatureDelta,
        activityDeviationScore: stepsScore,
        historyScore: historyScore,
        availableMetrics: availableMetrics,
      );
    } catch (_) {
      return BiometricsSnapshot.unavailable();
    }
  }

  Future<bool> _ensureAuthorization() async {
    if (_authorizationChecked) {
      return _hasAuthorization;
    }

    final types = <HealthDataType>[
      HealthDataType.HEART_RATE,
      HealthDataType.RESTING_HEART_RATE,
      HealthDataType.HEART_RATE_VARIABILITY_SDNN,
      HealthDataType.RESPIRATORY_RATE,
      HealthDataType.STEPS,
      HealthDataType.SLEEP_ASLEEP,
      HealthDataType.SLEEP_AWAKE,
      HealthDataType.SLEEP_DEEP,
      HealthDataType.SLEEP_REM,
      HealthDataType.SLEEP_LIGHT,
      HealthDataType.SLEEP_IN_BED,
    ];

    final permissions = List<HealthDataAccess>.filled(
      types.length,
      HealthDataAccess.READ,
    );

    try {
      _hasAuthorization =
          await _health.hasPermissions(types, permissions: permissions) ?? false;
    } catch (_) {
      _hasAuthorization = false;
    }

    if (!_hasAuthorization) {
      _hasAuthorization = await _health.requestAuthorization(
        types,
        permissions: permissions,
      );
    }

    _authorizationChecked = true;
    return _hasAuthorization;
  }

  HealthDataPoint? _latestPointOfType(
    List<HealthDataPoint> data,
    HealthDataType type,
  ) {
    final items = data
        .where((item) => item.type == type)
        .where((item) => _extractNumericValue(item.value) != null)
        .toList()
      ..sort((a, b) {
        final byDateTo = b.dateTo.compareTo(a.dateTo);
        if (byDateTo != 0) {
          return byDateTo;
        }
        return b.dateFrom.compareTo(a.dateFrom);
      });

    if (items.isEmpty) {
      return null;
    }

    return items.first;
  }

  double? _extractNumericValue(dynamic value) {
    if (value == null) {
      return null;
    }

    if (value is num) {
      return value.toDouble();
    }

    final raw = value.toString();
    final match = RegExp(r'(-?\d+(?:\.\d+)?)').firstMatch(raw);
    if (match == null) {
      return null;
    }

    return double.tryParse(match.group(1)!);
  }

  int _computeStressIndex({
    required int? heartRate,
    required int? restingHeartRate,
    required double? hrv,
    required double? respiratoryRate,
    required int? sleepQualityScore,
    required double? wristTemperatureDelta,
    required int? activityDeviationScore,
    required int historyScore,
  }) {
    final weightedScores = <double>[];
    final weights = <double>[];

    final hrvScore = _computeHrvScore(hrv);
    if (hrvScore != null) {
      weightedScores.add(hrvScore * 0.35);
      weights.add(0.35);
    }

    final rhrScore = _computeRestingHeartRateScore(
      restingHeartRate: restingHeartRate,
      currentHeartRate: heartRate,
    );
    if (rhrScore != null) {
      weightedScores.add(rhrScore * 0.20);
      weights.add(0.20);
    }

    final respScore = _computeRespiratoryScore(respiratoryRate);
    if (respScore != null) {
      weightedScores.add(respScore * 0.10);
      weights.add(0.10);
    }

    if (sleepQualityScore != null) {
      weightedScores.add(sleepQualityScore * 0.15);
      weights.add(0.15);
    }

    final wristTempScore = _computeWristTemperatureScore(wristTemperatureDelta);
    if (wristTempScore != null) {
      weightedScores.add(wristTempScore * 0.08);
      weights.add(0.08);
    }

    if (activityDeviationScore != null) {
      weightedScores.add(activityDeviationScore * 0.07);
      weights.add(0.07);
    }

    weightedScores.add(historyScore.clamp(0, 100) * 0.05);
    weights.add(0.05);

    if (weightedScores.isEmpty || weights.isEmpty) {
      return 0;
    }

    final totalWeight = weights.fold<double>(0, (sum, item) => sum + item);
    final totalScore =
        weightedScores.fold<double>(0, (sum, item) => sum + item);

    final normalized = (totalScore / totalWeight).round();
    return normalized.clamp(1, 100);
  }

  int? _computeHrvScore(double? hrv) {
    if (hrv == null) {
      return null;
    }

    if (hrv >= 70) {
      return 10;
    }
    if (hrv >= 55) {
      return 20;
    }
    if (hrv >= 40) {
      return 40;
    }
    if (hrv >= 28) {
      return 65;
    }
    if (hrv >= 20) {
      return 82;
    }
    return 95;
  }

  int? _computeRestingHeartRateScore({
    required int? restingHeartRate,
    required int? currentHeartRate,
  }) {
    final rhr = restingHeartRate ?? currentHeartRate;
    if (rhr == null) {
      return null;
    }

    if (rhr <= 60) {
      return 10;
    }
    if (rhr <= 70) {
      return 22;
    }
    if (rhr <= 80) {
      return 40;
    }
    if (rhr <= 90) {
      return 68;
    }
    if (rhr <= 100) {
      return 84;
    }
    return 95;
  }

  int? _computeRespiratoryScore(double? respiratoryRate) {
    if (respiratoryRate == null) {
      return null;
    }

    if (respiratoryRate <= 14) {
      return 10;
    }
    if (respiratoryRate <= 16) {
      return 20;
    }
    if (respiratoryRate <= 18) {
      return 40;
    }
    if (respiratoryRate <= 21) {
      return 65;
    }
    if (respiratoryRate <= 24) {
      return 82;
    }
    return 95;
  }

  int? _computeWristTemperatureScore(double? wristTemperatureDelta) {
    if (wristTemperatureDelta == null) {
      return null;
    }

    final absDelta = wristTemperatureDelta.abs();
    if (absDelta < 0.2) {
      return 10;
    }
    if (absDelta < 0.4) {
      return 28;
    }
    if (absDelta < 0.7) {
      return 52;
    }
    if (absDelta < 1.0) {
      return 74;
    }
    return 90;
  }

  int? _computeActivityDeviationScore(
    List<HealthDataPoint> data,
    DateTime now,
  ) {
    final dayStart = DateTime(now.year, now.month, now.day);
    final stepsToday = data
        .where((item) => item.type == HealthDataType.STEPS)
        .where((item) => item.dateTo.isAfter(dayStart))
        .map((item) => _extractNumericValue(item.value) ?? 0)
        .fold<double>(0, (sum, item) => sum + item);

    if (stepsToday <= 0) {
      return null;
    }

    if (stepsToday < 1500) {
      return 72;
    }
    if (stepsToday < 3000) {
      return 55;
    }
    if (stepsToday < 5000) {
      return 35;
    }
    if (stepsToday < 8000) {
      return 20;
    }
    return 12;
  }

  int? _computeSleepQualityScore(
    List<HealthDataPoint> sleepData,
    DateTime now,
  ) {
    if (sleepData.isEmpty) {
      return null;
    }

    final from = now.subtract(const Duration(hours: 24));
    final recentSleep = sleepData.where((item) => item.dateTo.isAfter(from)).toList();

    if (recentSleep.isEmpty) {
      return null;
    }

    double asleepMinutes = 0;
    double deepMinutes = 0;
    double remMinutes = 0;
    double awakeMinutes = 0;

    for (final item in recentSleep) {
      final minutes = item.dateTo.difference(item.dateFrom).inMinutes.toDouble();
      switch (item.type) {
        case HealthDataType.SLEEP_ASLEEP:
        case HealthDataType.SLEEP_LIGHT:
        case HealthDataType.SLEEP_IN_BED:
          asleepMinutes += minutes;
          break;
        case HealthDataType.SLEEP_DEEP:
          deepMinutes += minutes;
          asleepMinutes += minutes;
          break;
        case HealthDataType.SLEEP_REM:
          remMinutes += minutes;
          asleepMinutes += minutes;
          break;
        case HealthDataType.SLEEP_AWAKE:
          awakeMinutes += minutes;
          break;
        default:
          break;
      }
    }

    if (asleepMinutes <= 0) {
      return 85;
    }

    final totalSleepHours = asleepMinutes / 60.0;
    final deepRatio = deepMinutes / asleepMinutes;
    final remRatio = remMinutes / asleepMinutes;
    final awakePenalty = awakeMinutes >= 45 ? 18 : awakeMinutes >= 20 ? 10 : 0;

    var score = 0;

    if (totalSleepHours < 5) {
      score += 55;
    } else if (totalSleepHours < 6.5) {
      score += 35;
    } else if (totalSleepHours < 7.5) {
      score += 18;
    } else {
      score += 8;
    }

    if (deepRatio < 0.10) {
      score += 18;
    } else if (deepRatio < 0.16) {
      score += 10;
    } else {
      score += 4;
    }

    if (remRatio < 0.15) {
      score += 16;
    } else if (remRatio < 0.20) {
      score += 9;
    } else {
      score += 4;
    }

    score += awakePenalty;

    return score.clamp(5, 95);
  }

  DerivedState _mapStressIndexToState(int stressIndex) {
    if (stressIndex >= 75) {
      return const DerivedState(label: 'Высокий стресс', score: 4);
    }
    if (stressIndex >= 50) {
      return const DerivedState(label: 'Стресс', score: 3);
    }
    if (stressIndex >= 25) {
      return const DerivedState(label: 'Лёгкое напряжение', score: 2);
    }
    return const DerivedState(label: 'Спокойно', score: 1);
  }
}

class DerivedState {
  const DerivedState({
    required this.label,
    required this.score,
  });

  final String label;
  final int score;
}
