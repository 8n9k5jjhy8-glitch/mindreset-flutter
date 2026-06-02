import 'profile.dart';
import 'user_profession_profile.dart';

class UserContext {
  final UserProfessionProfile professionProfile;
  final int stressLevel;
  final int energyLevel;
  final String? sleepSchedule;
  final String? goals;
  final bool hasChildren;

  final String? occupation;
  final String? city;

  final String? preferredLanguage;
  final String? timezone;
  final String? dailyRoutine;
  final String? energyDipTime;
  final String? sessionLengthPreference;
  final String? supportStyle;
  final String? workFormat;
  final List<String> stressTriggers;
  final List<String> sleepProblems;
  final int supportSystemScore;
  final String? selfRegulationExperience;
  final String? emergencyHelpPreference;
  final bool crisisPlanEnabled;

  const UserContext({
    required this.professionProfile,
    required this.stressLevel,
    required this.energyLevel,
    this.sleepSchedule,
    this.goals,
    required this.hasChildren,
    this.occupation,
    this.city,
    this.preferredLanguage,
    this.timezone,
    this.dailyRoutine,
    this.energyDipTime,
    this.sessionLengthPreference,
    this.supportStyle,
    this.workFormat,
    this.stressTriggers = const [],
    this.sleepProblems = const [],
    this.supportSystemScore = 5,
    this.selfRegulationExperience,
    this.emergencyHelpPreference,
    this.crisisPlanEnabled = false,
  });

  factory UserContext.fromProfile(Profile profile) {
    return UserContext(
      professionProfile: profile.professionProfile != null
          ? UserProfessionProfileX.fromName(profile.professionProfile!)
          : UserProfessionProfile.student,
      stressLevel: _normalizeTenPoint(profile.stressLevel, fallback: 5),
      energyLevel: _normalizeTenPoint(profile.energyLevel, fallback: 5),
      sleepSchedule: _normalizeSleepSchedule(profile.sleepSchedule),
      goals: _normalizeNullable(profile.goals),
      hasChildren: profile.hasChildren ?? false,
      occupation: _normalizeNullable(profile.occupation),
      city: _normalizeNullable(profile.city),
      preferredLanguage: _normalizeNullable(profile.preferredLanguage),
      timezone: _normalizeNullable(profile.timezone),
      dailyRoutine: _normalizeNullable(profile.dailyRoutine),
      energyDipTime: _normalizeNullable(profile.energyDipTime),
      sessionLengthPreference:
          _normalizeNullable(profile.sessionLengthPreference),
      supportStyle: _normalizeNullable(profile.supportStyle),
      workFormat: _normalizeNullable(profile.workFormat),
      stressTriggers: _normalizeStringList(profile.stressTriggers),
      sleepProblems: _normalizeStringList(profile.sleepProblems),
      supportSystemScore:
          _normalizeTenPoint(profile.supportSystemScore, fallback: 5),
      selfRegulationExperience:
          _normalizeNullable(profile.selfRegulationExperience),
      emergencyHelpPreference:
          _normalizeNullable(profile.emergencyHelpPreference),
      crisisPlanEnabled: profile.crisisPlanEnabled ?? false,
    );
  }

  bool get isHighStress => stressLevel >= 7;

  bool get isLowEnergy => energyLevel <= 3;

  bool get hasUnstableSleep {
    switch (sleepSchedule) {
      case 'unstable':
      case 'shift':
        return true;
      default:
        return false;
    }
  }

  bool get hasSleepIssues => sleepProblems.isNotEmpty || hasUnstableSleep;

  bool get hasWeakSupportSystem => supportSystemScore <= 3;

  bool get prefersShortSessions => sessionLengthPreference == 'short';

  bool get prefersLongSessions => sessionLengthPreference == 'long';

  bool get prefersGentleTone =>
      supportStyle == 'gentle' || supportStyle == 'supportive';

  bool get prefersDirectTone =>
      supportStyle == 'direct' || supportStyle == 'structured';

  bool get isEarlyRoutine => dailyRoutine == 'early_bird';

  bool get isLateRoutine => dailyRoutine == 'night_owl';

  bool get worksInShifts =>
      workFormat == 'shift' || sleepSchedule == 'shift';

  bool get needsShortInterventions =>
      isHighStress ||
      isLowEnergy ||
      hasUnstableSleep ||
      hasChildren ||
      prefersShortSessions ||
      worksInShifts;

  String get recommendedInterventionDuration {
    if (prefersShortSessions) return 'short';
    if (needsShortInterventions) return 'short';
    if (prefersLongSessions) return 'long';
    if (energyLevel >= 7 && stressLevel <= 5) return 'long';
    return 'medium';
  }

  String get recommendedTone {
    if (isHighStress || prefersGentleTone) return 'calming';
    if (isLowEnergy) return 'energizing';
    if (prefersDirectTone) return 'direct';
    return 'balanced';
  }

