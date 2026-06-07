import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/session_record.dart';

class SessionsRepository {
  SessionsRepository({SupabaseClient? client})
    : _client = client ?? Supabase.instance.client;

  final SupabaseClient _client;

  User? get _user => _client.auth.currentUser;

  Future<List<SessionRecord>> fetchRecentSessions({
    int limit = 20,
    String? status,
  }) async {
    final user = _user;
    if (user == null) return [];

    dynamic query = _client.from('sessions').select().eq('user_id', user.id);

    if (status != null && status.isNotEmpty && status != 'all') {
      query = query.eq('status', status);
    }

    final response = await query
        .order('created_at', ascending: false)
        .limit(limit);

    return (response as List)
        .map((e) => SessionRecord.fromMap(Map<String, dynamic>.from(e as Map)))
        .toList();
  }

  Future<SessionRecord?> fetchLatestSession() async {
    final items = await fetchRecentSessions(limit: 1);
    if (items.isEmpty) return null;
    return items.first;
  }

  Future<SessionRecord?> fetchSessionById(String sessionId) async {
    final user = _user;
    if (user == null) return null;

    final response =
        await _client
            .from('sessions')
            .select()
            .eq('id', sessionId)
            .eq('user_id', user.id)
            .maybeSingle();

    if (response == null) return null;

    return SessionRecord.fromMap(Map<String, dynamic>.from(response));
  }

  Future<String?> createSession({
    required String modeKey,
    required String modeTitle,
    required int stressLevel,
    required String stressTitle,
    String? source,
    String status = 'started',
    String? note,
  }) async {
    final user = _user;
    if (user == null) return null;

    final record = SessionRecord(
      id: '',
      userId: user.id,
      modeKey: modeKey,
      modeTitle: modeTitle,
      stressLevel: stressLevel,
      stressTitle: stressTitle,
      source: source,
      status: status,
      note: note,
      userNote: null,
      resultNote: null,
      resultRating: null,
      createdAt: DateTime.now(),
      updatedAt: null,
    );

    final response =
        await _client
            .from('sessions')
            .insert(record.toInsertMap())
            .select('id')
            .single();

    return response['id'] as String?;
  }

  Future<void> updateSessionStatus({
    required String sessionId,
    required String status,
    String? note,
  }) async {
    final user = _user;
    if (user == null) {
      throw StateError('User is not authenticated');
    }

    await _client
        .from('sessions')
        .update({'status': status, if (note != null) 'note': note})
        .eq('id', sessionId)
        .eq('user_id', user.id);
  }

  Future<void> saveUserNote({
    required String sessionId,
    required String userNote,
  }) async {
    final user = _user;
    if (user == null) {
      throw StateError('User is not authenticated');
    }

    await _client
        .from('sessions')
        .update({'user_note': userNote})
        .eq('id', sessionId)
        .eq('user_id', user.id);
  }

  Future<void> saveSessionResult({
    required String sessionId,
    required String resultNote,
    required String resultRating,
  }) async {
    final user = _user;
    if (user == null) {
      throw StateError('User is not authenticated');
    }

    await _client
        .from('sessions')
        .update({'result_note': resultNote, 'result_rating': resultRating})
        .eq('id', sessionId)
        .eq('user_id', user.id);
  }

  Future<String?> fetchTopHelpfulModeTitle() async {
    final user = _user;
    if (user == null) return null;

    final response = await _client
        .from('sessions')
        .select('mode_title, status')
        .eq('user_id', user.id)
        .eq('status', 'completed');

    final rows =
        (response as List)
            .map((e) => Map<String, dynamic>.from(e as Map))
            .toList();

    if (rows.isEmpty) return null;

    final counts = <String, int>{};

    for (final row in rows) {
      final modeTitle = row['mode_title'] as String?;
      if (modeTitle == null || modeTitle.isEmpty) continue;
      counts[modeTitle] = (counts[modeTitle] ?? 0) + 1;
    }

    if (counts.isEmpty) return null;

    final sorted =
        counts.entries.toList()..sort((a, b) => b.value.compareTo(a.value));

    return sorted.first.key;
  }
}
