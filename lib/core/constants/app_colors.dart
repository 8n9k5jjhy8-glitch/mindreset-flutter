import 'package:flutter/material.dart';

/// Фирменная палитра MindReset в стиле «Спокойно».
//// Все экраны должны брать цвета только отсюда.
class AppColors {
  AppColors._();

  // Базовый фон и градиенты
  static const Color background = Color(0xFFF6FAF5);
  static const Color backgroundGradientStart = Color(0xFFF9FCF8);
  static const Color backgroundGradientMiddle = Color(0xFFF3F7F1);
  static const Color backgroundGradientEnd = Color(0xFFEBF2E9);

  // Карточки
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color cardBorder = Color(0xFFFFFFFF);
  static const Color cardShadow = Color(0xFFDCE7D8);

  // Совместимость со старыми экранами
  static const Color surface = cardBackground;

  // Основной зелёный для действий
  static const Color primary = Color(0xFFA6B39F);
  static const Color primaryStrong = Color(0xFF8EA98F);

  // Текст
  static const Color textPrimary = Color(0xFF243428);
  static const Color textSecondary = Color(0xFF5D7764);
  static const Color textMuted = Color(0xFF788578);
  static const Color textHint = Color(0xFF7F8A80);

  // Поля ввода
  static const Color inputFill = Color(0xFFFFFFFF);
  static const Color inputFocusBorder = Color(0xFFB5C3B0);
  static const Color inputIcon = Color(0xFF728173);

  // Сегменты (вкладки Вход/Регистрация)
  static const Color segmentTrack = Color(0xFFEEF4EC);

  // Цвета режимов (для HomeScreen)
  static const Color modeCalm = Color(0xFFA6B39F);
  static const Color modeEnergy = Color(0xFFE2A86A);
  static const Color modeSleep = Color(0xFF6B7DAE);
  static const Color modeFocus = Color(0xFF7BA8B3);

  // Цвета шкалы состояний (для карточки «Моё состояние сейчас»)
  static const Color stateLevel1 = Color(0xFFA6B39F); // Спокойно
  static const Color stateLevel2 = Color(0xFFD8C97B); // Лёгкое напряжение
  static const Color stateLevel3 = Color(0xFFE0A07A); // Заметный стресс
  static const Color stateLevel4 = Color(0xFFCC7A7A); // Сильный стресс

  // Градиент для основного фона
  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [
      backgroundGradientStart,
      backgroundGradientMiddle,
      backgroundGradientEnd,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
