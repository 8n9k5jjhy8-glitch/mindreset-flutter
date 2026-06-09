// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'MindReset AI';

  @override
  String get profileTitle => 'Профиль';

  @override
  String greeting(Object name) {
    return 'Привет, $name';
  }

  @override
  String notesCount(Object count) {
    return 'Количество заметок: $count';
  }

  @override
  String get yourNotes => 'Твои заметки';

  @override
  String get noNotes => 'Заметок пока нет';

  @override
  String nameLabel(Object name) {
    return 'Имя: $name';
  }

  @override
  String emailLabel(Object email) {
    return 'Email: $email';
  }

  @override
  String get statusNormal => 'Состояние в норме';

  @override
  String get statusAttention => 'Есть признаки напряжения';

  @override
  String get statusWarning => 'Состояние отличается от нормы';

  @override
  String get statusCritical => 'Нужна немедленная поддержка';

  @override
  String lastUpdated(Object time) {
    return 'Последнее обновление: $time';
  }

  @override
  String get voiceNote => 'Голос';

  @override
  String get textNote => 'Текст';

  @override
  String get logoutTooltip => 'Выйти';

  @override
  String get profileTooltip => 'Профиль';

  @override
  String get userFallbackName => 'Пользователь';

  @override
  String get profileSubtitle => 'Твой аккаунт, контекст\nи настройки';

  @override
  String get accountSection => 'Аккаунт';

  @override
  String get appSection => 'Приложение';

  @override
  String get personalDataTitle => 'Личные данные';

  @override
  String get personalDataSubtitle =>
      'Язык, часовой пояс, ритм дня и персонализация.';

  @override
  String get billingTitle => 'Оплата и подписка';

  @override
  String get billingSubtitle => 'Текущий план, trial и управление подпиской.';

  @override
  String get settingsTitle => 'Настройки';

  @override
  String get settingsSubtitle =>
      'Уведомления, тема, приватность и язык приложения.';

  @override
  String get supportTitle => 'Поддержка';

  @override
  String get supportSubtitle =>
      'Помощь, обратная связь и условия использования.';

  @override
  String get signingOut => 'Выходим...';

  @override
  String get signOutAccount => 'Выйти из аккаунта';

  @override
  String get savingProfessionProfile => 'Сохраняем профессиональный профиль...';

  @override
  String profileLoadError(Object error) {
    return 'Ошибка загрузки профиля: $error';
  }

  @override
  String get professionSaved => 'Профессиональный профиль сохранён';

  @override
  String professionSaveError(Object error) {
    return 'Ошибка сохранения: $error';
  }

  @override
  String get signOutDialogTitle => 'Выйти из аккаунта?';

  @override
  String get signOutDialogMessage =>
      'Ты выйдешь из текущего аккаунта и попадёшь на экран входа.';

  @override
  String get cancel => 'Отмена';

  @override
  String get signOut => 'Выйти';

  @override
  String signOutError(Object error) {
    return 'Не удалось выйти из аккаунта: $error';
  }

  @override
  String get nameFieldLabel => 'Имя';

  @override
  String get brandLabel => 'MindReset';

  @override
  String get currentContextTitle => 'ТВОЙ ТЕКУЩИЙ КОНТЕКСТ';

  @override
  String get professionalProfileTitle => 'Профессиональный профиль';

  @override
  String get goodMorning => 'Доброе утро,';

  @override
  String get goodAfternoon => 'Добрый день,';

  @override
  String get goodEvening => 'Добрый вечер,';

  @override
  String get heartRateCurrent => 'Текущий пульс';

  @override
  String get heartRateUpdating => 'Обновляем пульс';

  @override
  String get stressIndexLabel => 'Индекс стресса';

  @override
  String get stressIndexCalculating => 'Считаем стресс';

  @override
  String get noData => 'Нет данных';

  @override
  String bpm(Object value) {
    return '$value уд/мин';
  }

  @override
  String get recommendedKeepRhythm => 'Рекомендуется сохранить ритм';

  @override
  String get recommendedShortReset => 'Рекомендуется быстрое восстановление';

  @override
  String get recommendedRecovery => 'Рекомендуется восстановление';

  @override
  String get recommendedUrgentHelp => 'Рекомендуется срочная помощь';

  @override
  String get recommendedHelp => 'Рекомендуется помощь';

  @override
  String get aiRecommendsFastCalming => 'AI рекомендует быстрое успокоение';

  @override
  String get aiRecommendsEnergyBoost => 'AI рекомендует мягкий заряд энергии';

  @override
  String get aiRecommendsCarefulRecovery =>
      'AI рекомендует бережное восстановление';

  @override
  String get aiRecommendsShortPractice =>
      'Формат подобран под ваше текущее состояние';

  @override
  String get aiRecommendsSuitableMode => 'AI рекомендует подходящий режим';

  @override
  String get stableStateDescription =>
      'Состояние стабильно. Можно выбрать мягкий режим поддержки или оставить всё как есть.';

  @override
  String get tensionStateDescription =>
      'Есть признаки напряжения. Лучше сделать короткую паузу и мягко стабилизировать состояние.';

  @override
  String get highLoadDescription =>
      'Нагрузка выросла. Лучше запустить восстановление или перейти в подходящий режим помощи.';

  @override
  String get criticalStateDescription =>
      'Состояние требует внимания прямо сейчас. Можно начать интервенцию или открыть визуальный контакт с AI.';

  @override
  String get chooseSupportFormat => 'Выбери подходящий формат помощи.';

  @override
  String get shortPracticeDuration => 'короткую практику на 3–5 минут';

  @override
  String get longPracticeDuration => 'более глубокую практику на 10–15 минут';

  @override
  String get mediumPracticeDuration =>
      'сбалансированную практику на 5–10 минут';

  @override
  String get toneCalming => 'чтобы снизить напряжение';

  @override
  String get toneEnergizing => 'чтобы вернуть ресурс и ясность';

  @override
  String get toneBalanced => 'чтобы сохранить устойчивое состояние';

  @override
  String aiPersonalRecommendation(Object duration, Object tone) {
    return 'С учётом твоего профиля AI рекомендует $duration $tone.';
  }

  @override
  String get modeUrgentHelp => 'Срочная помощь';

  @override
  String get modeSleepPreparation => 'Подготовка ко сну';

  @override
  String get modeNeedEnergy => 'Нужна энергия';

  @override
  String get modeQuickReset => 'Быстрый reset';

  @override
  String get modeCalm => 'Режим спокойствия';

  @override
  String get modeRecovery => 'Восстановление';

  @override
  String get modeSuitableHelp => 'Подходящая помощь';

  @override
  String get modeFocus => 'Хочу сфокусироваться';

  @override
  String get modeSoftSupport => 'Мягкая поддержка';

  @override
  String get resumeSessionTitle => 'Продолжить сессию';

  @override
  String get openModesTitle => 'Открыть режимы';

  @override
  String get openModesSubtitle => 'Перейти ко всем доступным практикам.';

  @override
  String sessionMeta(Object modeTitle, Object stressTitle) {
    return '$modeTitle · $stressTitle';
  }

  @override
  String get personalDataBirthDate => 'Дата рождения';

  @override
  String get personalDataDateNotSelected => 'Не выбрана';

  @override
  String get personalDataGender => 'Пол';

  @override
  String get personalDataGenderMale => 'Мужской';

  @override
  String get personalDataGenderFemale => 'Женский';

  @override
  String get personalDataCity => 'Город';

  @override
  String get personalDataOccupation => 'Род занятий';

  @override
  String get personalDataRelationshipStatus => 'Семейное положение';

  @override
  String get personalDataRelationshipSingle => 'Не в отношениях';

  @override
  String get personalDataRelationshipInRelationship => 'В отношениях';

  @override
  String get personalDataRelationshipMarried => 'Женат / замужем';

  @override
  String get personalDataRelationshipDivorced => 'В разводе';

  @override
  String get personalDataHasChildren => 'Есть дети';

  @override
  String get personalDataSleepSchedule => 'Режим сна';

  @override
  String get personalDataSleepStable => 'Стабильный';

  @override
  String get personalDataSleepUnstable => 'Нестабильный';

  @override
  String get personalDataSleepShift => 'Сменный';

  @override
  String personalDataStressLevel(int value) {
    return 'Стресс: $value/10';
  }

  @override
  String personalDataEnergyLevel(int value) {
    return 'Энергия: $value/10';
  }

  @override
  String get personalDataGoals => 'Цели';

  @override
  String get personalDataSaving => 'Сохранение...';

  @override
  String get personalDataSave => 'Сохранить';

  @override
  String personalDataSaveError(String error) {
    return 'Ошибка сохранения: $error';
  }

  @override
  String get tabHome => 'Главная';

  @override
  String get tabModes => 'Режимы';

  @override
  String get tabHistory => 'История';

  @override
  String get tabProfile => 'Профиль';

  @override
  String get stateCalmTitle => 'Спокойно';

  @override
  String get stateCalmDescription =>
      'Состояние стабильное. Можно сохранить ритм, мягко поддержать себя и продолжать день без перегрузки.';

  @override
  String get stateCalmAction => 'Сохранить ритм';

  @override
  String get stateTenseTitle => 'Напряжение';

  @override
  String get stateTenseDescription =>
      'Есть признаки внутреннего напряжения. Лучше сделать короткую паузу, выдохнуть и мягко стабилизировать состояние.';

  @override
  String get stateTenseAction => 'Сделать reset';

  @override
  String get stateOverloadedTitle => 'Перегрузка';

  @override
  String get stateOverloadedDescription =>
      'Нагрузка выросла. Сейчас важнее снизить внутренний шум, восстановить опору и вернуть немного ясности.';

  @override
  String get stateOverloadedAction => 'Начать восстановление';

  @override
  String get stateCriticalTitle => 'Критично';

  @override
  String get stateCriticalDescription =>
      'Состояние требует внимания прямо сейчас. Лучше не тянуть и перейти к более прямой и поддерживающей помощи.';

  @override
  String get stateCriticalAction => 'Получить помощь';

  @override
  String get professionCategoryLifestyleTitle => 'Жизненный контекст';

  @override
  String get professionCategoryWorkTitle => 'Работа и карьера';

  @override
  String get professionCategoryServiceTitle => 'Служба и высокая нагрузка';

  @override
  String get professionSelectorHelper =>
      'Выбери свой контекст жизни, чтобы рекомендации были точнее и полезнее.';

  @override
  String get professionPickerTitle => 'Выбери профессиональный профиль';

  @override
  String get professionPickerSubtitle =>
      'Это помогает точнее адаптировать рекомендации и сценарии поддержки.';

  @override
  String get professionStudentTitle => 'Студент';

  @override
  String get professionStudentSubtitle =>
      'Учёба, экзамены, дедлайны, концентрация.';

  @override
  String get professionStudentShort => 'Студент';

  @override
  String get professionOfficeWorkerTitle => 'Офисный сотрудник';

  @override
  String get professionOfficeWorkerSubtitle =>
      'Рабочий график, встречи, нагрузка, баланс.';

  @override
  String get professionOfficeWorkerShort => 'Офис';

  @override
  String get professionFreelancerTitle => 'Фрилансер';

  @override
  String get professionFreelancerSubtitle =>
      'Гибкий ритм, проекты, самоорганизация.';

  @override
  String get professionFreelancerShort => 'Фриланс';

  @override
  String get professionEntrepreneurTitle => 'Предприниматель';

  @override
  String get professionEntrepreneurSubtitle =>
      'Ответственность, решения, высокий темп.';

  @override
  String get professionEntrepreneurShort => 'Бизнес';

  @override
  String get professionManagerTitle => 'Руководитель';

  @override
  String get professionManagerSubtitle =>
      'Команда, дедлайны, управление стрессом.';

  @override
  String get professionManagerShort => 'Руководитель';

  @override
  String get professionJobSeekerTitle => 'В поиске работы';

  @override
  String get professionJobSeekerSubtitle =>
      'Неопределённость, поиск, поддержка мотивации.';

  @override
  String get professionJobSeekerShort => 'Поиск';

  @override
  String get professionCaregiverTitle => 'Забочусь о семье';

  @override
  String get professionCaregiverSubtitle =>
      'Забота о близких, ресурс, восстановление.';

  @override
  String get professionCaregiverShort => 'Семья';

  @override
  String get professionHealthcareWorkerTitle => 'Медицинский работник';

  @override
  String get professionHealthcareWorkerSubtitle =>
      'Смены, высокая ответственность, эмоциональная нагрузка.';

  @override
  String get professionHealthcareWorkerShort => 'Медицина';

  @override
  String get professionMilitaryOrReservistTitle => 'Военнослужащий / резервист';

  @override
  String get professionMilitaryOrReservistSubtitle =>
      'Повышенная готовность, напряжение, дисциплина и адаптация.';

  @override
  String get professionMilitaryOrReservistShort => 'Служба';

  @override
  String get professionPoliceOfficerTitle => 'Полицейский';

  @override
  String get professionPoliceOfficerSubtitle =>
      'Бдительность, стрессовые ситуации, быстрое восстановление.';

  @override
  String get professionPoliceOfficerShort => 'Полиция';

  @override
  String get professionFirefighterTitle => 'Пожарный';

  @override
  String get professionFirefighterSubtitle =>
      'Экстренные вызовы, выносливость, высокая нагрузка.';

  @override
  String get professionFirefighterShort => 'Пожарный';

  @override
  String get professionDriverTitle => 'Водитель';

  @override
  String get professionDriverSubtitle =>
      'Дорога, концентрация, усталость, режим и безопасность.';

  @override
  String get professionDriverShort => 'Водитель';

  @override
  String get professionOtherTitle => 'Другое';

  @override
  String get professionOtherSubtitle =>
      'Универсальный режим без узкой специализации.';

  @override
  String get professionOtherShort => 'Другое';

  @override
  String get personalDetailsBasicsTitle => 'Основное';

  @override
  String get personalDetailsBasicsSubtitle =>
      'Базовые настройки персонализации.';

  @override
  String get personalDetailsLanguage => 'Язык';

  @override
  String get personalDetailsTimeZone => 'Часовой пояс';

  @override
  String get personalDetailsTimeZoneHint =>
      'Если пользователь находится в другом регионе, сохраняйте значение часового пояса из профиля.';

  @override
  String get personalDetailsDailyRhythmTitle => 'Ежедневный ритм';

  @override
  String get personalDetailsDailyRhythmSubtitle =>
      'Когда и как вам легче практиковаться.';

  @override
  String get personalDetailsDailyRoutine => 'Режим дня';

  @override
  String get personalDetailsEnergyDip => 'Спад энергии';

  @override
  String get personalDetailsSessionFormat => 'Формат сессии';

  @override
  String get personalDetailsWorkFormat => 'Формат работы';

  @override
  String get personalDetailsSleepScheduleLabel => 'Режим сна';

  @override
  String get personalDetailsHasChildrenLabel => 'Есть дети';

  @override
  String get personalDetailsStateTitle => 'Состояние';

  @override
  String get personalDetailsStateSubtitle =>
      'Используется для выбора тона и типа интервенции.';

  @override
  String get personalDetailsCurrentStress => 'Текущий стресс';

  @override
  String get personalDetailsCurrentEnergy => 'Текущая энергия';

  @override
  String get personalDetailsSupportSystem => 'Система поддержки';

  @override
  String get personalDetailsLow => 'Низкий';

  @override
  String get personalDetailsHigh => 'Высокий';

  @override
  String get personalDetailsWeak => 'Слабая';

  @override
  String get personalDetailsStrong => 'Сильная';

  @override
  String get personalDetailsSupportStyle => 'Стиль поддержки';

  @override
  String get personalDetailsSelfHelpExperience => 'Опыт самопомощи';

  @override
  String get personalDetailsEmergencyHelp => 'Помощь в экстренной ситуации';

  @override
  String get personalDetailsCrisisPlanTitle => 'План на случай кризиса';

  @override
  String get personalDetailsCrisisPlanSubtitle =>
      'Быстрый доступ к действиям поддержки.';

  @override
  String get personalDetailsTriggersSleepTitle => 'Триггеры и сон';

  @override
  String get personalDetailsTriggersSleepSubtitle =>
      'Можно выбрать несколько вариантов.';

  @override
  String get personalDetailsStressTriggersTitle =>
      'Что чаще всего вызывает стресс';

  @override
  String get personalDetailsChooseAllThatApply => 'Выберите всё подходящее.';

  @override
  String get personalDetailsSleepProblemsTitle => 'Проблемы со сном';

  @override
  String get personalDetailsChooseAllThatFit => 'Выберите всё, что подходит.';

  @override
  String get personalDetailsGoalsSubtitle =>
      'Кратко опишите, что вы хотите улучшить.';

  @override
  String get personalDetailsGoalsHint => 'Например: меньше тревоги и лучше сон';

  @override
  String get personalDetailsTrustedContactTitle => 'Доверенный контакт';

  @override
  String get personalDetailsTrustedContactSubtitle =>
      'Человек, которому можно быстро позвонить или написать в трудный момент.';

  @override
  String get personalDetailsName => 'Имя';

  @override
  String get personalDetailsNameHint => 'Например: Анна';

  @override
  String get personalDetailsPhone => 'Телефон';

  @override
  String get personalDetailsNote => 'Заметка';

  @override
  String get personalDetailsNoteHint =>
      'Например: сестра, лучше писать в WhatsApp';

  @override
  String get personalDetailsClearContact => 'Очистить контакт';

  @override
  String get personalDetailsRoutineEarlyBird => 'Жаворонок';

  @override
  String get personalDetailsRoutineBalanced => 'Сбалансированный';

  @override
  String get personalDetailsRoutineNightOwl => 'Сова';

  @override
  String get personalDetailsDipMorning => 'Утро';

  @override
  String get personalDetailsDipAfternoon => 'День';

  @override
  String get personalDetailsDipEvening => 'Вечер';

  @override
  String get personalDetailsDipNone => 'Без явного спада';

  @override
  String get personalDetailsSessionShort => 'Короткие сессии';

  @override
  String get personalDetailsSessionMedium => 'Средние сессии';

  @override
  String get personalDetailsSessionLong => 'Длинные сессии';

  @override
  String get personalDetailsSupportGentle => 'Мягкий';

  @override
  String get personalDetailsSupportStructured => 'Структурированный';

  @override
  String get personalDetailsSupportDirect => 'Прямой';

  @override
  String get personalDetailsSupportWarm => 'Тёплый';

  @override
  String get personalDetailsWorkOffice => 'Офис';

  @override
  String get personalDetailsWorkRemote => 'Удалённо';

  @override
  String get personalDetailsWorkHybrid => 'Гибридно';

  @override
  String get personalDetailsWorkShift => 'Посменно';

  @override
  String get personalDetailsWorkFlexible => 'Гибко';

  @override
  String get personalDetailsWorkOther => 'Другое';

  @override
  String get personalDetailsSleepStableOption => 'Стабильный';

  @override
  String get personalDetailsSleepUnstableOption => 'Нестабильный';

  @override
  String get personalDetailsSleepShiftOption => 'Посменно';

  @override
  String get personalDetailsExperienceNone => 'Без опыта';

  @override
  String get personalDetailsExperienceBeginner => 'Начальный';

  @override
  String get personalDetailsExperienceIntermediate => 'Средний';

  @override
  String get personalDetailsExperienceAdvanced => 'Продвинутый';

  @override
  String get personalDetailsEmergencySelfHelp => 'Самопомощь';

  @override
  String get personalDetailsEmergencyContactPerson =>
      'Связаться с доверенным человеком';

  @override
  String get personalDetailsEmergencyHotline => 'Обратиться за помощью';

  @override
  String get personalDetailsEmergencyDepends => 'Зависит от ситуации';

  @override
  String get personalDetailsTriggerWork => 'Работа';

  @override
  String get personalDetailsTriggerCareer => 'Карьера';

  @override
  String get personalDetailsTriggerFamily => 'Семья';

  @override
  String get personalDetailsTriggerRelationships => 'Отношения';

  @override
  String get personalDetailsTriggerSleep => 'Сон';

  @override
  String get personalDetailsTriggerHealth => 'Здоровье';

  @override
  String get personalDetailsTriggerMoney => 'Деньги';

  @override
  String get personalDetailsTriggerUncertainty => 'Неопределённость';

  @override
  String get personalDetailsTriggerAnxiety => 'Тревога';

  @override
  String get personalDetailsTriggerSocial => 'Социальная жизнь';

  @override
  String get personalDetailsSleepProblemFallingAsleep => 'Трудно заснуть';

  @override
  String get personalDetailsSleepProblemNightWaking => 'Пробуждения ночью';

  @override
  String get personalDetailsSleepProblemEarlyWaking => 'Ранние пробуждения';

  @override
  String get personalDetailsSleepProblemLightSleep => 'Поверхностный сон';

  @override
  String get personalDetailsSleepProblemRacingThoughts => 'Навязчивые мысли';

  @override
  String get personalDetailsSleepProblemIrregularSchedule =>
      'Нерегулярный график';

  @override
  String get modesTitle => 'Режимы';

  @override
  String get modesTopCardTitle => 'Что чаще помогает именно тебе';

  @override
  String get modesTopCardSubtitle =>
      'По текущей истории чаще всего до завершения доходит режим: Режим спокойствия.';

  @override
  String get modesManualSelectionStressTitle => 'Ручной выбор режима';

  @override
  String get modesCreateSessionError =>
      'Не удалось создать сессию. Попробуй ещё раз.';

  @override
  String modesOpenError(Object error) {
    return 'Не удалось открыть режим: $error';
  }

  @override
  String get modeCalmTitle => 'Режим спокойствия';

  @override
  String get modeEnergyTitle => 'Нужна энергия';

  @override
  String get modeSleepTitle => 'Подготовка ко сну';

  @override
  String get modeFocusTitle => 'Хочу сфокусироваться';

  @override
  String get modeVisualContactTitle => 'Визуальный контакт с AI';

  @override
  String get modeVisualContactSubtitle =>
      'Открой разговор с AI-человеком в формате визуального контакта.';

  @override
  String get modeTrustedContactTitle => 'Связь с близким человеком';

  @override
  String get modeTrustedContactSubtitle =>
      'При необходимости можно быстро выйти на связь с доверенным человеком.';

  @override
  String get myStateNowTitle => 'МОЁ СОСТОЯНИЕ СЕЙЧАС';

  @override
  String get stateUpdatesFromBiometrics =>
      'Состояние обновляется автоматически на основе биометрии.';

  @override
  String get professionProfileHelper =>
      'Выбери свой контекст жизни, чтобы рекомендации были точнее и полезнее.';

  @override
  String get historySummaryTitle => 'Краткая сводка';

  @override
  String get historySummarySubtitle =>
      'Показывает, какие режимы ты реально запускаешь и к каким возвращаешься чаще.';

  @override
  String get historySummaryLaunches => 'Запусков';

  @override
  String get historySummaryCompleted => 'Пройдено';

  @override
  String get historySummaryHelped => 'Помогло';

  @override
  String get historyUsedModesTitle => 'Режимы, которые уже использовались';

  @override
  String get historyEmptyTitle => 'История пока пустая';

  @override
  String get historyEmptySubtitle =>
      'Когда пользователь начнёт запускать режимы, здесь будет видно, к чему он возвращается, что проходит и что помогает.';

  @override
  String get historyLoadError =>
      'Не удалось загрузить историю. Потяни вниз, чтобы попробовать ещё раз.';

  @override
  String historyLastState(Object value) {
    return 'Последнее состояние: $value';
  }

  @override
  String historyRunsCount(int count) {
    return '$count запусков';
  }

  @override
  String historyCompletedRunsCount(int count) {
    return '$count пройдено полностью';
  }

  @override
  String historyHelpedRunsCount(int count) {
    return '$count помогло';
  }

  @override
  String historyLastTime(Object value) {
    return 'Последний раз $value';
  }

  @override
  String historyCompletionRate(Object value) {
    return 'Доля полных прохождений: $value';
  }

  @override
  String historyAverageDuration(Object value) {
    return 'Средняя длительность: $value';
  }

  @override
  String historySheetRunsCompleted(int runs, int completed) {
    return 'Запусков: $runs • Пройдено полностью: $completed';
  }

  @override
  String historySheetHelped(int count) {
    return 'Помогло: $count';
  }

  @override
  String get historySheetHelpedNone => 'Помогло: —';

  @override
  String historyStateLabel(Object value) {
    return 'Состояние: $value';
  }

  @override
  String historyDurationLabel(Object value) {
    return 'Длился $value';
  }

  @override
  String historyResultLabel(Object value) {
    return 'Результат: $value';
  }

  @override
  String historyCommentLabel(Object value) {
    return 'Комментарий: $value';
  }

  @override
  String get historyStatusCompleted => 'пройдено полностью';

  @override
  String get historyStatusActive => 'активно';

  @override
  String get historyStatusNoStatus => 'без статуса';

  @override
  String get historyResultHelped => 'помогло';

  @override
  String get historyResultNeutral => 'нейтрально';

  @override
  String get historyResultNotHelped => 'не помогло';

  @override
  String historySecondsShort(int count) {
    return '$count сек';
  }

  @override
  String historyMinutesShort(int count) {
    return '$count мин';
  }

  @override
  String historyHoursShort(int count) {
    return '$count ч';
  }

  @override
  String historyHoursMinutesShort(int hours, int minutes) {
    return '$hours ч $minutes мин';
  }

  @override
  String get homeInterventionRecommendationTitle =>
      'На основе анализа вашего состояния рекомендуется короткая сессия помощи.';

  @override
  String get homeInterventionRecommendationTapHint => 'Нажмите, чтобы открыть.';

  @override
  String get interventionRecommendationScreenTitle => 'Рекомендация';

  @override
  String get interventionSessionCardTitle => 'Сессия';

  @override
  String get interventionStartSession => 'Начать сеанс';

  @override
  String get interventionStarting => 'Запуск...';

  @override
  String get interventionClose => 'Закрыть';

  @override
  String get interventionCancelAndReturn => 'Отменить и вернуться';

  @override
  String get interventionQuickRecoveryTitle =>
      'Рекомендуется быстрое\nвосстановление';

  @override
  String get interventionCurrentStateFormat =>
      'Формат подобран под ваше текущее состояние';

  @override
  String get interventionQuickAccess => 'Быстрый доступ';

  @override
  String get interventionSleepPreparationTitle => 'Подготовка ко сну';

  @override
  String get interventionCalmTitle => 'Стабилизация';

  @override
  String get interventionFocusTitle => 'Фокус';

  @override
  String get interventionRecoveryTitle => 'Восстановление';

  @override
  String get interventionTrustedContactTitle => 'Доверенный контакт';

  @override
  String get interventionTrustedContactQuickAccess => 'Быстрый доступ';

  @override
  String get interventionTrustedContactSummary =>
      'Быстрый доступ к доверенному контакту.';

  @override
  String interventionSessionMinutesMeta(Object minutes, Object label) {
    return '$minutes мин • $label';
  }
}
