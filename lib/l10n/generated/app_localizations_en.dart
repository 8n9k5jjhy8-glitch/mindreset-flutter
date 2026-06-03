// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'MindReset AI';

  @override
  String get profileTitle => 'Profile';

  @override
  String greeting(Object name) {
    return 'Hello, $name';
  }

  @override
  String notesCount(Object count) {
    return 'Notes count: $count';
  }

  @override
  String get yourNotes => 'Your notes';

  @override
  String get noNotes => 'No notes yet';

  @override
  String nameLabel(Object name) {
    return 'Name: $name';
  }

  @override
  String emailLabel(Object email) {
    return 'Email: $email';
  }

  @override
  String get statusNormal => 'State is normal';

  @override
  String get statusAttention => 'Signs of tension';

  @override
  String get statusWarning => 'State differs from normal';

  @override
  String get statusCritical => 'Immediate support needed';

  @override
  String lastUpdated(Object time) {
    return 'Last updated: $time';
  }

  @override
  String get voiceNote => 'Voice';

  @override
  String get textNote => 'Text';

  @override
  String get logoutTooltip => 'Log out';

  @override
  String get profileTooltip => 'Profile';

  @override
  String get userFallbackName => 'User';

  @override
  String get profileSubtitle => 'Your account, context\nand settings';

  @override
  String get accountSection => 'Account';

  @override
  String get appSection => 'App';

  @override
  String get personalDataTitle => 'Personal details';

  @override
  String get personalDataSubtitle =>
      'Language, time zone, daily rhythm and personalization.';

  @override
  String get billingTitle => 'Billing and subscription';

  @override
  String get billingSubtitle =>
      'Current plan, trial and subscription management.';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsSubtitle =>
      'Notifications, theme, privacy and app language.';

  @override
  String get supportTitle => 'Support';

  @override
  String get supportSubtitle => 'Help, feedback and terms of use.';

  @override
  String get signingOut => 'Signing out...';

  @override
  String get signOutAccount => 'Sign out';

  @override
  String get savingProfessionProfile => 'Saving professional profile...';

  @override
  String profileLoadError(Object error) {
    return 'Failed to load profile: $error';
  }

  @override
  String get professionSaved => 'Professional profile saved';

  @override
  String professionSaveError(Object error) {
    return 'Save failed: $error';
  }

  @override
  String get signOutDialogTitle => 'Sign out of your account?';

  @override
  String get signOutDialogMessage =>
      'You will leave the current account and return to the sign-in screen.';

  @override
  String get cancel => 'Cancel';

  @override
  String get signOut => 'Sign out';

  @override
  String signOutError(Object error) {
    return 'Could not sign out: $error';
  }

  @override
  String get nameFieldLabel => 'Name';

  @override
  String get brandLabel => 'MindReset';

  @override
  String get currentContextTitle => 'YOUR CURRENT CONTEXT';

  @override
  String get professionalProfileTitle => 'Professional profile';

  @override
  String get goodMorning => 'Good morning,';

  @override
  String get goodAfternoon => 'Good afternoon,';

  @override
  String get goodEvening => 'Good evening,';

  @override
  String get heartRateCurrent => 'Current heart rate';

  @override
  String get heartRateUpdating => 'Updating heart rate';

  @override
  String get stressIndexLabel => 'Stress index';

  @override
  String get stressIndexCalculating => 'Calculating stress';

  @override
  String get noData => 'No data';

  @override
  String bpm(Object value) {
    return '$value bpm';
  }

  @override
  String get recommendedKeepRhythm => 'Recommended: keep your rhythm';

  @override
  String get recommendedShortReset => 'Recommended: short reset';

  @override
  String get recommendedRecovery => 'Recommended: recovery';

  @override
  String get recommendedUrgentHelp => 'Recommended: urgent help';

  @override
  String get recommendedHelp => 'Recommended: support';

  @override
  String get aiRecommendsFastCalming => 'AI recommends fast calming';

  @override
  String get aiRecommendsEnergyBoost => 'AI recommends a gentle energy boost';

  @override
  String get aiRecommendsCarefulRecovery => 'AI recommends gentle recovery';

  @override
  String get aiRecommendsShortPractice => 'AI recommends a short practice';

  @override
  String get aiRecommendsSuitableMode => 'AI recommends a suitable mode';

  @override
  String get stableStateDescription =>
      'Your state looks stable. You can choose a gentle support mode or leave things as they are.';

  @override
  String get tensionStateDescription =>
      'There are signs of tension. It is better to take a short pause and stabilize gently.';

  @override
  String get highLoadDescription =>
      'Your load has increased. It is better to start recovery or switch to a suitable support mode.';

  @override
  String get criticalStateDescription =>
      'Your state needs attention right now. You can start an intervention or open visual contact with AI.';

  @override
  String get chooseSupportFormat => 'Choose the support format that fits you.';

  @override
  String get shortPracticeDuration => 'a short 3–5 minute practice';

  @override
  String get longPracticeDuration => 'a deeper 10–15 minute practice';

  @override
  String get mediumPracticeDuration => 'a balanced 5–10 minute practice';

  @override
  String get toneCalming => 'to reduce tension';

  @override
  String get toneEnergizing => 'to restore energy and clarity';

  @override
  String get toneBalanced => 'to maintain a steady state';

  @override
  String aiPersonalRecommendation(Object duration, Object tone) {
    return 'Based on your profile, AI recommends $duration $tone.';
  }

  @override
  String get modeUrgentHelp => 'Urgent help';

  @override
  String get modeSleepPreparation => 'Sleep preparation';

  @override
  String get modeNeedEnergy => 'Need energy';

  @override
  String get modeQuickReset => 'Quick reset';

  @override
  String get modeCalm => 'Calm mode';

  @override
  String get modeRecovery => 'Recovery';

  @override
  String get modeSuitableHelp => 'Suitable support';

  @override
  String get modeFocus => 'Want to focus';

  @override
  String get modeSoftSupport => 'Gentle support';

  @override
  String get resumeSessionTitle => 'Resume session';

  @override
  String get openModesTitle => 'Open modes';

  @override
  String get openModesSubtitle => 'Go to all available practices.';

  @override
  String sessionMeta(Object modeTitle, Object stressTitle) {
    return '$modeTitle · $stressTitle';
  }

  @override
  String get personalDataBirthDate => 'Birth date';

  @override
  String get personalDataDateNotSelected => 'Not selected';

  @override
  String get personalDataGender => 'Gender';

  @override
  String get personalDataGenderMale => 'Male';

  @override
  String get personalDataGenderFemale => 'Female';

  @override
  String get personalDataCity => 'City';

  @override
  String get personalDataOccupation => 'Occupation';

  @override
  String get personalDataRelationshipStatus => 'Relationship status';

  @override
  String get personalDataRelationshipSingle => 'Single';

  @override
  String get personalDataRelationshipInRelationship => 'In a relationship';

  @override
  String get personalDataRelationshipMarried => 'Married';

  @override
  String get personalDataRelationshipDivorced => 'Divorced';

  @override
  String get personalDataHasChildren => 'Has children';

  @override
  String get personalDataSleepSchedule => 'Sleep schedule';

  @override
  String get personalDataSleepStable => 'Stable';

  @override
  String get personalDataSleepUnstable => 'Unstable';

  @override
  String get personalDataSleepShift => 'Shift schedule';

  @override
  String personalDataStressLevel(int value) {
    return 'Stress: $value/10';
  }

  @override
  String personalDataEnergyLevel(int value) {
    return 'Energy: $value/10';
  }

  @override
  String get personalDataGoals => 'Goals';

  @override
  String get personalDataSaving => 'Saving...';

  @override
  String get personalDataSave => 'Save';

  @override
  String personalDataSaveError(String error) {
    return 'Save error: $error';
  }

  @override
  String get tabHome => 'Home';

  @override
  String get tabModes => 'Modes';

  @override
  String get tabHistory => 'History';

  @override
  String get tabProfile => 'Profile';

  @override
  String get stateCalmTitle => 'Calm';

  @override
  String get stateCalmDescription =>
      'Your state looks stable. You can keep your rhythm and gently support yourself through the day.';

  @override
  String get stateCalmAction => 'Keep the rhythm';

  @override
  String get stateTenseTitle => 'Tension';

  @override
  String get stateTenseDescription =>
      'There are signs of inner tension. It is better to take a short pause, breathe out and gently stabilize.';

  @override
  String get stateTenseAction => 'Start a reset';

  @override
  String get stateOverloadedTitle => 'Overloaded';

  @override
  String get stateOverloadedDescription =>
      'Your load has increased. It is important to lower the inner noise, restore grounding and bring back some clarity.';

  @override
  String get stateOverloadedAction => 'Start recovery';

  @override
  String get stateCriticalTitle => 'Critical';

  @override
  String get stateCriticalDescription =>
      'Your state needs attention right now. It is better not to wait and go to more direct and supportive help.';

  @override
  String get stateCriticalAction => 'Get help';

  @override
  String get professionCategoryLifestyleTitle => 'Life context';

  @override
  String get professionCategoryWorkTitle => 'Work and career';

  @override
  String get professionCategoryServiceTitle => 'Service and high load';

  @override
  String get professionSelectorHelper =>
      'Choose your life context so recommendations become more accurate and useful.';

  @override
  String get professionPickerTitle => 'Choose a professional profile';

  @override
  String get professionPickerSubtitle =>
      'This helps tailor recommendations and support flows more precisely.';

  @override
  String get professionStudentTitle => 'Student';

  @override
  String get professionStudentSubtitle =>
      'Study, exams, deadlines, and concentration.';

  @override
  String get professionStudentShort => 'Student';

  @override
  String get professionOfficeWorkerTitle => 'Office worker';

  @override
  String get professionOfficeWorkerSubtitle =>
      'Work schedule, meetings, workload, and balance.';

  @override
  String get professionOfficeWorkerShort => 'Office';

  @override
  String get professionFreelancerTitle => 'Freelancer';

  @override
  String get professionFreelancerSubtitle =>
      'Flexible rhythm, projects, and self-organization.';

  @override
  String get professionFreelancerShort => 'Freelance';

  @override
  String get professionEntrepreneurTitle => 'Entrepreneur';

  @override
  String get professionEntrepreneurSubtitle =>
      'Responsibility, decisions, and a high pace.';

  @override
  String get professionEntrepreneurShort => 'Business';

  @override
  String get professionManagerTitle => 'Manager';

  @override
  String get professionManagerSubtitle =>
      'Team, deadlines, and stress management.';

  @override
  String get professionManagerShort => 'Manager';

  @override
  String get professionJobSeekerTitle => 'Job seeker';

  @override
  String get professionJobSeekerSubtitle =>
      'Uncertainty, search, and motivation support.';

  @override
  String get professionJobSeekerShort => 'Search';

  @override
  String get professionCaregiverTitle => 'Caregiver';

  @override
  String get professionCaregiverSubtitle =>
      'Caring for loved ones, energy, and recovery.';

  @override
  String get professionCaregiverShort => 'Family';

  @override
  String get professionHealthcareWorkerTitle => 'Healthcare worker';

  @override
  String get professionHealthcareWorkerSubtitle =>
      'Shifts, high responsibility, and emotional load.';

  @override
  String get professionHealthcareWorkerShort => 'Healthcare';

  @override
  String get professionMilitaryOrReservistTitle => 'Military / reservist';

  @override
  String get professionMilitaryOrReservistSubtitle =>
      'Heightened readiness, tension, discipline, and adaptation.';

  @override
  String get professionMilitaryOrReservistShort => 'Service';

  @override
  String get professionPoliceOfficerTitle => 'Police officer';

  @override
  String get professionPoliceOfficerSubtitle =>
      'Alertness, stressful situations, and quick recovery.';

  @override
  String get professionPoliceOfficerShort => 'Police';

  @override
  String get professionFirefighterTitle => 'Firefighter';

  @override
  String get professionFirefighterSubtitle =>
      'Emergency calls, endurance, and high load.';

  @override
  String get professionFirefighterShort => 'Firefighter';

  @override
  String get professionDriverTitle => 'Driver';

  @override
  String get professionDriverSubtitle =>
      'Road, concentration, fatigue, routine, and safety.';

  @override
  String get professionDriverShort => 'Driver';

  @override
  String get professionOtherTitle => 'Other';

  @override
  String get professionOtherSubtitle =>
      'A universal mode without narrow specialization.';

  @override
  String get professionOtherShort => 'Other';

  @override
  String get personalDetailsBasicsTitle => 'Basics';

  @override
  String get personalDetailsBasicsSubtitle => 'Core personalization settings.';

  @override
  String get personalDetailsLanguage => 'Language';

  @override
  String get personalDetailsTimeZone => 'Time zone';

  @override
  String get personalDetailsTimeZoneHint =>
      'If the user is in another region, keep the saved profile time zone value.';

  @override
  String get personalDetailsDailyRhythmTitle => 'Daily rhythm';

  @override
  String get personalDetailsDailyRhythmSubtitle =>
      'When and how it is easier for you to practice.';

  @override
  String get personalDetailsDailyRoutine => 'Daily routine';

  @override
  String get personalDetailsEnergyDip => 'Energy dip';

  @override
  String get personalDetailsSessionFormat => 'Session format';

  @override
  String get personalDetailsWorkFormat => 'Work format';

  @override
  String get personalDetailsSleepScheduleLabel => 'Sleep schedule';

  @override
  String get personalDetailsHasChildrenLabel => 'Has children';

  @override
  String get personalDetailsStateTitle => 'State';

  @override
  String get personalDetailsStateSubtitle =>
      'Used to choose tone and intervention type.';

  @override
  String get personalDetailsCurrentStress => 'Current stress';

  @override
  String get personalDetailsCurrentEnergy => 'Current energy';

  @override
  String get personalDetailsSupportSystem => 'Support system';

  @override
  String get personalDetailsLow => 'Low';

  @override
  String get personalDetailsHigh => 'High';

  @override
  String get personalDetailsWeak => 'Weak';

  @override
  String get personalDetailsStrong => 'Strong';

  @override
  String get personalDetailsSupportStyle => 'Support style';

  @override
  String get personalDetailsSelfHelpExperience => 'Self-help experience';

  @override
  String get personalDetailsEmergencyHelp => 'Emergency help';

  @override
  String get personalDetailsCrisisPlanTitle => 'Crisis plan';

  @override
  String get personalDetailsCrisisPlanSubtitle =>
      'Quick access to support actions.';

  @override
  String get personalDetailsTriggersSleepTitle => 'Triggers and sleep';

  @override
  String get personalDetailsTriggersSleepSubtitle =>
      'You can choose several options.';

  @override
  String get personalDetailsStressTriggersTitle =>
      'What most often triggers stress';

  @override
  String get personalDetailsChooseAllThatApply => 'Choose all that apply.';

  @override
  String get personalDetailsSleepProblemsTitle => 'Sleep problems';

  @override
  String get personalDetailsChooseAllThatFit => 'Choose all that fit.';

  @override
  String get personalDetailsGoalsSubtitle =>
      'Briefly describe what you want to improve.';

  @override
  String get personalDetailsGoalsHint =>
      'For example: less anxiety and better sleep';

  @override
  String get personalDetailsTrustedContactTitle => 'Trusted contact';

  @override
  String get personalDetailsTrustedContactSubtitle =>
      'Someone you can quickly call or message in a difficult moment.';

  @override
  String get personalDetailsName => 'Name';

  @override
  String get personalDetailsNameHint => 'For example: Anna';

  @override
  String get personalDetailsPhone => 'Phone';

  @override
  String get personalDetailsNote => 'Note';

  @override
  String get personalDetailsNoteHint =>
      'For example: sister, better to text on WhatsApp';

  @override
  String get personalDetailsClearContact => 'Clear contact';

  @override
  String get personalDetailsRoutineEarlyBird => 'Early bird';

  @override
  String get personalDetailsRoutineBalanced => 'Balanced';

  @override
  String get personalDetailsRoutineNightOwl => 'Night owl';

  @override
  String get personalDetailsDipMorning => 'Morning';

  @override
  String get personalDetailsDipAfternoon => 'Afternoon';

  @override
  String get personalDetailsDipEvening => 'Evening';

  @override
  String get personalDetailsDipNone => 'No obvious dip';

  @override
  String get personalDetailsSessionShort => 'Short sessions';

  @override
  String get personalDetailsSessionMedium => 'Medium sessions';

  @override
  String get personalDetailsSessionLong => 'Long sessions';

  @override
  String get personalDetailsSupportGentle => 'Gentle';

  @override
  String get personalDetailsSupportStructured => 'Structured';

  @override
  String get personalDetailsSupportDirect => 'Direct';

  @override
  String get personalDetailsSupportWarm => 'Warm';

  @override
  String get personalDetailsWorkOffice => 'Office';

  @override
  String get personalDetailsWorkRemote => 'Remote';

  @override
  String get personalDetailsWorkHybrid => 'Hybrid';

  @override
  String get personalDetailsWorkShift => 'Shift';

  @override
  String get personalDetailsWorkFlexible => 'Flexible';

  @override
  String get personalDetailsWorkOther => 'Other';

  @override
  String get personalDetailsSleepStableOption => 'Stable';

  @override
  String get personalDetailsSleepUnstableOption => 'Unstable';

  @override
  String get personalDetailsSleepShiftOption => 'Shift';

  @override
  String get personalDetailsExperienceNone => 'No experience';

  @override
  String get personalDetailsExperienceBeginner => 'Beginner';

  @override
  String get personalDetailsExperienceIntermediate => 'Intermediate';

  @override
  String get personalDetailsExperienceAdvanced => 'Advanced';

  @override
  String get personalDetailsEmergencySelfHelp => 'Self-help';

  @override
  String get personalDetailsEmergencyContactPerson => 'Contact trusted person';

  @override
  String get personalDetailsEmergencyHotline => 'Reach out for help';

  @override
  String get personalDetailsEmergencyDepends => 'Depends on situation';

  @override
  String get personalDetailsTriggerWork => 'Work';

  @override
  String get personalDetailsTriggerCareer => 'Career';

  @override
  String get personalDetailsTriggerFamily => 'Family';

  @override
  String get personalDetailsTriggerRelationships => 'Relationships';

  @override
  String get personalDetailsTriggerSleep => 'Sleep';

  @override
  String get personalDetailsTriggerHealth => 'Health';

  @override
  String get personalDetailsTriggerMoney => 'Money';

  @override
  String get personalDetailsTriggerUncertainty => 'Uncertainty';

  @override
  String get personalDetailsTriggerAnxiety => 'Anxiety';

  @override
  String get personalDetailsTriggerSocial => 'Social life';

  @override
  String get personalDetailsSleepProblemFallingAsleep => 'Hard to fall asleep';

  @override
  String get personalDetailsSleepProblemNightWaking => 'Wake up at night';

  @override
  String get personalDetailsSleepProblemEarlyWaking => 'Early waking';

  @override
  String get personalDetailsSleepProblemLightSleep => 'Light sleep';

  @override
  String get personalDetailsSleepProblemRacingThoughts => 'Racing thoughts';

  @override
  String get personalDetailsSleepProblemIrregularSchedule =>
      'Irregular schedule';

  @override
  String get modesTitle => 'Modes';

  @override
  String get modesTopCardTitle => 'What helps you most often';

  @override
  String get modesTopCardSubtitle =>
      'Based on your current history, the mode most often completed is: Calm mode.';

  @override
  String get modesManualSelectionStressTitle => 'Manual mode selection';

  @override
  String get modesCreateSessionError =>
      'Could not create session. Please try again.';

  @override
  String modesOpenError(Object error) {
    return 'Could not open mode: $error';
  }

  @override
  String get modeCalmTitle => 'Calm mode';

  @override
  String get modeEnergyTitle => 'Need energy';

  @override
  String get modeSleepTitle => 'Sleep preparation';

  @override
  String get modeFocusTitle => 'I want to focus';

  @override
  String get modeVisualContactTitle => 'Visual contact with AI';

  @override
  String get modeVisualContactSubtitle =>
      'Start a conversation with an AI human in a visual contact format.';

  @override
  String get modeTrustedContactTitle => 'Contact a trusted person';

  @override
  String get modeTrustedContactSubtitle =>
      'If needed, you can quickly reach a trusted person.';

  @override
  String get myStateNowTitle => 'My state right now';

  @override
  String get stateUpdatesFromBiometrics =>
      'Your state is updated automatically based on biometrics.';

  @override
  String get professionProfileHelper =>
      'Choose your life context so recommendations are more accurate and useful.';

  @override
  String get historySummaryTitle => 'Quick summary';

  @override
  String get historySummarySubtitle =>
      'See which modes you actually use and come back to most.';

  @override
  String get historySummaryLaunches => 'Launches';

  @override
  String get historySummaryCompleted => 'Completed';

  @override
  String get historySummaryHelped => 'Helped';

  @override
  String get historyUsedModesTitle => 'Modes you already used';

  @override
  String get historyEmptyTitle => 'History is empty';

  @override
  String get historyEmptySubtitle =>
      'Once you start using modes, this screen will show what you return to, complete, and find helpful.';

  @override
  String get historyLoadError => 'Could not load history. Pull to try again.';

  @override
  String historyLastState(Object value) {
    return 'Last state: $value';
  }

  @override
  String historyRunsCount(int count) {
    return '$count launches';
  }

  @override
  String historyCompletedRunsCount(int count) {
    return '$count fully completed';
  }

  @override
  String historyHelpedRunsCount(int count) {
    return '$count helped';
  }

  @override
  String historyLastTime(Object value) {
    return 'Last time $value';
  }

  @override
  String historyCompletionRate(Object value) {
    return 'Completion rate: $value';
  }

  @override
  String historyAverageDuration(Object value) {
    return 'Average duration: $value';
  }

  @override
  String historySheetRunsCompleted(int runs, int completed) {
    return 'Launches: $runs • Fully completed: $completed';
  }

  @override
  String historySheetHelped(int count) {
    return 'Helped: $count';
  }

  @override
  String get historySheetHelpedNone => 'Helped: —';

  @override
  String historyStateLabel(Object value) {
    return 'State: $value';
  }

  @override
  String historyDurationLabel(Object value) {
    return 'Lasted $value';
  }

  @override
  String historyResultLabel(Object value) {
    return 'Result: $value';
  }

  @override
  String historyCommentLabel(Object value) {
    return 'Comment: $value';
  }

  @override
  String get historyStatusCompleted => 'completed';

  @override
  String get historyStatusActive => 'active';

  @override
  String get historyStatusNoStatus => 'no status';

  @override
  String get historyResultHelped => 'helped';

  @override
  String get historyResultNeutral => 'neutral';

  @override
  String get historyResultNotHelped => 'didn\'t help';

  @override
  String historySecondsShort(int count) {
    return '$count sec';
  }

  @override
  String historyMinutesShort(int count) {
    return '$count min';
  }

  @override
  String historyHoursShort(int count) {
    return '$count h';
  }

  @override
  String historyHoursMinutesShort(int hours, int minutes) {
    return '$hours h $minutes min';
  }
}
