// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hebrew (`he`).
class AppLocalizationsHe extends AppLocalizations {
  AppLocalizationsHe([String locale = 'he']) : super(locale);

  @override
  String get appTitle => 'MindReset AI';

  @override
  String get profileTitle => 'פרופיל';

  @override
  String greeting(Object name) {
    return 'שלום, $name';
  }

  @override
  String notesCount(Object count) {
    return 'מספר ההערות: $count';
  }

  @override
  String get yourNotes => 'ההערות שלך';

  @override
  String get noNotes => 'אין עדיין הערות';

  @override
  String nameLabel(Object name) {
    return 'שם: $name';
  }

  @override
  String emailLabel(Object email) {
    return 'אימייל: $email';
  }

  @override
  String get statusNormal => 'המצב תקין';

  @override
  String get statusAttention => 'יש סימני מתח';

  @override
  String get statusWarning => 'המצב שונה מהרגיל';

  @override
  String get statusCritical => 'נדרשת תמיכה מיידית';

  @override
  String lastUpdated(Object time) {
    return 'עודכן לאחרונה: $time';
  }

  @override
  String get voiceNote => 'קול';

  @override
  String get textNote => 'טקסט';

  @override
  String get logoutTooltip => 'התנתק';

  @override
  String get profileTooltip => 'פרופיל';

  @override
  String get userFallbackName => 'משתמש';

  @override
  String get profileSubtitle => 'החשבון, ההקשר\nוההגדרות שלך';

  @override
  String get accountSection => 'חשבון';

  @override
  String get appSection => 'אפליקציה';

  @override
  String get personalDataTitle => 'פרטים אישיים';

  @override
  String get personalDataSubtitle => 'שפה, אזור זמן, קצב יום והתאמה אישית.';

  @override
  String get billingTitle => 'תשלום ומנוי';

  @override
  String get billingSubtitle => 'התוכנית הנוכחית, תקופת ניסיון וניהול מנוי.';

  @override
  String get settingsTitle => 'הגדרות';

  @override
  String get settingsSubtitle => 'התראות, ערכת נושא, פרטיות ושפת האפליקציה.';

  @override
  String get supportTitle => 'תמיכה';

  @override
  String get supportSubtitle => 'עזרה, משוב ותנאי שימוש.';

  @override
  String get signingOut => 'מתנתק...';

  @override
  String get signOutAccount => 'התנתק מהחשבון';

  @override
  String get savingProfessionProfile => 'שומר פרופיל מקצועי...';

  @override
  String profileLoadError(Object error) {
    return 'טעינת הפרופיל נכשלה: $error';
  }

  @override
  String get professionSaved => 'הפרופיל המקצועי נשמר';

  @override
  String professionSaveError(Object error) {
    return 'השמירה נכשלה: $error';
  }

  @override
  String get signOutDialogTitle => 'להתנתק מהחשבון?';

  @override
  String get signOutDialogMessage => 'תצא מהחשבון הנוכחי ותחזור למסך ההתחברות.';

  @override
  String get cancel => 'ביטול';

  @override
  String get signOut => 'התנתק';

  @override
  String signOutError(Object error) {
    return 'לא ניתן להתנתק: $error';
  }

  @override
  String get nameFieldLabel => 'שם';

  @override
  String get brandLabel => 'MindReset';

  @override
  String get currentContextTitle => 'ההקשר הנוכחי שלך';

  @override
  String get professionalProfileTitle => 'פרופיל מקצועי';

  @override
  String get goodMorning => 'בוקר טוב,';

  @override
  String get goodAfternoon => 'צהריים טובים,';

  @override
  String get goodEvening => 'ערב טוב,';

  @override
  String get heartRateCurrent => 'דופק נוכחי';

  @override
  String get heartRateUpdating => 'מעדכן דופק';

  @override
  String get stressIndexLabel => 'מדד לחץ';

