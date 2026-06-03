import 'package:flutter/material.dart';
import 'package:mindreset_flutter/l10n/generated/app_localizations.dart';

import '../../intervention/data/models/session_record.dart';
import '../../intervention/data/repositories/sessions_repository.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final SessionsRepository _sessionsRepository = SessionsRepository();

  bool _isLoading = true;
  String? _error;
  List<SessionRecord> _sessions = const [];

  @override
  void initState() {
    super.initState();
    _loadSessions();
  }

  Future<void> _loadSessions() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final recent = await _sessionsRepository.fetchRecentSessions(limit: 200);

      if (!mounted) return;

      setState(() {
        _sessions = recent;
        _isLoading = false;
      });
    } catch (_) {
      if (!mounted) return;

      final l10n = AppLocalizations.of(context)!;
      setState(() {
        _error = l10n.historyLoadError;
        _isLoading = false;
      });
    }
  }

  List<SessionRecord> get _meaningfulSessions =>
      _sessions.where((s) => s.status != 'cancelled').toList();

  List<ModeHistoryGroup> get _groups {
    final Map<String, List<SessionRecord>> grouped = {};

    for (final session in _meaningfulSessions) {
      final key = session.modeKey.trim().isEmpty ? 'unknown' : session.modeKey;
      grouped.putIfAbsent(key, () => []).add(session);
    }

    final result = grouped.entries
        .map((entry) => ModeHistoryGroup.fromSessions(entry.key, entry.value))
        .toList();

    result.sort((a, b) {
      final byLastTime = b.lastCreatedAt.compareTo(a.lastCreatedAt);
      if (byLastTime != 0) return byLastTime;

      final byHelpfulCount = b.helpedRuns.compareTo(a.helpedRuns);
      if (byHelpfulCount != 0) return byHelpfulCount;

      final byCompletedRate = b.completedRate.compareTo(a.completedRate);
      if (byCompletedRate != 0) return byCompletedRate;

      final byCompletedCount = b.completedRuns.compareTo(a.completedRuns);
      if (byCompletedCount != 0) return byCompletedCount;

      return b.totalRuns.compareTo(a.totalRuns);
    });

    return result;
  }

  int get _totalLaunches => _meaningfulSessions.length;

  int get _fullyCompletedCount =>
      _meaningfulSessions.where((s) => s.status == 'completed').length;

  int get _helpedCount =>
      _meaningfulSessions.where((s) => s.resultRating == 'helped').length;

  String get _helpedDisplayValue {
    if (_meaningfulSessions.every((s) => s.resultRating == null)) return '-';
    return '$_helpedCount';
  }

  void _openModeDetails(ModeHistoryGroup group) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFFF7F4EF),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) => _ModeHistorySheet(group: group),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F6F1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          l10n.tabHistory,
          style: const TextStyle(
            color: Color(0xFF223127),
            fontSize: 22,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _loadSessions,
        child: _buildBody(l10n),
      ),
    );
  }

  Widget _buildBody(AppLocalizations l10n) {
    if (_isLoading) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: const [
          _SummarySkeleton(),
          SizedBox(height: 16),
          _HistorySkeleton(count: 4),
        ],
      );
    }

    if (_error != null) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          _ErrorCard(message: _error!),
        ],
      );
    }

    if (_groups.isEmpty) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          const _SummaryCard(
            totalLaunches: 0,
            fullyCompletedCount: 0,
            helpedDisplayValue: '-',
          ),
          const SizedBox(height: 16),
          _EmptyHistory(
            title: l10n.historyEmptyTitle,
            subtitle: l10n.historyEmptySubtitle,
          ),
        ],
      );
    }

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      children: [
        _SummaryCard(
          totalLaunches: _totalLaunches,
          fullyCompletedCount: _fullyCompletedCount,
          helpedDisplayValue: _helpedDisplayValue,
        ),
        const SizedBox(height: 16),
        _SectionIntro(title: l10n.historyUsedModesTitle),
        const SizedBox(height: 12),
        ..._groups.map(
          (group) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _ModeHistoryCard(
              group: group,
              onTap: () => _openModeDetails(group),
            ),
          ),
        ),
      ],
    );
  }
}

