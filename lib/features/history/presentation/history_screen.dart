import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../core/constants/app_colors.dart';
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
  String? _errorMessage;
  List<SessionRecord> _sessions = [];
  String? _topHelpfulModeTitle;
  String _selectedStatus = 'all';

  @override
  void initState() {
    super.initState();
    _loadSessions();
  }

  Future<void> _loadSessions() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final results = await Future.wait<dynamic>([
        _sessionsRepository.fetchRecentSessions(
          limit: 30,
          status: _selectedStatus,
        ),
        _sessionsRepository.fetchTopHelpfulModeTitle(),
      ]);

      if (!mounted) return;

      setState(() {
        _sessions = results[0] as List<SessionRecord>;
        _topHelpfulModeTitle = results[1] as String?;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _isLoading = false;
        _errorMessage = 'Не удалось загрузить историю: $e';
      });
    }
  }

  Future<void> _changeFilter(String status) async {
    if (_selectedStatus == status) return;

    setState(() {
      _selectedStatus = status;
    });

    await _loadSessions();
  }

  Future<void> _openSession(SessionRecord session) async {
    await context.push(
      AppRoutes.intervention,
      extra: {
        'sessionId': session.id,
        'id': session.id,
        'title': session.modeTitle,
        'modeTitle': session.modeTitle,
        'sessionTitle': session.modeTitle,
        'type': session.modeKey,
        'sessionType': session.modeKey,
        'status': session.status,
        'stressLevel': session.stressLevel,
        'stressTitle': session.stressTitle,
        'source': session.source ?? 'history_screen',
        'note': session.note,
        'userNote': session.userNote,
        'createdAt': session.createdAt.toIso8601String(),
        'updatedAt': session.updatedAt?.toIso8601String(),
      },
    );

    if (!mounted) return;
    await _loadSessions();
  }

  @override
  Widget build(BuildContext context) {
    final completedCount =
        _sessions.where((s) => s.status == 'completed').length;
    final activeCount =
        _sessions
            .where((s) => s.status == 'started' || s.status == 'in_progress')
            .length;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
        child: SafeArea(
          child: RefreshIndicator(
            onRefresh: _loadSessions,
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
              children: [
                const Text(
                  'История',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Здесь показываются реальные sessions из Supabase: рекомендации, запуски, завершения и заметки.',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 18),
                _HistorySummaryCard(
                  totalCount: _sessions.length,
                  completedCount: completedCount,
                  activeCount: activeCount,
                  topHelpfulModeTitle: _topHelpfulModeTitle,
                ),
                const SizedBox(height: 18),
                _StatusFilters(
                  selectedStatus: _selectedStatus,
                  onChanged: _changeFilter,
                ),
                const SizedBox(height: 18),
                if (_isLoading)
                  const _InfoCard(
                    child: _CenteredInfoText('Загружаем историю...'),
                  )
                else if (_errorMessage != null)
                  _InfoCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const _CenteredInfoText('Не удалось загрузить данные'),
                        const SizedBox(height: 10),
                        Text(
                          _errorMessage!,
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColors.textSecondary,
                            height: 1.45,
                          ),
                        ),
                        const SizedBox(height: 14),
                        OutlinedButton(
                          onPressed: _loadSessions,
                          child: const Text('Повторить'),
                        ),
                      ],
                    ),
                  )
                else if (_sessions.isEmpty)
                  _InfoCard(
                    child: Text(
                      _selectedStatus == 'all'
                          ? 'Пока нет сохранённых sessions. Открой любой режим на главной, запусти сессию — и первая запись появится здесь.'
                          : 'Для фильтра "${_statusLabel(_selectedStatus)}" пока нет записей.',
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                        height: 1.5,
                      ),
                    ),
                  )
                else
                  ..._sessions.map(
                    (session) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _SessionTile(
                        session: session,
                        onTap: () => _openSession(session),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HistorySummaryCard extends StatelessWidget {
  const _HistorySummaryCard({
    required this.totalCount,
    required this.completedCount,
    required this.activeCount,
    required this.topHelpfulModeTitle,
  });

  final int totalCount;
  final int completedCount;
  final int activeCount;
  final String? topHelpfulModeTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.94),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFD7DED2).withValues(alpha: 0.14),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Сводка',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: _SummaryMetric(label: 'Всего', value: '$totalCount'),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _SummaryMetric(
                  label: 'Завершено',
                  value: '$completedCount',
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _SummaryMetric(label: 'Активные', value: '$activeCount'),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFF7F8F4),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Text(
              topHelpfulModeTitle == null
                  ? 'Пока нет завершённых сессий, чтобы определить самый полезный режим.'
                  : 'Самый частый завершённый режим: $topHelpfulModeTitle',
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
                height: 1.45,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryMetric extends StatelessWidget {
  const _SummaryMetric({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8F4),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusFilters extends StatelessWidget {
  const _StatusFilters({required this.selectedStatus, required this.onChanged});

  final String selectedStatus;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    const items = ['all', 'recommended', 'started', 'completed', 'cancelled'];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children:
          items.map((status) {
            final selected = selectedStatus == status;

            return FilterChip(
              selected: selected,
              onSelected: (_) => onChanged(status),
              label: Text(_statusLabel(status)),
              showCheckmark: false,
              selectedColor: const Color(0xFF2E3B2F),
              backgroundColor: Colors.white.withValues(alpha: 0.88),
              side: BorderSide(
                color:
                    selected
                        ? const Color(0xFF2E3B2F)
                        : const Color(0xFFE2E7DE),
              ),
              labelStyle: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: selected ? Colors.white : AppColors.textSecondary,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(999),
              ),
            );
          }).toList(),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(24),
      ),
      child: child,
    );
  }
}