  @override
  String get stressIndexCalculating => 'מחשב לחץ';

  @override
  String get noData => 'אין נתונים';

  @override
  String bpm(Object value) {
    return '$value פעימות/דקה';
  }

  @override
  String get recommendedKeepRhythm => 'מומלץ לשמור על הקצב';

  @override
  String get recommendedShortReset => 'מומלץ reset קצר';

  @override
  String get recommendedRecovery => 'מומלץ שיקום';

  @override
  String get recommendedUrgentHelp => 'מומלצת עזרה דחופה';

  @override
  String get recommendedHelp => 'מומלצת עזרה';

  @override
  String get aiRecommendsFastCalming => 'AI ממליץ על הרגעה מהירה';

  @override
  String get aiRecommendsEnergyBoost => 'AI ממליץ על חיזוק אנרגיה עדין';

  @override
  String get aiRecommendsCarefulRecovery => 'AI ממליץ על התאוששות עדינה';

  @override
  String get aiRecommendsShortPractice => 'AI ממליץ על תרגול קצר';

  @override
  String get aiRecommendsSuitableMode => 'AI ממליץ על מצב מתאים';

  @override
  String get stableStateDescription =>
      'המצב יציב. אפשר לבחור מצב תמיכה עדין או להשאיר כפי שהוא.';

  @override
  String get tensionStateDescription =>
      'יש סימני מתח. עדיף לקחת הפסקה קצרה ולהתייצב בעדינות.';

  @override
  String get highLoadDescription =>
      'העומס עלה. עדיף להתחיל התאוששות או לעבור למצב תמיכה מתאים.';

  @override
  String get criticalStateDescription =>
      'המצב דורש תשומת לב עכשיו. אפשר להתחיל התערבות או לפתוח קשר חזותי עם AI.';

  @override
  String get chooseSupportFormat => 'בחר את פורמט התמיכה שמתאים לך.';

  @override
  String get shortPracticeDuration => 'תרגול קצר של 3–5 דקות';

  @override
  String get longPracticeDuration => 'תרגול עמוק יותר של 10–15 דקות';

  @override
  String get mediumPracticeDuration => 'תרגול מאוזן של 5–10 דקות';

  @override
  String get toneCalming => 'כדי להפחית מתח';

  @override
  String get toneEnergizing => 'כדי להחזיר אנרגיה ובהירות';

  @override
  String get toneBalanced => 'כדי לשמור על יציבות';

  @override
  String aiPersonalRecommendation(Object duration, Object tone) {
    return 'בהתאם לפרופיל שלך, AI ממליץ על $duration $tone.';
  }

  @override
  String get modeUrgentHelp => 'עזרה דחופה';

  @override
  String get modeSleepPreparation => 'הכנה לשינה';

  @override
  String get modeNeedEnergy => 'צריך אנרגיה';

  @override
  String get modeQuickReset => 'reset מהיר';

  @override
  String get modeCalm => 'מצב רוגע';

  @override
  String get modeRecovery => 'התאוששות';

  @override
  String get modeSuitableHelp => 'תמיכה מתאימה';

  @override
  String get modeFocus => 'רוצה להתמקד';

  @override
  String get modeSoftSupport => 'תמיכה עדינה';

  @override
  String get resumeSessionTitle => 'המשך סשן';

  @override
  String get openModesTitle => 'פתח מצבים';

  @override
  String get openModesSubtitle => 'מעבר לכל התרגולים הזמינים.';

  @override
  String sessionMeta(Object modeTitle, Object stressTitle) {
    return '$modeTitle · $stressTitle';
  }

  @override
  String get personalDataBirthDate => 'תאריך לידה';

  @override
  String get personalDataDateNotSelected => 'לא נבחר';

  @override
  String get personalDataGender => 'מגדר';

  @override
  String get personalDataGenderMale => 'זכר';

  @override
  String get personalDataGenderFemale => 'נקבה';

  @override
  String get personalDataCity => 'עיר';