class ModeHistoryGroup {
  const ModeHistoryGroup({
    required this.modeKey,
    required this.totalRuns,
    required this.completedRuns,
    required this.helpedRuns,
    required this.activeRuns,
    required this.lastCreatedAt,
    required this.lastStressLevel,
    required this.lastStressTitleRaw,
    required this.sessions,
    required this.averageDuration,
  });

  final String modeKey;
  final int totalRuns;
  final int completedRuns;
  final int helpedRuns;
  final int activeRuns;
  final DateTime lastCreatedAt;
  final int lastStressLevel;
  final String lastStressTitleRaw;
  final List<SessionRecord> sessions;
  final Duration? averageDuration;

  double get completedRate {
    if (totalRuns == 0) return 0;
    return completedRuns / totalRuns;
  }

  factory ModeHistoryGroup.fromSessions(
    String modeKey,
    List<SessionRecord> sessions,
  ) {
    final sorted = [...sessions]
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    final latest = sorted.first;

    final completed = sorted.where((s) => s.status == 'completed').toList();
    final helped = sorted.where((s) => s.resultRating == 'helped').toList();
    final active = sorted
        .where((s) => s.status == 'started' || s.status == 'in_progress')
        .toList();

    final durations = sorted
        .map(_safeDurationFromSession)
        .whereType<Duration>()
        .toList();

    Duration? avg;
    if (durations.isNotEmpty) {
      final totalMs =
          durations.fold<int>(0, (sum, item) => sum + item.inMilliseconds);
      avg = Duration(milliseconds: totalMs ~/ durations.length);
    }

    return ModeHistoryGroup(
      modeKey: modeKey,
      totalRuns: sorted.length,
      completedRuns: completed.length,
      helpedRuns: helped.length,
      activeRuns: active.length,
      lastCreatedAt: latest.createdAt,
      lastStressLevel: latest.stressLevel,
      lastStressTitleRaw: latest.stressTitle,
      sessions: sorted,
      averageDuration: avg,
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.totalLaunches,
    required this.fullyCompletedCount,
    required this.helpedDisplayValue,
  });

