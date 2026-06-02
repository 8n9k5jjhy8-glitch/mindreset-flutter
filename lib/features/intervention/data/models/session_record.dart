class SessionRecord {
  const SessionRecord({
    required this.id,
    required this.userId,
    required this.modeKey,
    required this.modeTitle,
    required this.stressLevel,
    required this.stressTitle,
    required this.source,
    required this.status,
    required this.note,
    required this.userNote,
    required this.resultRating,
    required this.resultNote,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String userId;
  final String modeKey;
  final String modeTitle;
  final int stressLevel;
  final String stressTitle;
  final String? source;
  final String status;
  final String? note;
  final String? userNote;
  final String? resultRating;
  final String? resultNote;
  final DateTime createdAt;
  final DateTime? updatedAt;

  factory SessionRecord.fromMap(Map<String, dynamic> map) {
    return SessionRecord(
      id: (map['id'] ?? '') as String,
      userId: (map['user_id'] ?? '') as String,
      modeKey: (map['mode_key'] ?? '') as String,
      modeTitle: (map['mode_title'] ?? '') as String,
      stressLevel: (map['stress_level'] ?? 0) as int,
      stressTitle: (map['stress_title'] ?? '') as String,
      source: map['source'] as String?,
      status: (map['status'] ?? '') as String,
      note: map['note'] as String?,
      userNote: map['user_note'] as String?,
      resultRating: map['result_rating'] as String?,
      resultNote: map['result_note'] as String?,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt:
          map['updated_at'] != null
              ? DateTime.parse(map['updated_at'] as String)
              : null,
    );
  }

  Map<String, dynamic> toInsertMap() {
    return {
      'user_id': userId,
      'mode_key': modeKey,
      'mode_title': modeTitle,
      'stress_level': stressLevel,
      'stress_title': stressTitle,
      'source': source,
      'status': status,
      'note': note,
      'user_note': userNote,
      'result_rating': resultRating,
      'result_note': resultNote,
    };
  }

  SessionRecord copyWith({
    String? id,
    String? userId,
    String? modeKey,
    String? modeTitle,
    int? stressLevel,
    String? stressTitle,
    String? source,
    String? status,
    String? note,
    String? userNote,
    String? resultRating,
    String? resultNote,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return SessionRecord(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      modeKey: modeKey ?? this.modeKey,
      modeTitle: modeTitle ?? this.modeTitle,
      stressLevel: stressLevel ?? this.stressLevel,
      stressTitle: stressTitle ?? this.stressTitle,
      source: source ?? this.source,
      status: status ?? this.status,
      note: note ?? this.note,
      userNote: userNote ?? this.userNote,
      resultRating: resultRating ?? this.resultRating,
      resultNote: resultNote ?? this.resultNote,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