  @override
  String get personalDataOccupation => 'עיסוק';

  @override
  String get personalDataRelationshipStatus => 'סטטוס זוגי';

  @override
  String get personalDataRelationshipSingle => 'רווק/ה';

  @override
  String get personalDataRelationshipInRelationship => 'בזוגיות';

  @override
  String get personalDataRelationshipMarried => 'נשוי/אה';

  @override
  String get personalDataRelationshipDivorced => 'גרוש/ה';

  @override
  String get personalDataHasChildren => 'יש ילדים';

  @override
  String get personalDataSleepSchedule => 'דפוס שינה';

  @override
  String get personalDataSleepStable => 'יציב';

  @override
  String get personalDataSleepUnstable => 'לא יציב';

  @override
  String get personalDataSleepShift => 'משמרות';

  @override
  String personalDataStressLevel(int value) {
    return 'Stress: $value/10';
  }

  @override
  String personalDataEnergyLevel(int value) {
    return 'Energy: $value/10';
  }

  @override
  String get personalDataGoals => 'מטרות';

  @override
  String get personalDataSaving => 'שומר...';

  @override
  String get personalDataSave => 'שמור';

  @override
  String personalDataSaveError(String error) {
    return 'שגיאה בשמירה: $error';
  }

  @override
  String get tabHome => 'בית';

  @override
  String get tabModes => 'מצבים';

  @override
  String get tabHistory => 'היסטוריה';

  @override
  String get tabProfile => 'פרופיל';

  @override
  String get stateCalmTitle => 'רגוע';

  @override
  String get stateCalmDescription =>
      'המצב שלך יציב. אפשר לשמור על הקצב ולתמוך בעצמך בעדינות לאורך היום.';

  @override
  String get stateCalmAction => 'לשמור על הקצב';

  @override
  String get stateTenseTitle => 'מתח';

  @override
  String get stateTenseDescription =>
      'יש סימנים למתח פנימי. עדיף לקחת הפסקה קצרה, לנשוף ולהתייצב בעדינות.';

  @override
  String get stateTenseAction => 'להתחיל reset';

  @override
  String get stateOverloadedTitle => 'עומס יתר';

  @override
  String get stateOverloadedDescription =>
      'העומס עלה. חשוב להפחית את הרעש הפנימי, להחזיר תחושת יציבות ולהחזיר מעט בהירות.';

  @override
  String get stateOverloadedAction => 'להתחיל התאוששות';

  @override
  String get stateCriticalTitle => 'קריטי';

  @override
  String get stateCriticalDescription =>
      'המצב שלך דורש תשומת לב עכשיו. עדיף לא לחכות ולעבור לעזרה ישירה ותומכת יותר.';

  @override
  String get stateCriticalAction => 'לקבל עזרה';

  @override
  String get professionCategoryLifestyleTitle => 'הקשר חיים';

  @override
  String get professionCategoryWorkTitle => 'עבודה וקריירה';

  @override
  String get professionCategoryServiceTitle => 'שירות ועומס גבוה';

  @override
  String get professionSelectorHelper =>
      'בחר את הקשר החיים שלך כדי שההמלצות יהיו מדויקות ומועילות יותר.';

  @override
  String get professionPickerTitle => 'בחר פרופיל מקצועי';

  @override
  String get professionPickerSubtitle =>
      'זה עוזר להתאים בצורה מדויקת יותר את ההמלצות ואת מסלולי התמיכה.';

  @override
  String get professionStudentTitle => 'סטודנט';

  @override
  String get professionStudentSubtitle => 'לימודים, מבחנים, דדליינים וריכוז.';

  @override
  String get professionStudentShort => 'סטודנט';

  @override
  String get professionOfficeWorkerTitle => 'עובד משרד';

  @override
  String get professionOfficeWorkerSubtitle =>
      'לו\"ז עבודה, פגישות, עומס ואיזון.';

