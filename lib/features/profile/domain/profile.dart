class Profile {
  final String id;
  final String? email;
  final String? name;
  final String? avatarUrl;
  final String? professionProfile;

  final DateTime? birthDate;
  final String? gender;
  final String? occupation;
  final String? relationshipStatus;
  final bool? hasChildren;
  final String? sleepSchedule;
  final int? stressLevel;
  final int? energyLevel;
  final String? goals;
  final bool? onboardingCompleted;

  final String? preferredLanguage;
  final String? timezone;
  final String? dailyRoutine;
  final String? energyDipTime;
  final String? sessionLengthPreference;
  final String? supportStyle;
  final String? workFormat;
  final List<String> stressTriggers;
  final List<String> sleepProblems;
  final int? supportSystemScore;
  final String? selfRegulationExperience;
  final String? emergencyHelpPreference;
  final bool? crisisPlanEnabled;

  /// Legacy transitional field.
  /// Keep temporarily until all old screens/user_context are migrated away from `city`.
  final String? city;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Profile({
    required this.id,
    this.email,
    this.name,
    this.avatarUrl,
    this.professionProfile,
    this.birthDate,
    this.gender,
    this.occupation,
    this.relationshipStatus,
    this.hasChildren,
    this.sleepSchedule,
    this.stressLevel,
    this.energyLevel,
    this.goals,
    this.onboardingCompleted,
    this.preferredLanguage,
    this.timezone,
    this.dailyRoutine,
    this.energyDipTime,
    this.sessionLengthPreference,
    this.supportStyle,
    this.workFormat,
    this.stressTriggers = const [],
    this.sleepProblems = const [],
    this.supportSystemScore,
    this.selfRegulationExperience,
    this.emergencyHelpPreference,
    this.crisisPlanEnabled,
    this.city,
    this.createdAt,
    this.updatedAt,
  });

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      id: (map['id'] ?? '').toString(),
      email: map['email'] as String?,
      name: map['name'] as String?,
      avatarUrl: map['avatar_url'] as String?,
      professionProfile: map['profession_profile'] as String?,
      birthDate: _parseDate(map['birth_date']),
      gender: map['gender'] as String?,
      occupation: map['occupation'] as String?,
      relationshipStatus: map['relationship_status'] as String?,
      hasChildren: map['has_children'] as bool?,
      sleepSchedule: map['sleep_schedule'] as String?,
      stressLevel: _parseInt(map['stress_level']),
      energyLevel: _parseInt(map['energy_level']),
      goals: map['goals'] as String?,
      onboardingCompleted: map['onboarding_completed'] as bool?,
      preferredLanguage: map['preferred_language'] as String?,
      timezone: map['timezone'] as String?,
      dailyRoutine: map['daily_routine'] as String?,
      energyDipTime: map['energy_dip_time'] as String?,
      sessionLengthPreference: map['session_length_preference'] as String?,
      supportStyle: map['support_style'] as String?,
      workFormat: map['work_format'] as String?,
      stressTriggers: _parseStringList(map['stress_triggers']),
      sleepProblems: _parseStringList(map['sleep_problems']),
      supportSystemScore: _parseInt(map['support_system_score']),
      selfRegulationExperience: map['self_regulation_experience'] as String?,
      emergencyHelpPreference: map['emergency_help_preference'] as String?,
      crisisPlanEnabled: map['crisis_plan_enabled'] as bool?,

      // Transitional compatibility for old UI/domain logic.
      city: map['city'] as String?,

      createdAt: _parseDateTime(map['created_at']),
      updatedAt: _parseDateTime(map['updated_at']),
    );
  }

  Map<String, dynamic> toUpdateMap() {
    final data = <String, dynamic>{};

    if (name != null) data['name'] = name;
    if (avatarUrl != null) data['avatar_url'] = avatarUrl;
    if (professionProfile != null) {
      data['profession_profile'] = professionProfile;
    }

    if (birthDate != null) {
      data['birth_date'] = _formatDateOnly(birthDate!);
    }

    if (gender != null) data['gender'] = gender;
    if (occupation != null) data['occupation'] = occupation;
    if (relationshipStatus != null) {
      data['relationship_status'] = relationshipStatus;
    }

    if (hasChildren != null) data['has_children'] = hasChildren;
    if (sleepSchedule != null) data['sleep_schedule'] = sleepSchedule;
    if (stressLevel != null) data['stress_level'] = stressLevel;
    if (energyLevel != null) data['energy_level'] = energyLevel;
    if (goals != null) data['goals'] = goals;
    if (onboardingCompleted != null) {
      data['onboarding_completed'] = onboardingCompleted;
    }

    if (preferredLanguage != null) {
      data['preferred_language'] = preferredLanguage;
    }

    if (timezone != null) data['timezone'] = timezone;
    if (dailyRoutine != null) data['daily_routine'] = dailyRoutine;
    if (energyDipTime != null) data['energy_dip_time'] = energyDipTime;

    if (sessionLengthPreference != null) {
      data['session_length_preference'] = sessionLengthPreference;
    }

    if (supportStyle != null) data['support_style'] = supportStyle;
    if (workFormat != null) data['work_format'] = workFormat;

    if (stressTriggers.isNotEmpty) {
      data['stress_triggers'] = stressTriggers;
    }

    if (sleepProblems.isNotEmpty) {
      data['sleep_problems'] = sleepProblems;
    }

    if (supportSystemScore != null) {
      data['support_system_score'] = supportSystemScore;
    }

    if (selfRegulationExperience != null) {
      data['self_regulation_experience'] = selfRegulationExperience;
    }

    /// ВАЖНО:
    /// намеренно НЕ отправляем emergency_help_preference из модели напрямую.
    /// Это поле должно идти только через ProfileService.updatePersonalData(),
    /// где оно нормализуется к одному из допустимых значений БД:
    /// self_help / contact_person / hotline / depends.
    ///
    /// if (emergencyHelpPreference != null) {
    ///   data['emergency_help_preference'] = emergencyHelpPreference;
    /// }

    if (crisisPlanEnabled != null) {
      data['crisis_plan_enabled'] = crisisPlanEnabled;
    }

    // Transitional compatibility only.
    if (city != null) data['city'] = city;

    return data;
  }

  Profile copyWith({
    String? id,
    String? email,
    String? name,
    String? avatarUrl,
    String? professionProfile,
    DateTime? birthDate,
    String? gender,
    String? occupation,
    String? relationshipStatus,
    bool? hasChildren,
    String? sleepSchedule,
    int? stressLevel,
    int? energyLevel,
    String? goals,
    bool? onboardingCompleted,
    String? preferredLanguage,
    String? timezone,
    String? dailyRoutine,
    String? energyDipTime,
    String? sessionLengthPreference,
    String? supportStyle,
    String? workFormat,
    List<String>? stressTriggers,
    List<String>? sleepProblems,
    int? supportSystemScore,
    String? selfRegulationExperience,
    String? emergencyHelpPreference,
    bool? crisisPlanEnabled,
    String? city,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Profile(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      professionProfile: professionProfile ?? this.professionProfile,
      birthDate: birthDate ?? this.birthDate,
      gender: gender ?? this.gender,
      occupation: occupation ?? this.occupation,
      relationshipStatus: relationshipStatus ?? this.relationshipStatus,
      hasChildren: hasChildren ?? this.hasChildren,
      sleepSchedule: sleepSchedule ?? this.sleepSchedule,
      stressLevel: stressLevel ?? this.stressLevel,
      energyLevel: energyLevel ?? this.energyLevel,
      goals: goals ?? this.goals,
      onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
      preferredLanguage: preferredLanguage ?? this.preferredLanguage,
      timezone: timezone ?? this.timezone,
      dailyRoutine: dailyRoutine ?? this.dailyRoutine,
      energyDipTime: energyDipTime ?? this.energyDipTime,
      sessionLengthPreference:
          sessionLengthPreference ?? this.sessionLengthPreference,
      supportStyle: supportStyle ?? this.supportStyle,
      workFormat: workFormat ?? this.workFormat,
      stressTriggers: stressTriggers ?? this.stressTriggers,
      sleepProblems: sleepProblems ?? this.sleepProblems,
      supportSystemScore: supportSystemScore ?? this.supportSystemScore,
      selfRegulationExperience:
          selfRegulationExperience ?? this.selfRegulationExperience,
      emergencyHelpPreference:
          emergencyHelpPreference ?? this.emergencyHelpPreference,
      crisisPlanEnabled: crisisPlanEnabled ?? this.crisisPlanEnabled,
      city: city ?? this.city,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  static DateTime? _parseDate(dynamic value) {
    if (value == null) return null;
    return DateTime.tryParse(value.toString());
  }

  static DateTime? _parseDateTime(dynamic value) {
    if (value == null) return null;
    return DateTime.tryParse(value.toString());
  }

  static int? _parseInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value.toString());
  }

  static List<String> _parseStringList(dynamic value) {
    if (value == null) return const [];

    if (value is List) {
      return value
          .map((item) => item?.toString().trim() ?? '')
          .where((item) => item.isNotEmpty)
          .toList(growable: false);
    }

    return const [];
  }

  static String _formatDateOnly(DateTime value) {
    final year = value.year.toString().padLeft(4, '0');
    final month = value.month.toString().padLeft(2, '0');
    final day = value.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }
}