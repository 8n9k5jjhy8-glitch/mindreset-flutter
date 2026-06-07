import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../core/constants/app_colors.dart';

class StateScenario3Screen extends StatelessWidget {
  const StateScenario3Screen({super.key, this.arguments = const {}});

  final Map arguments;

  String get stateTitle =>
      arguments['stateTitle']?.toString().trim().isNotEmpty == true
          ? arguments['stateTitle'].toString().trim()
          : 'Повышенный стресс';

  int get stateLevel =>
      int.tryParse(arguments['stateLevel']?.toString() ?? '') ?? 3;

  String get selectedModeTitle =>
      arguments['selectedModeTitle']?.toString().trim().isNotEmpty == true
          ? arguments['selectedModeTitle'].toString().trim()
          : 'Персональный сценарий помощи';

  Map<String, dynamic> _interventionArgs() {
    return {
      ...arguments,
      'modeKey': arguments['selectedModeKey'] ?? 'recovery',
      'modeTitle': selectedModeTitle,
      'title': selectedModeTitle,
      'source': 'state_3_scenario',
      'runtimeTarget': 'intervention_screen',
      'runtimeVariant': 'live',
      'isPreview': true,
      'status': 'preview',
    };
  }

  Map<String, dynamic> _visualContactArgs() {
    return {
      ...arguments,
      'modeKey': 'visual_contact',
      'modeTitle': 'Визуальный контакт с AI',
      'title': 'Визуальный контакт с AI',
      'source': 'state_3_scenario',
      'routeFamily': 'support_presence',
      'supportGoal': 'reduce_isolation',
      'runtimeTarget': 'visual_contact_screen',
      'runtimeVariant': 'live',
      'isPreview': true,
      'status': 'preview',
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9F4),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F9F4),
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          color: AppColors.textPrimary,
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Поддержка сейчас',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w800,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
          children: [
            _HeroCard(
              background: const Color(0xFFF4E8C8),
              badge: '$stateLevel/4',
              overline: 'МОЁ СОСТОЯНИЕ СЕЙЧАС',
              title: stateTitle,
              body:
                  'Нагрузка выросла, и сейчас лучше перейти в более бережный режим. AI уже подготовил подходящий сценарий помощи, чтобы мягко снизить напряжение и вернуть чувство устойчивости.',
              footer:
                  'Состояние обновляется автоматически на основе биометрии, профиля и предыдущего опыта.',
            ),
            const SizedBox(height: 16),
            _ActionCard(
              icon: Icons.auto_awesome_rounded,
              iconBg: const Color(0xFFE8F0E6),
              title: 'Рекомендуется персональный сценарий восстановления',
              body:
                  'Маршрут помощи собран под ваше текущее состояние и то, что обычно помогает именно вам.',
              cta: 'Открыть сценарий помощи',
              onTap:
                  () => context.push(
                    AppRoutes.intervention,
                    extra: _interventionArgs(),
                  ),
            ),
            const SizedBox(height: 14),
            _ActionCard(
              icon: Icons.videocam_rounded,
              iconBg: const Color(0xFFEDE7F6),
              title: 'Нужна поддержка рядом?',
              body:
                  'Откройте визуальный контакт с AI-человеком, если сейчас легче проходить поддержку не в одиночку.',
              cta: 'Открыть визуальный контакт',
              onTap:
                  () => context.push(
                    AppRoutes.visualContact,
                    extra: _visualContactArgs(),
                  ),
            ),
            const SizedBox(height: 14),
            _SecondaryNavCard(
              title: 'Открыть режимы',
              body:
                  'Перейти ко всем форматам помощи и выбрать направление вручную.',
              onTap: () => context.go(AppRoutes.modes),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard({
    required this.background,
    required this.badge,
    required this.overline,
    required this.title,
    required this.body,
    required this.footer,
  });

  final Color background;
  final String badge;
  final String overline;
  final String title;
  final String body;
  final String footer;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(30),
      ),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(child: SizedBox()),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.35),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Text(
                  badge,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            overline,
            style: const TextStyle(
              color: Color(0xFF7B8678),
              fontSize: 14,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 28,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            body,
            style: const TextStyle(
              color: Color(0xFF687765),
              fontSize: 16,
              height: 1.35,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            footer,
            style: const TextStyle(
              color: Color(0xFF7E8C7B),
              fontSize: 14,
              height: 1.3,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.icon,
    required this.iconBg,
    required this.title,
    required this.body,
    required this.cta,
    required this.onTap,
  });

  final IconData icon;
  final Color iconBg;
  final String title;
  final String body;
  final String cta;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.96),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: const Color(0xFFE7ECE3)),
      ),
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: iconBg,
            child: Icon(icon, color: const Color(0xFF6D8A6B)),
          ),
          const SizedBox(height: 14),
          Text(
            title,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 24,
              height: 1.05,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            body,
            style: const TextStyle(
              color: Color(0xFF7A8777),
              fontSize: 16,
              height: 1.3,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFA8B39C),
                foregroundColor: Colors.white,
                elevation: 0,
                minimumSize: const Size.fromHeight(58),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                cta,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SecondaryNavCard extends StatelessWidget {
  const _SecondaryNavCard({
    required this.title,
    required this.body,
    required this.onTap,
  });

  final String title;
  final String body;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(24),
      child: Ink(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFFFFFFF), Color(0xFFF0F1EC)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFFE7ECE3)),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 14, 14),
            child: Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE6ECE0),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(
                    Icons.grid_view_rounded,
                    color: Color(0xFF6E836C),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF263126),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        body,
                        style: const TextStyle(
                          fontSize: 12,
                          height: 1.25,
                          color: Color(0xFF71806F),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(
                  Icons.chevron_right_rounded,
                  color: Color(0xFF7C8578),
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
