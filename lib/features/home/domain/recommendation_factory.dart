import 'recommendation.dart';
import 'user_state_snapshot.dart';

class RecommendationFactory {
  const RecommendationFactory();

  Recommendation create(UserStateSnapshot state) {
    final context = state.userContext;

    if (context == null) {
      return _fallbackByStress(state);
    }

    if (context.isHighStress) {
      return const Recommendation(
        modeKey: 'urgent_help',
        modeTitle: 'Срочная помощь',
        title: 'AI рекомендует быстрое успокоение',
        subtitle: 'С учётом твоего состояния лучше сразу перейти к короткой стабилизации.',
        source: 'home_ai_recommendation',
        priority: 4,
      );
    }

    if (context.isLowEnergy) {
      return const Recommendation(
        modeKey: 'energy',
        modeTitle: 'Нужна энергия',
        title: 'AI рекомендует мягкий заряд энергии',
        subtitle: 'Сейчас подойдёт режим, который аккуратно вернёт ресурс и ясность.',
        source: 'home_ai_recommendation',
        priority: 2,
      );
    }

    if (context.hasUnstableSleep) {
      return const Recommendation(
        modeKey: 'sleep',
        modeTitle: 'Подготовка ко сну',
        title: 'AI рекомендует бережное восстановление',
        subtitle: 'Лучше выбрать спокойный режим, который поможет снизить перегрузку и восстановиться.',
        source: 'home_ai_recommendation',
        priority: 3,
      );
    }

    if (context.needsShortInterventions) {
      return const Recommendation(
        modeKey: 'quick_reset',
        modeTitle: 'Быстрый reset',
        title: 'AI рекомендует короткую практику',
        subtitle: 'Лучше выбрать короткий формат помощи на 3–5 минут.',
        source: 'home_ai_recommendation',
        priority: 2,
      );
    }

    return _fallbackByStress(state);
  }

  Recommendation _fallbackByStress(UserStateSnapshot state) {
    switch (state.stressLevel) {
      case 1:
        return const Recommendation(
          modeKey: 'calm',
          modeTitle: 'Режим спокойствия',
          title: 'Рекомендуется сохранить ритм',
          subtitle: 'Состояние стабильно. Можно выбрать мягкий режим поддержки или оставить всё как есть.',
          source: 'home_ai_recommendation',
          priority: 1,
        );
      case 2:
        return const Recommendation(
          modeKey: 'quick_reset',
          modeTitle: 'Быстрый reset',
          title: 'Рекомендуется короткий reset',
          subtitle: 'Есть признаки напряжения. Лучше сделать короткую паузу и мягко стабилизировать состояние.',
          source: 'home_ai_recommendation',
          priority: 2,
        );
      case 3:
        return const Recommendation(
          modeKey: 'recovery',
          modeTitle: 'Восстановление',
          title: 'Рекомендуется восстановление',
          subtitle: 'Нагрузка выросла. Лучше запустить восстановление или перейти в подходящий режим помощи.',
          source: 'home_ai_recommendation',
          priority: 3,
        );
      case 4:
        return const Recommendation(
          modeKey: 'urgent_help',
          modeTitle: 'Срочная помощь',
          title: 'Рекомендуется срочная помощь',
          subtitle: 'Состояние требует внимания прямо сейчас. Можно начать интервенцию или открыть визуальный контакт с AI.',
          source: 'home_ai_recommendation',
          priority: 4,
        );
      default:
        return const Recommendation(
          modeKey: 'custom',
          modeTitle: 'Подходящая помощь',
          title: 'Рекомендуется помощь',
          subtitle: 'Выбери подходящий формат помощи.',
          source: 'home_ai_recommendation',
          priority: 1,
        );
    }
  }
}