  @override
  String get professionOfficeWorkerShort => 'משרד';

  @override
  String get professionFreelancerTitle => 'פרילנסר';

  @override
  String get professionFreelancerSubtitle => 'קצב גמיש, פרויקטים וארגון עצמי.';

  @override
  String get professionFreelancerShort => 'פרילנס';

  @override
  String get professionEntrepreneurTitle => 'יזם';

  @override
  String get professionEntrepreneurSubtitle => 'אחריות, החלטות וקצב גבוה.';

  @override
  String get professionEntrepreneurShort => 'עסקים';

  @override
  String get professionManagerTitle => 'מנהל';

  @override
  String get professionManagerSubtitle => 'צוות, דדליינים וניהול סטרס.';

  @override
  String get professionManagerShort => 'ניהול';

  @override
  String get professionJobSeekerTitle => 'מחפש עבודה';

  @override
  String get professionJobSeekerSubtitle =>
      'חוסר ודאות, חיפוש ותמיכה במוטיבציה.';

  @override
  String get professionJobSeekerShort => 'חיפוש';

  @override
  String get professionCaregiverTitle => 'מטפל במשפחה';

  @override
  String get professionCaregiverSubtitle => 'דאגה ליקרים לך, משאבים והתאוששות.';

  @override
  String get professionCaregiverShort => 'משפחה';

  @override
  String get professionHealthcareWorkerTitle => 'עובד מערכת הבריאות';

  @override
  String get professionHealthcareWorkerSubtitle =>
      'משמרות, אחריות גבוהה ועומס רגשי.';

  @override
  String get professionHealthcareWorkerShort => 'רפואה';

  @override
  String get professionMilitaryOrReservistTitle => 'צבא / מילואים';

  @override
  String get professionMilitaryOrReservistSubtitle =>
      'דריכות גבוהה, מתח, משמעת והסתגלות.';

  @override
  String get professionMilitaryOrReservistShort => 'שירות';

  @override
  String get professionPoliceOfficerTitle => 'שוטר';

  @override
  String get professionPoliceOfficerSubtitle =>
      'ערנות, מצבי לחץ והתאוששות מהירה.';

  @override
  String get professionPoliceOfficerShort => 'משטרה';

  @override
  String get professionFirefighterTitle => 'כבאי';

  @override
  String get professionFirefighterSubtitle =>
      'קריאות חירום, סיבולת ועומס גבוה.';

  @override
  String get professionFirefighterShort => 'כבאות';

  @override
  String get professionDriverTitle => 'נהג';

  @override
  String get professionDriverSubtitle => 'דרך, ריכוז, עייפות, שגרה ובטיחות.';

  @override
  String get professionDriverShort => 'נהיגה';

  @override
  String get professionOtherTitle => 'אחר';

  @override
  String get professionOtherSubtitle => 'מצב אוניברסלי ללא התמחות צרה.';

  @override
  String get professionOtherShort => 'אחר';

  @override
  String get personalDetailsBasicsTitle => 'בסיסי';

  @override
  String get personalDetailsBasicsSubtitle => 'הגדרות התאמה אישית בסיסיות.';

  @override
  String get personalDetailsLanguage => 'שפה';

  @override
  String get personalDetailsTimeZone => 'אזור זמן';

  @override
  String get personalDetailsTimeZoneHint =>
      'אם המשתמש נמצא באזור אחר, שמרו את ערך אזור הזמן השמור בפרופיל.';

  @override
  String get personalDetailsDailyRhythmTitle => 'קצב יומי';

  @override
  String get personalDetailsDailyRhythmSubtitle =>
      'מתי ובאיזה אופן קל לך יותר לתרגל.';

  @override
  String get personalDetailsDailyRoutine => 'שגרת יום';

  @override
  String get personalDetailsEnergyDip => 'ירידת אנרגיה';

  @override
  String get personalDetailsSessionFormat => 'פורמט מפגש';

