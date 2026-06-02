import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/mind_session.dart';

class SessionsRepository {
  SessionsRepository({SupabaseClient? client})
    : _client = client ?? Supabase.instance.client;

  final SupabaseClient _client;

  static const String _table = 'sessions';

  String get _currentUserId {
    final user = _client.auth.currentUser;
    if (user == null) {
      throw Exception('User is not authenticated');
    }
    return user.id;
  }

  Future<MindSession> startSession({
    required String modeKey,
    String? stateLabel,
    int? heartRate,
    String? notes,
  }) async {
    final row =
        await _client
            .from(_table)
            .insert({
              'user_id': _currentUserId,
              'mode_key': modeKey,
              'status': MindSessionStatus.started.asString,
              'state_label': stateLabel,
              'heart_rate': heartRate,
              'notes': notes,
              'started_at': DateTime.now().toIso8601String(),
            })
            .select()
            .single();

    return MindSession.fromMap(row);
  }

  Future<MindSession> completeSession({
    required String sessionId,
    int? heartRate,
    String? stateLabel,
    String? notes,
  }) async {
    final row =
        await _client
            .from(_table)
            .update({
              'status': MindSessionStatus.completed.asString,
              'completed_at': DateTime.now().toIso8601String(),
              'heart_rate': heartRate,
              'state_label': stateLabel,
              'notes': notes,
            })
            .eq('id', sessionId)
            .eq('user_id', _currentUserId)
            .select()
            .single();

    return MindSession.fromMap(row);
  }

  Future<MindSession> cancelSession({
    required String sessionId,
    int? heartRate,
    String? stateLabel,
    String? notes,
  }) async {
    final row =
        await _client
            .from(_table)
            .update({
              'status': MindSessionStatus.cancelled.asString,
              'completed_at': DateTime.now().toIso8601String(),
              'heart_rate': heartRate,
              'state_label': stateLabel,
              'notes': notes,
            })
            .eq('id', sessionId)
            .eq('user_id', _currentUserId)
            .select()
            .single();

    return MindSession.fromMap(row);
  }

  Future<MindSession?> fetchLatestSession() async {
    final rows = await _client
        .from(_table)
        .select()
        .eq('user_id', _currentUserId)
        .order('started_at', ascending: false)
        .limit(1);

    if (rows.isEmpty) {
      return null;
    }

    return MindSession.fromMap(rows.first);
  }

  Future<List<MindSession>> fetchSessions({int limit = 50}) async {
    final rows = await _client
        .from(_table)
        .select()
        .eq('user_id', _currentUserId)
        .order('started_at', ascending: false)
        .limit(limit);

    return rows.map<MindSession>((row) => MindSession.fromMap(row)).toList();
  }

  Future<List<MindSession>> fetchSessionsByStatus(
    MindSessionStatus status, {
    int limit = 50,
  }) async {
    final rows = await _client
        .from(_table)
        .select()
        .eq('user_id', _currentUserId)
        .eq('status', status.asString)
        .order('started_at', ascending: false)
        .limit(limit);

    return rows.map<MindSession>((row) => MindSession.fromMap(row)).toList();
  }

  Stream<List<MindSession>> watchSessions({int limit = 50}) {
    final userId = _currentUserId;

    return _client
        .from(_table)
        .stream(primaryKey: ['id'])
        .eq('user_id', userId)
        .order('started_at', ascending: false)
        .limit(limit)
        .map(
          (rows) =>
              rows.map<MindSession>((row) => MindSession.fromMap(row)).toList(),
        );
  }

  Stream<MindSession?> watchLatestSession() {
    return watchSessions(limit: 1).map((sessions) {
      if (sessions.isEmpty) return null;
      return sessions.first;
    });
  }
}
