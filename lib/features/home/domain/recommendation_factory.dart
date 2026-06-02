import 'package:mindreset_flutter/l10n/generated/app_localizations.dart';
import 'recommendation.dart';
import 'user_state_snapshot.dart';

class RecommendationFactory {
  const RecommendationFactory();

  Recommendation create(UserStateSnapshot state, AppLocalizations l10n) {
    final context = state.userContext;

    if (context == null) {
      return _fallbackByStress(state, l10n);
    }

    if (context.isHighStress) {
      return Recommendation(
        modeKey: 'urgent_help',
        modeTitle: l10n.recommendedUrgentHelp,
        title: l10n.recommendedUrgentHelp,
        subtitle: l10n.criticalStateDescription,
        source: 'home_ai_recommendation',
        priority: 4,
      );
    }

    if (context.isLowEnergy) {
      return Recommendation(
        modeKey: 'energy',
        modeTitle: l10n.modeEnergyTitle,
        title: l10n.modeEnergyTitle,
        subtitle: 'Сейчас подойдёт режим, который аккуратно вернёт ресурс и ясность.',
        source: 'home_ai_recommendation',
        priority: 2,
      );
    }

    if (context.hasUnstableSleep) {
      return Recommendation(
        modeKey: 'sleep',
        modeTitle: l10n.modeSleepTitle,
        title: l10n.recommendedRecovery,
        subtitle: 'Лучше выбрать спокойный режим, который поможет снизить перегрузку и восстановиться.',
        source: 'home_ai_recommendation',
        priority: 3,
      );
    }

    if (context.needsShortInterventions) {
      return Recommendation(
        modeKey: 'quick_reset',
        modeTitle: l10n.recommendedShortReset,
        title: l10n.aiRecommendsShortPractice,
        subtitle: 'Лучше выбрать короткий формат помощи на 3–5 минут.',
        source: 'home_ai_recommendation',
        priority: 2,
      );
    }

    return _fallbackByStress(state, l10n);
  }

  Recommendation _fallbackByStress(UserStateSnapshot state, AppLocalizations l10n) {
    switch (state.stressLevel) {
      case 1:
        return Recommendation(
          modeKey: 'calm',
          modeTitle: l10n.modeCalmTitle,
          title: l10n.recommendedKeepRhythm,
          subtitle: l10n.stableStateDescription,
          source: 'home_ai_recommendation',
          priority: 1,
        );
      case 2:
        return Recommendation(
          modeKey: 'quick_reset',
          modeTitle: l10n.recommendedShortReset,
          title: l10n.recommendedShortReset,
          subtitle: 'Есть признаки напряжения. Лучше сделать короткую паузу и мягко стабилизировать состояние.',
          source: 'home_ai_recommendation',
          priority: 2,
        );
      case 3:
        return Recommendation(
          modeKey: 'recovery',
          modeTitle: l10n.recommendedRecovery,
          title: l10n.recommendedRecovery,
          subtitle: 'Нагрузка выросла. Лучше запустить восстановление или перейти в подходящий режим помощи.',
          source: 'home_ai_recommendation',
          priority: 3,
        );
      case 4:
        return Recommendation(
          modeKey: 'urgent_help',
          modeTitle: l10n.recommendedUrgentHelp,
          title: l10n.recommendedUrgentHelp,
          subtitle: l10n.criticalStateDescription,
          source: 'home_ai_recommendation',
          priority: 4,
        );
      default:
        return Recommendation(
          modeKey: 'custom',
          modeTitle: l10n.recommendedHelp,
          title: l10n.recommendedHelp,
          subtitle: 'Выбери подходящий формат помощи.',
          source: 'home_ai_recommendation',
          priority: 1,
        );
    }
  }
}