  @override
  String get personalDetailsWorkFormat => 'פורמט עבודה';

  @override
  String get personalDetailsSleepScheduleLabel => 'דפוס שינה';

  @override
  String get personalDetailsHasChildrenLabel => 'יש ילדים';

  @override
  String get personalDetailsStateTitle => 'מצב';

  @override
  String get personalDetailsStateSubtitle => 'משמש לבחירת הטון וסוג ההתערבות.';

  @override
  String get personalDetailsCurrentStress => 'רמת לחץ נוכחית';

  @override
  String get personalDetailsCurrentEnergy => 'רמת אנרגיה נוכחית';

  @override
  String get personalDetailsSupportSystem => 'מערכת תמיכה';

  @override
  String get personalDetailsLow => 'נמוך';

  @override
  String get personalDetailsHigh => 'גבוה';

  @override
  String get personalDetailsWeak => 'חלשה';

  @override
  String get personalDetailsStrong => 'חזקה';

  @override
  String get personalDetailsSupportStyle => 'סגנון תמיכה';

  @override
  String get personalDetailsSelfHelpExperience => 'ניסיון בעזרה עצמית';

  @override
  String get personalDetailsEmergencyHelp => 'עזרה במצב חירום';

  @override
  String get personalDetailsCrisisPlanTitle => 'תוכנית חירום';

  @override
  String get personalDetailsCrisisPlanSubtitle => 'גישה מהירה לפעולות תמיכה.';

  @override
  String get personalDetailsTriggersSleepTitle => 'טריגרים ושינה';

  @override
  String get personalDetailsTriggersSleepSubtitle => 'אפשר לבחור כמה אפשרויות.';

  @override
  String get personalDetailsStressTriggersTitle => 'מה בדרך כלל מעורר לחץ';

  @override
  String get personalDetailsChooseAllThatApply => 'בחר/י את כל מה שמתאים.';

  @override
  String get personalDetailsSleepProblemsTitle => 'בעיות שינה';

  @override
  String get personalDetailsChooseAllThatFit => 'בחר/י את כל מה שמתאים.';

  @override
  String get personalDetailsGoalsSubtitle => 'תאר/י בקצרה מה היית רוצה לשפר.';

  @override
  String get personalDetailsGoalsHint => 'לדוגמה: פחות חרדה ושינה טובה יותר';

  @override
  String get personalDetailsTrustedContactTitle => 'איש קשר מהימן';

  @override
  String get personalDetailsTrustedContactSubtitle =>
      'מישהו שאפשר להתקשר או לכתוב לו במהירות ברגע קשה.';

  @override
  String get personalDetailsName => 'שם';

  @override
  String get personalDetailsNameHint => 'לדוגמה: אנה';

  @override
  String get personalDetailsPhone => 'טלפון';

  @override
  String get personalDetailsNote => 'הערה';

  @override
  String get personalDetailsNoteHint => 'לדוגמה: אחותי, עדיף לכתוב ב-WhatsApp';

  @override
  String get personalDetailsClearContact => 'נקה איש קשר';

  @override
  String get personalDetailsRoutineEarlyBird => 'טיפוס בוקר';

  @override
  String get personalDetailsRoutineBalanced => 'מאוזן';

  @override
  String get personalDetailsRoutineNightOwl => 'טיפוס לילה';

  @override
  String get personalDetailsDipMorning => 'בוקר';

  @override
  String get personalDetailsDipAfternoon => 'צהריים';

  @override
  String get personalDetailsDipEvening => 'ערב';

  @override
  String get personalDetailsDipNone => 'אין ירידה ברורה';

  @override
  String get personalDetailsSessionShort => 'מפגשים קצרים';

  @override
  String get personalDetailsSessionMedium => 'מפגשים בינוניים';

  @override
  String get personalDetailsSessionLong => 'מפגשים ארוכים';

  @override
  String get personalDetailsSupportGentle => 'עדין';