  List<String> get preferredInterventionTypes {
    final types = <String>[];

    if (isHighStress) {
      types.addAll(['breathing', 'body_scan', 'grounding']);
    }

    if (isLowEnergy) {
      types.addAll(['movement', 'motivational', 'reset']);
    }

    if (hasSleepIssues) {
      types.addAll(['sleep_prep', 'relaxation', 'breathing']);
    }

    if (hasChildren) {
      types.addAll(['short_reset', 'micro_practice']);
    }

    if (hasWeakSupportSystem) {
      types.addAll(['self_support', 'grounding', 'check_in']);
    }

    if (stressTriggers.contains('work') || stressTriggers.contains('career')) {
      types.addAll(['desk_reset', 'clarity', 'breathing']);
    }

    if (stressTriggers.contains('family') ||
        stressTriggers.contains('relationships')) {
      types.addAll(['grounding', 'reflection', 'calming']);
    }

    if (stressTriggers.contains('sleep')) {
      types.addAll(['sleep_prep', 'evening_release']);
    }

    if (stressTriggers.contains('anxiety')) {
      types.addAll(['grounding', 'breathing', 'body_scan']);
    }

    switch (professionProfile) {
      case UserProfessionProfile.student:
        types.addAll(['focus_reset', 'study_break']);
        break;
      case UserProfessionProfile.officeWorker:
      case UserProfessionProfile.manager:
        types.addAll(['desk_reset', 'breathing', 'midday_reset']);
        break;
      case UserProfessionProfile.freelancer:
      case UserProfessionProfile.entrepreneur:
      case UserProfessionProfile.jobSeeker:
        types.addAll(['motivation', 'clarity', 'reset']);
        break;
      case UserProfessionProfile.caregiver:
        types.addAll(['micro_practice', 'calming', 'recovery']);
        break;
      case UserProfessionProfile.healthcareWorker:
      case UserProfessionProfile.militaryOrReservist:
      case UserProfessionProfile.policeOfficer:
      case UserProfessionProfile.firefighter:
      case UserProfessionProfile.driver:
        types.addAll(['decompression', 'grounding', 'after_shift_reset']);
        break;
      case UserProfessionProfile.other:
        types.addAll(['balanced', 'general_wellness']);
        break;
    }

    if (types.isEmpty) {
      types.addAll(['balanced', 'general_wellness']);
    }

    return types.toSet().toList(growable: false);
  }

  String get bestTimeOfDay {
    if (worksInShifts) return 'after_work_block';

    if (energyDipTime != null && energyDipTime!.isNotEmpty) {
      return energyDipTime!;
    }

    if (isEarlyRoutine) return 'morning';
    if (isLateRoutine) return 'evening';

    switch (professionProfile) {
      case UserProfessionProfile.student:
        return 'morning_or_afternoon';
      case UserProfessionProfile.officeWorker:
      case UserProfessionProfile.manager:
      case UserProfessionProfile.jobSeeker:
        return 'midday_or_evening';
      case UserProfessionProfile.freelancer:
      case UserProfessionProfile.entrepreneur:
        return 'flexible';
      case UserProfessionProfile.caregiver:
        return 'evening';
      case UserProfessionProfile.healthcareWorker:
      case UserProfessionProfile.militaryOrReservist:
      case UserProfessionProfile.policeOfficer:
      case UserProfessionProfile.firefighter:
      case UserProfessionProfile.driver:
        return 'after_work_block';
      case UserProfessionProfile.other:
        return 'midday_or_evening';
    }
  }

  static int _normalizeTenPoint(int? value, {required int fallback}) {
    if (value == null) return fallback;
    if (value < 1) return 1;
    if (value > 10) return 10;
    return value;
  }

  static String? _normalizeNullable(String? value) {
    final normalized = value?.trim();
    if (normalized == null || normalized.isEmpty) {
      return null;
    }
    return normalized;
  }

  static String? _normalizeSleepSchedule(String? value) {
    final normalized = _normalizeNullable(value);
    if (normalized == null) return null;

    switch (normalized) {
      case 'shifted':
        return 'shift';
      default:
        return normalized;
    }
  }

  static List<String> _normalizeStringList(List<String> values) {
    return values
        .map((item) => item.trim())
        .where((item) => item.isNotEmpty)
        .toSet()
        .toList(growable: false);
  }

  @override
  String toString() {
    return 'UserContext('
        'profession: ${professionProfile.name}, '
        'stress: $stressLevel, '
        'energy: $energyLevel, '
        'sleep: $sleepSchedule, '
        'goals: $goals, '
        'children: $hasChildren, '
        'occupation: $occupation, '
        'city: $city, '
        'preferredLanguage: $preferredLanguage, '
        'timezone: $timezone, '
        'dailyRoutine: $dailyRoutine, '
        'energyDipTime: $energyDipTime, '
        'sessionLengthPreference: $sessionLengthPreference, '
        'supportStyle: $supportStyle, '
        'workFormat: $workFormat, '
        'stressTriggers: $stressTriggers, '
        'sleepProblems: $sleepProblems, '
        'supportSystemScore: $supportSystemScore, '
        'selfRegulationExperience: $selfRegulationExperience, '
        'emergencyHelpPreference: $emergencyHelpPreference, '
        'crisisPlanEnabled: $crisisPlanEnabled, '
        'duration: $recommendedInterventionDuration, '
        'tone: $recommendedTone, '
        'bestTime: $bestTimeOfDay'
        ')';
  }
}