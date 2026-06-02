import 'package:flutter/material.dart';
import 'package:mindreset_flutter/l10n/generated/app_localizations.dart';

import '../../../../core/constants/app_colors.dart';

class ModeData {
  const ModeData(this.title, this.icon, this.color);

  final String title;
  final String icon;
  final Color color;
}

class ModesGrid extends StatelessWidget {
  const ModesGrid({super.key, required this.onTap});

  final void Function(String title) onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final modes = [
      ModeData(l10n.modeCalmTitle, '🪷', AppColors.modeCalm),
      ModeData(l10n.modeEnergyTitle, '☀️', AppColors.modeEnergy),
      ModeData(l10n.modeSleepTitle, '🌙', AppColors.modeSleep),
      ModeData(l10n.modeFocusTitle, '◎', AppColors.modeFocus),
    ];

    return Column(
      children: [
        for (int i = 0; i < modes.length; i++) ...[
          _ModeTile(mode: modes[i], onTap: onTap),
          if (i != modes.length - 1) const SizedBox(height: 12),
        ],
      ],
    );
  }
}

class _ModeTile extends StatelessWidget {
  const _ModeTile({required this.mode, required this.onTap});

  final ModeData mode;
  final void Function(String title) onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: () => onTap(mode.title),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, mode.color.withValues(alpha: 0.16)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: Colors.white.withValues(alpha: 0.95)),
          boxShadow: [
            BoxShadow(
              color: mode.color.withValues(alpha: 0.18),
              blurRadius: 22,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: mode.color.withValues(alpha: 0.25),
              ),
              child: Center(
                child: Text(mode.icon, style: const TextStyle(fontSize: 22)),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                mode.title,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                  letterSpacing: -0.2,
                ),
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted),
          ],
        ),
      ),
    );
  }
}