  @override
  String get personalDetailsSupportStructured => 'מובנה';

  @override
  String get personalDetailsSupportDirect => 'ישיר';

  @override
  String get personalDetailsSupportWarm => 'חם';

  @override
  String get personalDetailsWorkOffice => 'משרד';

  @override
  String get personalDetailsWorkRemote => 'מרחוק';

  @override
  String get personalDetailsWorkHybrid => 'היברידי';

  @override
  String get personalDetailsWorkShift => 'משמרות';

  @override
  String get personalDetailsWorkFlexible => 'גמיש';

  @override
  String get personalDetailsWorkOther => 'אחר';

  @override
  String get personalDetailsSleepStableOption => 'יציב';

  @override
  String get personalDetailsSleepUnstableOption => 'לא יציב';

  @override
  String get personalDetailsSleepShiftOption => 'משמרות';

  @override
  String get personalDetailsExperienceNone => 'ללא ניסיון';

  @override
  String get personalDetailsExperienceBeginner => 'מתחיל/ה';

  @override
  String get personalDetailsExperienceIntermediate => 'בינוני/ת';

  @override
  String get personalDetailsExperienceAdvanced => 'מתקדם/ת';

  @override
  String get personalDetailsEmergencySelfHelp => 'עזרה עצמית';

  @override
  String get personalDetailsEmergencyContactPerson => 'לפנות לאיש קשר מהימן';

  @override
  String get personalDetailsEmergencyHotline => 'לפנות לעזרה';

  @override
  String get personalDetailsEmergencyDepends => 'תלוי במצב';

  @override
  String get personalDetailsTriggerWork => 'עבודה';

  @override
  String get personalDetailsTriggerCareer => 'קריירה';

  @override
  String get personalDetailsTriggerFamily => 'משפחה';

  @override
  String get personalDetailsTriggerRelationships => 'יחסים';

  @override
  String get personalDetailsTriggerSleep => 'שינה';

  @override
  String get personalDetailsTriggerHealth => 'בריאות';

  @override
  String get personalDetailsTriggerMoney => 'כסף';

  @override
  String get personalDetailsTriggerUncertainty => 'אי-ודאות';

  @override
  String get personalDetailsTriggerAnxiety => 'חרדה';

  @override
  String get personalDetailsTriggerSocial => 'חיים חברתיים';

  @override
  String get personalDetailsSleepProblemFallingAsleep => 'קושי להירדם';

  @override
  String get personalDetailsSleepProblemNightWaking => 'התעוררות בלילה';

  @override
  String get personalDetailsSleepProblemEarlyWaking => 'יקיצה מוקדמת';

  @override
  String get personalDetailsSleepProblemLightSleep => 'שינה קלה';

  @override
  String get personalDetailsSleepProblemRacingThoughts => 'מחשבות רצות';

  @override
  String get personalDetailsSleepProblemIrregularSchedule => 'לו\"ז לא סדיר';

  @override
  String get modesTitle => 'מצבים';

  @override
  String get modesTopCardTitle => 'מה עוזר לך לרוב';

  @override
  String get modesTopCardSubtitle =>
      'לפי ההיסטוריה הנוכחית שלך, המצב שמגיע לסיום בתדירות הגבוהה ביותר הוא: מצב רוגע.';

  @override
  String get modesManualSelectionStressTitle => 'בחירה ידנית של מצב';

  @override
  String get modesCreateSessionError => 'לא ניתן היה ליצור סשן. נסה שוב.';

  @override
  String modesOpenError(Object error) {
    return 'לא ניתן היה לפתוח את המצב: $error';
  }

  @override
  String get modeCalmTitle => 'מצב רוגע';

  @override
  String get modeEnergyTitle => 'צריך אנרגיה';

  @override
  String get modeSleepTitle => 'הכנה לשינה';

  @override
  String get modeFocusTitle => 'אני רוצה להתמקד';