  final int totalLaunches;
  final int fullyCompletedCount;
  final String helpedDisplayValue;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F3EE),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE7E2D9)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.historySummaryTitle,
            style: const TextStyle(
              color: Color(0xFF263126),
              fontSize: 17,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.historySummarySubtitle,
            style: const TextStyle(
              color: Color(0xFF6D756B),
              fontSize: 13,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _SummaryMetric(
                  value: '$totalLaunches',
                  label: l10n.historySummaryLaunches,
                  accent: const Color(0xFF80916E),
                  background: const Color(0xFFE8EEE5),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _SummaryMetric(
                  value: '$fullyCompletedCount',
                  label: l10n.historySummaryCompleted,
                  accent: const Color(0xFF5E8B72),
                  background: const Color(0xFFE4EFE8),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _SummaryMetric(
                  value: helpedDisplayValue,
                  label: l10n.historySummaryHelped,
                  accent: const Color(0xFFB88846),
                  background: const Color(0xFFF3EADF),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SummaryMetric extends StatelessWidget {
  const _SummaryMetric({
    required this.value,
    required this.label,
    required this.accent,
    required this.background,
  });

  final String value;
  final String label;
  final Color accent;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 104,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: accent,
              fontSize: 22,
              height: 1,
              fontWeight: FontWeight.w800,
            ),
          ),
          const Spacer(),
          Text(
            label,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Color(0xFF5F685D),
              fontSize: 11,
              height: 1.15,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionIntro extends StatelessWidget {
  const _SectionIntro({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF253126),
          fontSize: 15,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _ModeHistoryCard extends StatelessWidget {
  const _ModeHistoryCard({
    required this.group,
    required this.onTap,
  });

  final ModeHistoryGroup group;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Material(
      color: const Color(0xFFF8F8F5),
      borderRadius: BorderRadius.circular(22),
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: const BoxDecoration(
                  color: Color(0xFFE6EFE2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _iconForMode(group.modeKey),
                  color: const Color(0xFF6D806C),
                  size: 22,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _localizedModeTitle(context, group.modeKey),
                      style: const TextStyle(
                        color: Color(0xFF253126),
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      l10n.historyLastState(
                        _localizedStressTitle(
                          context,
                          level: group.lastStressLevel,
                          rawTitle: group.lastStressTitleRaw,
                        ),
                      ),
                      style: const TextStyle(
                        color: Color(0xFF70806E),
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _MetaPill(
                          text: l10n.historyRunsCount(group.totalRuns),
                          background: const Color(0xFFEFF2EC),
                          foreground: const Color(0xFF657262),
                        ),
                        _MetaPill(
                          text: l10n.historyCompletedRunsCount(
                            group.completedRuns,
                          ),
                          background: const Color(0xFFE4EFE8),
                          foreground: const Color(0xFF4D735E),
                        ),
                        if (group.helpedRuns > 0)
                          _MetaPill(
                            text: l10n.historyHelpedRunsCount(group.helpedRuns),
                            background: const Color(0xFFF3EADF),
                            foreground: const Color(0xFF9C753B),
                          ),
                        _MetaPill(
                          text: l10n.historyLastTime(
                            _formatDateTime(group.lastCreatedAt),
                          ),
                          background: const Color(0xFFF2EFE9),
                          foreground: const Color(0xFF7D786F),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l10n.historyCompletionRate(
                        _formatPercent(group.completedRate),
                      ),
                      style: const TextStyle(
                        color: Color(0xFF8A9386),
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (group.averageDuration != null) ...[
                      const SizedBox(height: 6),
                      Text(
                        l10n.historyAverageDuration(
                          _formatDuration(context, group.averageDuration!),
                        ),
                        style: const TextStyle(
                          color: Color(0xFF8A9386),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.chevron_right_rounded,
                color: Color(0xFF879083),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ModeHistorySheet extends StatelessWidget {
  const _ModeHistorySheet({required this.group});

  final ModeHistoryGroup group;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SafeArea(
      top: false,
      child: DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.82,
        minChildSize: 0.55,
        maxChildSize: 0.94,
        builder: (context, scrollController) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            child: Column(
              children: [
                Container(
                  width: 44,
                  height: 5,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD7DBD2),
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.92),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _localizedModeTitle(context, group.modeKey),
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF253126),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        l10n.historySheetRunsCompleted(
                          group.totalRuns,
                          group.completedRuns,
                        ),
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF6D756B),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        group.helpedRuns > 0
                            ? l10n.historySheetHelped(group.helpedRuns)
                            : l10n.historySheetHelpedNone,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF6D756B),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        l10n.historyCompletionRate(
                          _formatPercent(group.completedRate),
                        ),
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF6D756B),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (group.averageDuration != null) ...[
                        const SizedBox(height: 6),
                        Text(
                          l10n.historyAverageDuration(
                            _formatDuration(context, group.averageDuration!),
                          ),
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF6D756B),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: group.sessions.length,
                    itemBuilder: (context, index) {
                      final session = group.sessions[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: _SessionRunTile(session: session),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _SessionRunTile extends StatelessWidget {
  const _SessionRunTile({required this.session});

  final SessionRecord session;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final statusUi = _statusUi(context, session.status);
    final duration = _safeDurationFromSession(session);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _formatDateTime(session.createdAt),
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: Color(0xFF253126),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            l10n.historyStateLabel(
              _localizedStressTitle(
                context,
                level: session.stressLevel,
                rawTitle: session.stressTitle,
              ),
            ),
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF697567),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _MetaPill(
                text: statusUi.label,
                background: statusUi.background,
                foreground: statusUi.foreground,
              ),
              if (session.resultRating != null)
                _MetaPill(
                  text: _resultLabel(context, session.resultRating!),
                  background: _resultBackground(session.resultRating!),
                  foreground: _resultForeground(session.resultRating!),
                ),
              if (duration != null)
                _MetaPill(
                  text: l10n.historyDurationLabel(
                    _formatDuration(context, duration),
                  ),
                  background: const Color(0xFFF0EEE8),
                  foreground: const Color(0xFF7C776E),
                ),
            ],
          ),
          if ((session.resultNote ?? '').trim().isNotEmpty) ...[
            const SizedBox(height: 10),
            Text(
              l10n.historyResultLabel(session.resultNote!.trim()),
              style: const TextStyle(
                fontSize: 12,
                height: 1.4,
                color: Color(0xFF7A8477),
              ),
            ),
          ] else if ((session.note ?? '').trim().isNotEmpty) ...[
            const SizedBox(height: 10),
            Text(
              l10n.historyCommentLabel(session.note!.trim()),
              style: const TextStyle(
                fontSize: 12,
                height: 1.4,
                color: Color(0xFF7A8477),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _MetaPill extends StatelessWidget {
  const _MetaPill({
    required this.text,
    required this.background,
    required this.foreground,
  });

  final String text;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: foreground,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _StatusUi {
  const _StatusUi({
    required this.label,
    required this.background,
    required this.foreground,
  });

  final String label;
  final Color background;
  final Color foreground;
}

class _EmptyHistory extends StatelessWidget {
  const _EmptyHistory({
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE7ECE3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: Color(0xFF263126),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 13,
              height: 1.45,
              color: Color(0xFF71806F),
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorCard extends StatelessWidget {
  const _ErrorCard({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF6F6),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFF0D5D5)),
      ),
      child: Text(
        message,
        style: const TextStyle(
          fontSize: 14,
          color: Color(0xFF8A5F5F),
          height: 1.4,
        ),
      ),
    );
  }
}

class _SummarySkeleton extends StatelessWidget {
  const _SummarySkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 152,
      decoration: BoxDecoration(
        color: const Color(0xFFF1F3EE),
        borderRadius: BorderRadius.circular(24),
      ),
    );
  }
}

class _HistorySkeleton extends StatelessWidget {
  const _HistorySkeleton({this.count = 3});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        count,
        (index) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Container(
            height: 104,
            decoration: BoxDecoration(
              color: const Color(0xFFF4F5F2),
              borderRadius: BorderRadius.circular(22),
            ),
          ),
        ),
      ),
    );
  }
}

_StatusUi _statusUi(BuildContext context, String status) {
  final l10n = AppLocalizations.of(context)!;

  switch (status) {
    case 'completed':
      return _StatusUi(
        label: l10n.historyStatusCompleted,
        background: const Color(0xFFE2F0EA),
        foreground: const Color(0xFF44705D),
      );
    case 'started':
    case 'in_progress':
      return _StatusUi(
        label: l10n.historyStatusActive,
        background: const Color(0xFFE8F1E4),
        foreground: const Color(0xFF5D7E57),
      );
    default:
      return _StatusUi(
        label: l10n.historyStatusNoStatus,
        background: const Color(0xFFEEEFEA),
        foreground: const Color(0xFF727B71),
      );
  }
}

String _resultLabel(BuildContext context, String rating) {
  final l10n = AppLocalizations.of(context)!;

  switch (rating) {
    case 'helped':
      return l10n.historyResultHelped;
    case 'neutral':
      return l10n.historyResultNeutral;
    case 'not_helped':
      return l10n.historyResultNotHelped;
    default:
      return rating;
  }
}

Color _resultBackground(String rating) {
  switch (rating) {
    case 'helped':
      return const Color(0xFFF3EADF);
    case 'neutral':
      return const Color(0xFFEDEDE8);
    case 'not_helped':
      return const Color(0xFFF2E3E3);
    default:
      return const Color(0xFFEDEDE8);
  }
}

Color _resultForeground(String rating) {
  switch (rating) {
    case 'helped':
      return const Color(0xFF9C753B);
    case 'neutral':
      return const Color(0xFF6E746D);
    case 'not_helped':
      return const Color(0xFF9A5E5A);
    default:
      return const Color(0xFF6E746D);
  }
}

String _localizedModeTitle(BuildContext context, String modeKey) {
  final l10n = AppLocalizations.of(context)!;

  switch (modeKey) {
    case 'calm':
      return l10n.modeCalmTitle;
    case 'energy':
      return l10n.modeEnergyTitle;
    case 'sleep':
      return l10n.modeSleepTitle;
    case 'focus':
      return l10n.modeFocusTitle;
    case 'visual_contact':
      return l10n.modeVisualContactTitle;
    case 'trusted_contact':
      return l10n.modeTrustedContactTitle;
    case 'urgent_help':
      return l10n.modeUrgentHelp;
    case 'recovery':
      return l10n.modeRecovery;
    default:
      return 'MindReset AI';
  }
}

String _localizedStressTitle(
  BuildContext context, {
  required int level,
  required String rawTitle,
}) {
  final l10n = AppLocalizations.of(context)!;
  final normalized = rawTitle.trim().toLowerCase();

  switch (level) {
    case 1:
    case 2:
    case 3:
      return l10n.stateCalmTitle;
    case 4:
    case 5:
    case 6:
      return l10n.stateTenseTitle;
    case 7:
    case 8:
      return l10n.stateOverloadedTitle;
    case 9:
    case 10:
      return l10n.stateCriticalTitle;
  }

  if (normalized == 'calm' || normalized == 'спокойствие' || normalized == 'רוגע') {
    return l10n.stateCalmTitle;
  }
  if (normalized == 'tension' || normalized == 'напряжение' || normalized == 'מתח') {
    return l10n.stateTenseTitle;
  }
  if (normalized == 'overloaded' || normalized == 'перегрузка' || normalized == 'עומס') {
    return l10n.stateOverloadedTitle;
  }
  if (normalized == 'critical' || normalized == 'критическое' || normalized == 'קריטי') {
    return l10n.stateCriticalTitle;
  }
  if (normalized == 'manual mode selection' ||
      normalized == 'ручной выбор режима' ||
      normalized == 'בחירה ידנית של מצב') {
    return l10n.modesManualSelectionStressTitle;
  }

  return rawTitle;
}


IconData _iconForMode(String modeKey) {
  switch (modeKey) {
    case 'calm':
      return Icons.spa_rounded;
    case 'energy':
      return Icons.wb_sunny_rounded;
    case 'sleep':
      return Icons.nightlight_round;
    case 'focus':
      return Icons.adjust_rounded;
    case 'visual_contact':
      return Icons.videocam_rounded;
    case 'trusted_contact':
      return Icons.phone_in_talk_rounded;
    case 'urgent_help':
      return Icons.health_and_safety_rounded;
    case 'recovery':
      return Icons.favorite_rounded;
    default:
      return Icons.self_improvement_rounded;
  }
}

String _formatDateTime(DateTime value) {
  final local = value.toLocal();
  return '${_two(local.day)}.${_two(local.month)}.${local.year} • '
      '${_two(local.hour)}:${_two(local.minute)}';
}

String _formatDuration(BuildContext context, Duration duration) {
  final l10n = AppLocalizations.of(context)!;

  if (duration.inMinutes < 1) {
    return l10n.historySecondsShort(duration.inSeconds);
  }

  final hours = duration.inHours;
  final minutes = duration.inMinutes.remainder(60);

  if (hours > 0) {
    if (minutes == 0) return l10n.historyHoursShort(hours);
    return l10n.historyHoursMinutesShort(hours, minutes);
  }

  return l10n.historyMinutesShort(duration.inMinutes);
}

String _formatPercent(double value) {
  return '${(value * 100).round()}%';
}

Duration? _safeDurationFromSession(SessionRecord session) {
  final updatedAt = session.updatedAt;
  if (updatedAt == null) return null;
  if (session.status != 'completed') return null;
  if (updatedAt.isBefore(session.createdAt)) return null;

  final diff = updatedAt.difference(session.createdAt);

  if (diff.inSeconds <= 0) return null;
  if (diff > const Duration(hours: 3)) return null;

  return diff;
}

String _two(int value) => value.toString().padLeft(2, '0');
