import 'package:flutter/foundation.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../domain/profile.dart';
import '../domain/user_context.dart';

class TrustedContactData {
  const TrustedContactData({
    required this.name,
    required this.phone,
    this.note,
  });

  final String name;
  final String phone;
  final String? note;

  bool get isComplete => name.trim().isNotEmpty && phone.trim().isNotEmpty;

  factory TrustedContactData.fromMap(Map<String, dynamic> map) {
    return TrustedContactData(
      name: (map['trusted_contact_name'] ?? '').toString().trim(),
      phone: (map['trusted_contact_phone'] ?? '').toString().trim(),
      note: (map['trusted_contact_note'] as String?)?.trim(),
    );
  }
}

class ProfileService {
  final SupabaseClient _client = Supabase.instance.client;

  Future<Profile?> fetchCurrentProfile() async {
    final user = _client.auth.currentUser;
    if (user == null) return null;

    final data = await _client
        .from('profiles')
        .select()
        .eq('id', user.id)
        .maybeSingle();

    if (data == null) return null;
    return Profile.fromMap(Map<String, dynamic>.from(data));
  }

  Future<Profile?> getMyProfile() async {
    return fetchCurrentProfile();
  }

  Future<Profile> updateName(String name) async {
    final user = _client.auth.currentUser;
    if (user == null) {
      throw StateError('Нет активной сессии');
    }

    final updated = await _client
        .from('profiles')
        .update({'name': name.trim()})
        .eq('id', user.id)
        .select()
        .single();

    return Profile.fromMap(Map<String, dynamic>.from(updated));
  }

  Future<Profile> updateAvatar(String avatarUrl) async {
    final user = _client.auth.currentUser;
    if (user == null) {
      throw StateError('Нет активной сессии');
    }

    final updated = await _client
        .from('profiles')
        .update({'avatar_url': avatarUrl.trim()})
        .eq('id', user.id)
        .select()
        .single();

    return Profile.fromMap(Map<String, dynamic>.from(updated));
  }

  Future<String?> getProfessionProfile() async {
    final user = _client.auth.currentUser;
    if (user == null) return null;

    final data = await _client
        .from('profiles')
        .select('profession_profile')
        .eq('id', user.id)
        .maybeSingle();

    if (data == null) return null;
    return data['profession_profile'] as String?;
  }

  Future<Profile> updateProfessionProfile(String professionProfile) async {
    final user = _client.auth.currentUser;
    if (user == null) {
      throw StateError('Нет активной сессии');
    }

    final updated = await _client
        .from('profiles')
        .upsert({
          'id': user.id,
          'profession_profile': professionProfile.trim(),
        })
        .select()
        .single();

    return Profile.fromMap(Map<String, dynamic>.from(updated));
  }

  Future<Profile> updatePersonalData({
    DateTime? birthDate,
    String? gender,
    String? city,
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
  }) async {
    final user = _client.auth.currentUser;
    if (user == null) {
      throw StateError('Нет активной сессии');
    }

    final normalizedEmergencyHelp = _normalizeEmergencyHelpPreference(
      emergencyHelpPreference,
    );

    debugPrint(
      'PROFILE SAVE raw emergencyHelpPreference=$emergencyHelpPreference',
    );
    debugPrint(
      'PROFILE SAVE normalized emergencyHelpPreference=$normalizedEmergencyHelp',
    );

    final updateData = <String, dynamic>{
      'id': user.id,
      'birth_date': birthDate != null ? _formatDateOnly(birthDate) : null,
      'gender': _trimOrNull(gender),
      'city': _trimOrNull(city),
      'occupation': _trimOrNull(occupation),
      'relationship_status': _trimOrNull(relationshipStatus),
      'has_children': hasChildren,
      'sleep_schedule': _trimOrNull(sleepSchedule),
      'stress_level': _normalizeScore(stressLevel),
      'energy_level': _normalizeScore(energyLevel),
      'goals': _trimOrNull(goals),
      'onboarding_completed': onboardingCompleted,
      'preferred_language': _trimOrNull(preferredLanguage),
      'timezone': _trimOrNull(timezone),
      'daily_routine': _trimOrNull(dailyRoutine),
      'energy_dip_time': _trimOrNull(energyDipTime),
      'session_length_preference': _trimOrNull(sessionLengthPreference),
      'support_style': _trimOrNull(supportStyle),
      'work_format': _trimOrNull(workFormat),
      'stress_triggers': _normalizeStringList(stressTriggers),
      'sleep_problems': _normalizeStringList(sleepProblems),
      'support_system_score': _normalizeScore(supportSystemScore),
      'self_regulation_experience': _trimOrNull(selfRegulationExperience),
      'emergency_help_preference': normalizedEmergencyHelp,
      'crisis_plan_enabled': crisisPlanEnabled,
    };

    debugPrint(
      'PROFILE SAVE payload=$updateData',
    );

    try {
      final updated = await _client
          .from('profiles')
          .upsert(updateData)
          .select()
          .single();

      debugPrint(
        'PROFILE SAVE success',
        );

      return Profile.fromMap(Map<String, dynamic>.from(updated));
    } catch (e, st) {
      debugPrint(
        'PROFILE SAVE failed: $e',
        );
      rethrow;
    }
  }