  @override
  String get modeVisualContactTitle => 'קשר חזותי עם AI';

  @override
  String get modeVisualContactSubtitle =>
      'פתח שיחה עם אדם מבוסס AI בפורמט של קשר חזותי.';

  @override
  String get modeTrustedContactTitle => 'קשר עם אדם קרוב';

  @override
  String get modeTrustedContactSubtitle =>
      'במידת הצורך אפשר ליצור במהירות קשר עם אדם מהימן.';

  @override
  String get myStateNowTitle => 'המצב שלי עכשיו';

  @override
  String get stateUpdatesFromBiometrics =>
      'המצב מתעדכן אוטומטית על סמך נתוני ביומטריה.';

  @override
  String get professionProfileHelper =>
      'בחר את הקשר החיים שלך כדי שההמלצות יהיו מדויקות ומועילות יותר.';

  @override
  String get historySummaryTitle => 'סיכום קצר';

  @override
  String get historySummarySubtitle =>
      'כאן רואים באילו מצבים באמת השתמשת ולאילו חזרת הכי הרבה.';

  @override
  String get historySummaryLaunches => 'הפעלות';

  @override
  String get historySummaryCompleted => 'הושלמו';

  @override
  String get historySummaryHelped => 'עזר';

  @override
  String get historyUsedModesTitle => 'מצבים שכבר השתמשת בהם';

  @override
  String get historyEmptyTitle => 'ההיסטוריה עדיין ריקה';

  @override
  String get historyEmptySubtitle =>
      'כשתתחיל להשתמש במצבים, כאן תראה למה חזרת, מה השלמת ומה באמת עזר.';

  @override
  String get historyLoadError =>
      'לא הצלחנו לטעון את ההיסטוריה. משוך למטה כדי לנסות שוב.';

  @override
  String historyLastState(Object value) {
    return 'מצב אחרון: $value';
  }

  @override
  String historyRunsCount(int count) {
    return '$count הפעלות';
  }

  @override
  String historyCompletedRunsCount(int count) {
    return '$count הושלמו במלואם';
  }

  @override
  String historyHelpedRunsCount(int count) {
    return '$count עזר';
  }

  @override
  String historyLastTime(Object value) {
    return 'פעם אחרונה $value';
  }

  @override
  String historyCompletionRate(Object value) {
    return 'שיעור השלמה: $value';
  }

  @override
  String historyAverageDuration(Object value) {
    return 'משך ממוצע: $value';
  }

  @override
  String historySheetRunsCompleted(int runs, int completed) {
    return 'הפעלות: $runs • הושלמו במלואם: $completed';
  }

  @override
  String historySheetHelped(int count) {
    return 'עזר: $count';
  }

  @override
  String get historySheetHelpedNone => 'עזר: —';

  @override
  String historyStateLabel(Object value) {
    return 'מצב: $value';
  }

  @override
  String historyDurationLabel(Object value) {
    return 'נמשך $value';
  }

  @override
  String historyResultLabel(Object value) {
    return 'תוצאה: $value';
  }

  @override
  String historyCommentLabel(Object value) {
    return 'הערה: $value';
  }

  @override
  String get historyStatusCompleted => 'הושלם';

  @override
  String get historyStatusActive => 'פעיל';

  @override
  String get historyStatusNoStatus => 'ללא סטטוס';

  @override
  String get historyResultHelped => 'עזר';

  @override
  String get historyResultNeutral => 'ניטרלי';

  @override
  String get historyResultNotHelped => 'לא עזר';

  @override
  String historySecondsShort(int count) {
    return '$count שנ׳';
  }

  @override
  String historyMinutesShort(int count) {
    return '$count דק׳';
  }

  @override
  String historyHoursShort(int count) {
    return '$count ש׳';
  }

  @override
  String historyHoursMinutesShort(int hours, int minutes) {
    return '$hours ש׳ $minutes דק׳';
  }
}
