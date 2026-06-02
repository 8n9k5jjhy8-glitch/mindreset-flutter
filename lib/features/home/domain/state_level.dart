import 'package:flutter/material.dart';
import 'package:mindreset_flutter/l10n/generated/app_localizations.dart';

enum StateLevel {
  calm(
    number: 1,
    color: Color(0xFF7BBE8A),
    icon: '🌿',
    flowerAsset: 'assets/images/flower_calm.png',
  ),
  tense(
    number: 2,
    color: Color(0xFFE4B663),
    icon: '🌼',
    flowerAsset: 'assets/images/flower_mild.png',
  ),
  overloaded(
    number: 3,
    color: Color(0xFFD9896A),
    icon: '🌺',
    flowerAsset: 'assets/images/flower_stress.png',
  ),
  critical(
    number: 4,
    color: Color(0xFFC96868),
    icon: '🆘',
    flowerAsset: 'assets/images/flower_high.png',
  );

  final int number;
  final Color color;
  final String icon;
  final String flowerAsset;

  const StateLevel({
    required this.number,
    required this.color,
    required this.icon,
    required this.flowerAsset,
  });
}

extension StateLevelL10n on StateLevel {
  String title(AppLocalizations l10n) {
    switch (this) {
      case StateLevel.calm:
        return l10n.stateCalmTitle;
      case StateLevel.tense:
        return l10n.stateTenseTitle;
      case StateLevel.overloaded:
        return l10n.stateOverloadedTitle;
      case StateLevel.critical:
        return l10n.stateCriticalTitle;
    }
  }

  String description(AppLocalizations l10n) {
    switch (this) {
      case StateLevel.calm:
        return l10n.stateCalmDescription;
      case StateLevel.tense:
        return l10n.stateTenseDescription;
      case StateLevel.overloaded:
        return l10n.stateOverloadedDescription;
      case StateLevel.critical:
        return l10n.stateCriticalDescription;
    }
  }

  String actionLabel(AppLocalizations l10n) {
    switch (this) {
      case StateLevel.calm:
        return l10n.stateCalmAction;
      case StateLevel.tense:
        return l10n.stateTenseAction;
      case StateLevel.overloaded:
        return l10n.stateOverloadedAction;
      case StateLevel.critical:
        return l10n.stateCriticalAction;
    }
  }
}