class _CenteredInfoText extends StatelessWidget {
  const _CenteredInfoText(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        color: AppColors.textSecondary,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class _SessionTile extends StatelessWidget {
  const _SessionTile({required this.session, required this.onTap});

  final SessionRecord session;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final statusUi = _statusUi(session.status);

    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.94),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFD7DED2).withValues(alpha: 0.16),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        session.modeTitle,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: statusUi.background,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        statusUi.label,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: statusUi.foreground,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Состояние: ${session.stressTitle}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Источник: ${session.source ?? '—'}',
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textMuted,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Создано: ${_formatDate(session.createdAt)}',
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textMuted,
                  ),
                ),
                if (session.updatedAt != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    'Обновлено: ${_formatDate(session.updatedAt!)}',
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
                if ((session.userNote ?? '').trim().isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    'Твоя заметка: ${session.userNote}',
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                      height: 1.4,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  _StatusUi _statusUi(String status) {
    switch (status) {
      case 'started':
      case 'in_progress':
        return const _StatusUi(
          label: 'в процессе',
          background: Color(0xFFE8F1E4),
          foreground: Color(0xFF53724D),
        );
      case 'completed':
        return const _StatusUi(
          label: 'завершено',
          background: Color(0xFFE2F0EA),
          foreground: Color(0xFF3D6E5A),
        );
      case 'cancelled':
        return const _StatusUi(
          label: 'отменено',
          background: Color(0xFFF3E3E3),
          foreground: Color(0xFF8F5555),
        );
      case 'recommended':
      default:
        return const _StatusUi(
          label: 'рекомендовано',
          background: Color(0xFFF4EEDB),
          foreground: Color(0xFF7F6D3D),
        );
    }
  }

  static String _formatDate(DateTime dt) {
    final y = dt.year.toString().padLeft(4, '0');
    final m = dt.month.toString().padLeft(2, '0');
    final d = dt.day.toString().padLeft(2, '0');
    final hh = dt.hour.toString().padLeft(2, '0');
    final mm = dt.minute.toString().padLeft(2, '0');
    return '$d.$m.$y  $hh:$mm';
  }
}

class _StatusUi {
  final String label;
  final Color background;
  final Color foreground;

  const _StatusUi({
    required this.label,
    required this.background,
    required this.foreground,
  });
}

String _statusLabel(String status) {
  switch (status) {
    case 'all':
      return 'Все';
    case 'recommended':
      return 'Рекомендации';
    case 'started':
      return 'В процессе';
    case 'completed':
      return 'Завершённые';
    case 'cancelled':
      return 'Отменённые';
    default:
      return status;
  }
}
