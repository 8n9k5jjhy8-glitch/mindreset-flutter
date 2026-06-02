import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../intervention/data/repositories/sessions_repository.dart';

class ModesScreen extends StatefulWidget {
  const ModesScreen({super.key, this.onBackToHome});

  final VoidCallback? onBackToHome;

  @override
  State<ModesScreen> createState() => _ModesScreenState();
}

class _ModesScreenState extends State<ModesScreen> {
  final SessionsRepository _sessionsRepository = SessionsRepository();

  String? _openingModeKey;

  bool _isOpening(String modeKey) => _openingModeKey == modeKey;

  Future<void> _openMode({
    required String modeKey,
    required String modeTitle,
    String? source,
    int stressLevel = 2,
    String stressTitle = 'Ручной выбор режима',
  }) async {
    if (_openingModeKey != null) return;

    setState(() => _openingModeKey = modeKey);

    try {
      final resolvedSource = source ?? 'modes_screen';

      final sessionId = await _sessionsRepository.createSession(
        modeKey: modeKey,
        modeTitle: modeTitle,
        stressLevel: stressLevel,
        stressTitle: stressTitle,
        source: resolvedSource,
        status: 'started',
      );

      if (!mounted) return;

      if (sessionId == null || sessionId.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Не удалось создать сессию. Попробуй ещё раз.'),
            behavior: SnackBarBehavior.floating,
          ),
        );
        return;
      }

      await context.push(
        AppRoutes.intervention,
        extra: {
          'sessionId': sessionId,
          'modeTitle': modeTitle,
          'source': resolvedSource,
          'stressLevel': stressLevel,
          'stressTitle': stressTitle,
          'status': 'started',
        },
      );

      if (!mounted) return;
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Не удалось открыть режим: $e'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _openingModeKey = null);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6F1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: widget.onBackToHome == null
            ? null
            : IconButton(
                onPressed: widget.onBackToHome,
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Color(0xFF223127),
                ),
              ),
        title: const Text(
          'Режимы',
          style: TextStyle(
            color: Color(0xFF223127),
            fontWeight: FontWeight.w800,
            fontSize: 22,
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          children: [
            const _TopInfoCard(),
            const SizedBox(height: 16),
            _ModeTile(
              title: 'Режим спокойствия',
              icon: Icons.spa_rounded,
              accent: const Color(0xFF80916E),
              background: const Color(0xFFE8EEE5),
              isLoading: _isOpening('calm'),
              onTap: () => _openMode(
                modeTitle: 'Режим спокойствия',
                modeKey: 'calm',
              ),
            ),
            const SizedBox(height: 14),
            _ModeTile(
              title: 'Нужна энергия',
              icon: Icons.wb_sunny_rounded,
              accent: const Color(0xFFB88846),
              background: const Color(0xFFF3EADF),
              isLoading: _isOpening('energy'),
              onTap: () => _openMode(
                modeTitle: 'Нужна энергия',
                modeKey: 'energy',
              ),
            ),
            const SizedBox(height: 14),
            _ModeTile(
              title: 'Подготовка ко сну',
              icon: Icons.nightlight_round,
              accent: const Color(0xFF7F8ABC),
              background: const Color(0xFFE7E9F4),
              isLoading: _isOpening('sleep'),
              onTap: () => _openMode(
                modeTitle: 'Подготовка ко сну',
                modeKey: 'sleep',
              ),
            ),
            const SizedBox(height: 14),
            _ModeTile(
              title: 'Хочу сфокусироваться',
              icon: Icons.adjust_rounded,
              accent: const Color(0xFF6A8B98),
              background: const Color(0xFFE3EEF1),
              isLoading: _isOpening('focus'),
              onTap: () => _openMode(
                modeTitle: 'Хочу сфокусироваться',
                modeKey: 'focus',
              ),
            ),
            const SizedBox(height: 14),
            _ModeTile(
              title: 'Визуальный контакт с AI',
              subtitle:
                  'Открой разговор с AI-человеком в формате визуального контакта.',
              icon: Icons.videocam_rounded,
              accent: const Color(0xFF7B69A7),
              background: const Color(0xFFECE7F5),
              isLoading: _isOpening('visual_contact'),
              onTap: () => _openMode(
                modeTitle: 'Визуальный контакт с AI',
                modeKey: 'visual_contact',
              ),
            ),
            const SizedBox(height: 14),
            _ModeTile(
              title: 'Связь с близким человеком',
              subtitle:
                  'При необходимости можно быстро выйти на связь с доверенным человеком.',
              icon: Icons.phone_in_talk_rounded,
              accent: const Color(0xFFA17456),
              background: const Color(0xFFF1E8E1),
              isLoading: _isOpening('trusted_contact'),
              onTap: () => _openMode(
                modeTitle: 'Связь с близким человеком',
                modeKey: 'trusted_contact',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopInfoCard extends StatelessWidget {
  const _TopInfoCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F3EE),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFE9E5DD)),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Что чаще помогает именно тебе',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: Color(0xFF2E3A2F),
            ),
          ),
          SizedBox(height: 8),
          Text(
            'По текущей истории чаще всего до завершения доходит режим: Режим спокойствия.',
            style: TextStyle(
              fontSize: 13,
              height: 1.4,
              color: Color(0xFF6C756A),
            ),
          ),
        ],
      ),
    );
  }
}

class _ModeTile extends StatelessWidget {
  const _ModeTile({
    required this.title,
    required this.icon,
    required this.accent,
    required this.background,
    required this.onTap,
    this.subtitle,
    this.isLoading = false,
  });

  final String title;
  final String? subtitle;
  final IconData icon;
  final Color accent;
  final Color background;
  final VoidCallback onTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: background,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: isLoading ? null : onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.55),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: accent),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF2A332B),
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        subtitle!,
                        style: const TextStyle(
                          fontSize: 13,
                          height: 1.35,
                          color: Color(0xFF6D756B),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 8),
              isLoading
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(strokeWidth: 2.2),
                    )
                  : const Icon(
                      Icons.chevron_right_rounded,
                      color: Color(0xFF7F877D),
                      size: 24,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}