  Future<TrustedContactData?> fetchTrustedContact() async {
    final user = _client.auth.currentUser;
    if (user == null) return null;

    final data = await _client
        .from('profiles')
        .select(
          'trusted_contact_name, trusted_contact_phone, trusted_contact_note',
        )
        .eq('id', user.id)
        .maybeSingle();

    if (data == null) return null;

    final trustedContact = TrustedContactData.fromMap(
      Map<String, dynamic>.from(data),
    );
    if (!trustedContact.isComplete) return null;

    return trustedContact;
  }

  Future<TrustedContactData> saveTrustedContact({
    required String name,
    required String phone,
    String? note,
  }) async {
    final user = _client.auth.currentUser;
    if (user == null) {
      throw StateError('Нет активной сессии');
    }

    final normalizedName = name.trim();
    final normalizedPhone = phone.trim();
    final normalizedNote = note?.trim();

    if (normalizedName.isEmpty) {
      throw ArgumentError('Имя контакта не может быть пустым');
    }

    if (normalizedPhone.isEmpty) {
      throw ArgumentError('Телефон контакта не может быть пустым');
    }

    final updated = await _client
        .from('profiles')
        .upsert({
          'id': user.id,
          'trusted_contact_name': normalizedName,
          'trusted_contact_phone': normalizedPhone,
          'trusted_contact_note':
              normalizedNote != null && normalizedNote.isNotEmpty
                  ? normalizedNote
                  : null,
        })
        .select(
          'trusted_contact_name, trusted_contact_phone, trusted_contact_note',
        )
        .single();

    return TrustedContactData.fromMap(Map<String, dynamic>.from(updated));
  }

  Future<void> clearTrustedContact() async {
    final user = _client.auth.currentUser;
    if (user == null) {
      throw StateError('Нет активной сессии');
    }

    await _client.from('profiles').update({
      'trusted_contact_name': null,
      'trusted_contact_phone': null,
      'trusted_contact_note': null,
    }).eq('id', user.id);
  }

  Future<UserContext?> getUserContext() async {
    final profile = await fetchCurrentProfile();
    if (profile == null) return null;
    return UserContext.fromProfile(profile);
  }

  String? _trimOrNull(String? value) {
    final trimmed = value?.trim();
    if (trimmed == null || trimmed.isEmpty) return null;
    return trimmed;
  }

  int? _normalizeScore(int? value) {
    if (value == null) return null;
    if (value < 1) return 1;
    if (value > 10) return 10;
    return value;
  }

  List<String>? _normalizeStringList(List<String>? values) {
    if (values == null) return null;

    final normalized = values
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toSet()
        .toList();

    if (normalized.isEmpty) return <String>[];
    return normalized;
  }

  String? _normalizeEmergencyHelpPreference(String? value) {
    final normalized = _trimOrNull(value);
    if (normalized == null) return null;

    switch (normalized) {
      case 'self_help':
      case 'contact_person':
      case 'hotline':
      case 'depends':
        return normalized;

      case 'self_guided':
        return 'self_help';

      case 'call_close_one':
      case 'trusted_person':
      case 'contact_close_person':
      case 'contact_relative':
        return 'contact_person';

      case 'crisis_hotline':
      case 'hot_line':
      case 'call_hotline':
        return 'hotline';

      case 'mixed':
      case 'it_depends':
      case 'depends_on_situation':
        return 'depends';

      default:
        return normalized;
    }
  }

  String _formatDateOnly(DateTime value) {
    final year = value.year.toString().padLeft(4, '0');
    final month = value.month.toString().padLeft(2, '0');
    final day = value.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }
}