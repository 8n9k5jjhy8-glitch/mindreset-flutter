import 'package:equatable/equatable.dart';

enum MindSessionStatus {
  started,
  completed,
  cancelled;

  static MindSessionStatus fromString(String value) {
    switch (value.toLowerCase()) {
      case 'started':
        return MindSessionStatus.started;
      case 'completed':
        return MindSessionStatus.completed;
      case 'cancelled':
        return MindSessionStatus.cancelled;
      default:
        return MindSessionStatus.started;
    }
  }

  String get asString {
    switch (this) {
      case MindSessionStatus.started:
        return 'started';
      case MindSessionStatus.completed:
        return 'completed';
      case MindSessionStatus.cancelled:
        return 'cancelled';
    }
  }
}

class MindSession extends Equatable {
  final String id;
  final String userId;
  final String modeKey;
  final MindSessionStatus status;
  final String? stateLabel;
  final int? heartRate;
  final String? notes;
  final DateTime startedAt;
  final DateTime? completedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  const MindSession({
    required this.id,
    required this.userId,
    required this.modeKey,
    required this.status,
    required this.startedAt,
    required this.createdAt,
    required this.updatedAt,
    this.stateLabel,
    this.heartRate,
    this.notes,
    this.completedAt,
  });

  MindSession copyWith({
    String? id,
    String? userId,
    String? modeKey,
    MindSessionStatus? status,
    String? stateLabel,
    int? heartRate,
    String? notes,
    DateTime? startedAt,
    DateTime? completedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return MindSession(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      modeKey: modeKey ?? this.modeKey,
      status: status ?? this.status,
      stateLabel: stateLabel ?? this.stateLabel,
      heartRate: heartRate ?? this.heartRate,
      notes: notes ?? this.notes,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory MindSession.fromMap(Map<String, dynamic> map) {
    return MindSession(
      id: map['id'] as String,
      userId: map['user_id'] as String,
      modeKey: map['mode_key'] as String,
      status: MindSessionStatus.fromString(map['status'] as String),
      stateLabel: map['state_label'] as String?,
      heartRate: map['heart_rate'] as int?,
      notes: map['notes'] as String?,
      startedAt: DateTime.parse(map['started_at'] as String),
      completedAt:
          map['completed_at'] != null
              ? DateTime.parse(map['completed_at'] as String)
              : null,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user_id': userId,
      'mode_key': modeKey,
      'status': status.asString,
      'state_label': stateLabel,
      'heart_rate': heartRate,
      'notes': notes,
      'started_at': startedAt.toIso8601String(),
      'completed_at': completedAt?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => <Object?>[
    id,
    userId,
    modeKey,
    status,
    stateLabel,
    heartRate,
    notes,
    startedAt,
    completedAt,
    createdAt,
    updatedAt,
  ];
}
