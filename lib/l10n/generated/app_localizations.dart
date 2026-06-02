import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_he.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('he'),
    Locale('ru'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'MindReset AI'**
  String get appTitle;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @greeting.
  ///
  /// In en, this message translates to:
  /// **'Hello, {name}'**
  String greeting(Object name);

  /// No description provided for @notesCount.
  ///
  /// In en, this message translates to:
  /// **'Notes count: {count}'**
  String notesCount(Object count);

  /// No description provided for @yourNotes.
  ///
  /// In en, this message translates to:
  /// **'Your notes'**
  String get yourNotes;

  /// No description provided for @noNotes.
  ///
  /// In en, this message translates to:
  /// **'No notes yet'**
  String get noNotes;

  /// No description provided for @nameLabel.
  ///
  /// In en, this message translates to:
  /// **'Name: {name}'**
  String nameLabel(Object name);

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email: {email}'**
  String emailLabel(Object email);

  /// No description provided for @statusNormal.
  ///
  /// In en, this message translates to:
  /// **'State is normal'**
  String get statusNormal;

  /// No description provided for @statusAttention.
  ///
  /// In en, this message translates to:
  /// **'Signs of tension'**
  String get statusAttention;

  /// No description provided for @statusWarning.
  ///
  /// In en, this message translates to:
  /// **'State differs from normal'**
  String get statusWarning;

  /// No description provided for @statusCritical.
  ///
  /// In en, this message translates to:
  /// **'Immediate support needed'**
  String get statusCritical;

  /// No description provided for @lastUpdated.
  ///
  /// In en, this message translates to:
  /// **'Last updated: {time}'**
  String lastUpdated(Object time);

  /// No description provided for @voiceNote.
  ///
  /// In en, this message translates to:
  /// **'Voice'**
  String get voiceNote;

  /// No description provided for @textNote.
  ///
  /// In en, this message translates to:
  /// **'Text'**
  String get textNote;

  /// No description provided for @logoutTooltip.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logoutTooltip;

  /// No description provided for @profileTooltip.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTooltip;

  /// No description provided for @userFallbackName.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get userFallbackName;

  /// No description provided for @profileSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your account, context\nand settings'**
  String get profileSubtitle;

  /// No description provided for @accountSection.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get accountSection;

  /// No description provided for @appSection.
  ///
  /// In en, this message translates to:
  /// **'App'**
  String get appSection;

  /// No description provided for @personalDataTitle.
  ///
  /// In en, this message translates to:
  /// **'Personal details'**
  String get personalDataTitle;

  /// No description provided for @personalDataSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Language, time zone, daily rhythm and personalization.'**
  String get personalDataSubtitle;

  /// No description provided for @billingTitle.
  ///
  /// In en, this message translates to:
  /// **'Billing and subscription'**
  String get billingTitle;

  /// No description provided for @billingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Current plan, trial and subscription management.'**
  String get billingSubtitle;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications, theme, privacy and app language.'**
  String get settingsSubtitle;

  /// No description provided for @supportTitle.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get supportTitle;

  /// No description provided for @supportSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Help, feedback and terms of use.'**
  String get supportSubtitle;

  /// No description provided for @signingOut.
  ///
  /// In en, this message translates to:
  /// **'Signing out...'**
  String get signingOut;

  /// No description provided for @signOutAccount.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get signOutAccount;

  /// No description provided for @savingProfessionProfile.
  ///
  /// In en, this message translates to:
  /// **'Saving professional profile...'**
  String get savingProfessionProfile;

  /// No description provided for @profileLoadError.
  ///
  /// In en, this message translates to:
  /// **'Failed to load profile: {error}'**
  String profileLoadError(Object error);

  /// No description provided for @professionSaved.
  ///
  /// In en, this message translates to:
  /// **'Professional profile saved'**
  String get professionSaved;

  /// No description provided for @professionSaveError.
  ///
  /// In en, this message translates to:
  /// **'Save failed: {error}'**
  String professionSaveError(Object error);

  /// No description provided for @signOutDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign out of your account?'**
  String get signOutDialogTitle;

  /// No description provided for @signOutDialogMessage.
  ///
  /// In en, this message translates to:
  /// **'You will leave the current account and return to the sign-in screen.'**
  String get signOutDialogMessage;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get signOut;

  /// No description provided for @signOutError.
  ///
  /// In en, this message translates to:
  /// **'Could not sign out: {error}'**
  String signOutError(Object error);

  /// No description provided for @nameFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get nameFieldLabel;

  /// No description provided for @brandLabel.
  ///
  /// In en, this message translates to:
  /// **'MindReset'**
  String get brandLabel;

  /// No description provided for @currentContextTitle.
  ///
  /// In en, this message translates to:
  /// **'YOUR CURRENT CONTEXT'**
  String get currentContextTitle;

  /// No description provided for @professionalProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Professional profile'**
  String get professionalProfileTitle;

  /// No description provided for @goodMorning.
  ///
  /// In en, this message translates to:
  /// **'Good morning,'**
  String get goodMorning;

  /// No description provided for @goodAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good afternoon,'**
  String get goodAfternoon;

  /// No description provided for @goodEvening.
  ///
  /// In en, this message translates to:
  /// **'Good evening,'**
  String get goodEvening;

  /// No description provided for @heartRateCurrent.
  ///
  /// In en, this message translates to:
  /// **'Current heart rate'**
  String get heartRateCurrent;

  /// No description provided for @heartRateUpdating.
  ///
  /// In en, this message translates to:
  /// **'Updating heart rate'**
  String get heartRateUpdating;

  /// No description provided for @stressIndexLabel.
  ///
  /// In en, this message translates to:
  /// **'Stress index'**
  String get stressIndexLabel;

  /// No description provided for @stressIndexCalculating.
  ///
  /// In en, this message translates to:
  /// **'Calculating stress'**
  String get stressIndexCalculating;

  /// No description provided for @noData.
  ///
  /// In en, this message translates to:
  /// **'No data'**
  String get noData;

  /// No description provided for @bpm.
  ///
  /// In en, this message translates to:
  /// **'{value} bpm'**
  String bpm(Object value);

  /// No description provided for @recommendedKeepRhythm.
  ///
  /// In en, this message translates to:
  /// **'Recommended: keep your rhythm'**
  String get recommendedKeepRhythm;

  /// No description provided for @recommendedShortReset.
  ///
  /// In en, this message translates to:
  /// **'Recommended: short reset'**
  String get recommendedShortReset;

  /// No description provided for @recommendedRecovery.
  ///
  /// In en, this message translates to:
  /// **'Recommended: recovery'**
  String get recommendedRecovery;

  /// No description provided for @recommendedUrgentHelp.
  ///
  /// In en, this message translates to:
  /// **'Recommended: urgent help'**
  String get recommendedUrgentHelp;

  /// No description provided for @recommendedHelp.
  ///
  /// In en, this message translates to:
  /// **'Recommended: support'**
  String get recommendedHelp;

  /// No description provided for @aiRecommendsFastCalming.
  ///
  /// In en, this message translates to:
  /// **'AI recommends fast calming'**
  String get aiRecommendsFastCalming;

  /// No description provided for @aiRecommendsEnergyBoost.
  ///
  /// In en, this message translates to:
  /// **'AI recommends a gentle energy boost'**
  String get aiRecommendsEnergyBoost;

  /// No description provided for @aiRecommendsCarefulRecovery.
  ///
  /// In en, this message translates to:
  /// **'AI recommends gentle recovery'**
  String get aiRecommendsCarefulRecovery;

  /// No description provided for @aiRecommendsShortPractice.
  ///
  /// In en, this message translates to:
  /// **'AI recommends a short practice'**
  String get aiRecommendsShortPractice;

  /// No description provided for @aiRecommendsSuitableMode.
  ///
  /// In en, this message translates to:
  /// **'AI recommends a suitable mode'**
  String get aiRecommendsSuitableMode;

  /// No description provided for @stableStateDescription.
  ///
  /// In en, this message translates to:
  /// **'Your state looks stable. You can choose a gentle support mode or leave things as they are.'**
  String get stableStateDescription;

  /// No description provided for @tensionStateDescription.
  ///
  /// In en, this message translates to:
  /// **'There are signs of tension. It is better to take a short pause and stabilize gently.'**
  String get tensionStateDescription;

  /// No description provided for @highLoadDescription.
  ///
  /// In en, this message translates to:
  /// **'Your load has increased. It is better to start recovery or switch to a suitable support mode.'**
  String get highLoadDescription;

  /// No description provided for @criticalStateDescription.
  ///
  /// In en, this message translates to:
  /// **'Your state needs attention right now. You can start an intervention or open visual contact with AI.'**
  String get criticalStateDescription;

  /// No description provided for @chooseSupportFormat.
  ///
  /// In en, this message translates to:
  /// **'Choose the support format that fits you.'**
  String get chooseSupportFormat;

  /// No description provided for @shortPracticeDuration.
  ///
  /// In en, this message translates to:
  /// **'a short 3–5 minute practice'**
  String get shortPracticeDuration;

  /// No description provided for @longPracticeDuration.
  ///
  /// In en, this message translates to:
  /// **'a deeper 10–15 minute practice'**
  String get longPracticeDuration;

  /// No description provided for @mediumPracticeDuration.
  ///
  /// In en, this message translates to:
  /// **'a balanced 5–10 minute practice'**
  String get mediumPracticeDuration;

  /// No description provided for @toneCalming.
  ///
  /// In en, this message translates to:
  /// **'to reduce tension'**
  String get toneCalming;

  /// No description provided for @toneEnergizing.
  ///
  /// In en, this message translates to:
  /// **'to restore energy and clarity'**
  String get toneEnergizing;

  /// No description provided for @toneBalanced.
  ///
  /// In en, this message translates to:
  /// **'to maintain a steady state'**
  String get toneBalanced;

  /// No description provided for @aiPersonalRecommendation.
  ///
  /// In en, this message translates to:
  /// **'Based on your profile, AI recommends {duration} {tone}.'**
  String aiPersonalRecommendation(Object duration, Object tone);

  /// No description provided for @modeUrgentHelp.
  ///
  /// In en, this message translates to:
  /// **'Urgent help'**
  String get modeUrgentHelp;

  /// No description provided for @modeSleepPreparation.
  ///
  /// In en, this message translates to:
  /// **'Sleep preparation'**
  String get modeSleepPreparation;

  /// No description provided for @modeNeedEnergy.
  ///
  /// In en, this message translates to:
  /// **'Need energy'**
  String get modeNeedEnergy;

  /// No description provided for @modeQuickReset.
  ///
  /// In en, this message translates to:
  /// **'Quick reset'**
  String get modeQuickReset;

  /// No description provided for @modeCalm.
  ///
  /// In en, this message translates to:
  /// **'Calm mode'**
  String get modeCalm;

  /// No description provided for @modeRecovery.
  ///
  /// In en, this message translates to:
  /// **'Recovery'**
  String get modeRecovery;

  /// No description provided for @modeSuitableHelp.
  ///
  /// In en, this message translates to:
  /// **'Suitable support'**
  String get modeSuitableHelp;

  /// No description provided for @modeFocus.
  ///
  /// In en, this message translates to:
  /// **'Want to focus'**
  String get modeFocus;

  /// No description provided for @modeSoftSupport.
  ///
  /// In en, this message translates to:
  /// **'Gentle support'**
  String get modeSoftSupport;

  /// No description provided for @resumeSessionTitle.
  ///
  /// In en, this message translates to:
  /// **'Resume session'**
  String get resumeSessionTitle;

  /// No description provided for @openModesTitle.
  ///
  /// In en, this message translates to:
  /// **'Open modes'**
  String get openModesTitle;

  /// No description provided for @openModesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Go to all available practices.'**
  String get openModesSubtitle;

  /// No description provided for @sessionMeta.
  ///
  /// In en, this message translates to:
  /// **'{modeTitle} · {stressTitle}'**
  String sessionMeta(Object modeTitle, Object stressTitle);

  /// No description provided for @personalDataBirthDate.
  ///
  /// In en, this message translates to:
  /// **'Birth date'**
  String get personalDataBirthDate;

  /// No description provided for @personalDataDateNotSelected.
  ///
  /// In en, this message translates to:
  /// **'Not selected'**
  String get personalDataDateNotSelected;

  /// No description provided for @personalDataGender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get personalDataGender;

  /// No description provided for @personalDataGenderMale.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get personalDataGenderMale;

  /// No description provided for @personalDataGenderFemale.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get personalDataGenderFemale;

  /// No description provided for @personalDataCity.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get personalDataCity;

  /// No description provided for @personalDataOccupation.
  ///
  /// In en, this message translates to:
  /// **'Occupation'**
  String get personalDataOccupation;

  /// No description provided for @personalDataRelationshipStatus.
  ///
  /// In en, this message translates to:
  /// **'Relationship status'**
  String get personalDataRelationshipStatus;

  /// No description provided for @personalDataRelationshipSingle.
  ///
  /// In en, this message translates to:
  /// **'Single'**
  String get personalDataRelationshipSingle;

  /// No description provided for @personalDataRelationshipInRelationship.
  ///
  /// In en, this message translates to:
  /// **'In a relationship'**
  String get personalDataRelationshipInRelationship;

  /// No description provided for @personalDataRelationshipMarried.
  ///
  /// In en, this message translates to:
  /// **'Married'**
  String get personalDataRelationshipMarried;

  /// No description provided for @personalDataRelationshipDivorced.
  ///
  /// In en, this message translates to:
  /// **'Divorced'**
  String get personalDataRelationshipDivorced;

  /// No description provided for @personalDataHasChildren.
  ///
  /// In en, this message translates to:
  /// **'Has children'**
  String get personalDataHasChildren;

  /// No description provided for @personalDataSleepSchedule.
  ///
  /// In en, this message translates to:
  /// **'Sleep schedule'**
  String get personalDataSleepSchedule;

  /// No description provided for @personalDataSleepStable.
  ///
  /// In en, this message translates to:
  /// **'Stable'**
  String get personalDataSleepStable;

  /// No description provided for @personalDataSleepUnstable.
  ///
  /// In en, this message translates to:
  /// **'Unstable'**
  String get personalDataSleepUnstable;

  /// No description provided for @personalDataSleepShift.
  ///
  /// In en, this message translates to:
  /// **'Shift schedule'**
  String get personalDataSleepShift;

  /// No description provided for @personalDataStressLevel.
  ///
  /// In en, this message translates to:
  /// **'Stress: {value}/10'**
  String personalDataStressLevel(int value);

  /// No description provided for @personalDataEnergyLevel.
  ///
  /// In en, this message translates to:
  /// **'Energy: {value}/10'**
  String personalDataEnergyLevel(int value);

  /// No description provided for @personalDataGoals.
  ///
  /// In en, this message translates to:
  /// **'Goals'**
  String get personalDataGoals;

  /// No description provided for @personalDataSaving.
  ///
  /// In en, this message translates to:
  /// **'Saving...'**
  String get personalDataSaving;

  /// No description provided for @personalDataSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get personalDataSave;

  /// No description provided for @personalDataSaveError.
  ///
  /// In en, this message translates to:
  /// **'Save error: {error}'**
  String personalDataSaveError(String error);

  /// No description provided for @tabHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get tabHome;

  /// No description provided for @tabModes.
  ///
  /// In en, this message translates to:
  /// **'Modes'**
  String get tabModes;

  /// No description provided for @tabHistory.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get tabHistory;

  /// No description provided for @tabProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get tabProfile;

  /// No description provided for @stateCalmTitle.
  ///
  /// In en, this message translates to:
  /// **'Calm'**
  String get stateCalmTitle;

  /// No description provided for @stateCalmDescription.
  ///
  /// In en, this message translates to:
  /// **'Your state looks stable. You can keep your rhythm and gently support yourself through the day.'**
  String get stateCalmDescription;

  /// No description provided for @stateCalmAction.
  ///
  /// In en, this message translates to:
  /// **'Keep the rhythm'**
  String get stateCalmAction;

  /// No description provided for @stateTenseTitle.
  ///
  /// In en, this message translates to:
  /// **'Tension'**
  String get stateTenseTitle;

  /// No description provided for @stateTenseDescription.
  ///
  /// In en, this message translates to:
  /// **'There are signs of inner tension. It is better to take a short pause, breathe out and gently stabilize.'**
  String get stateTenseDescription;

  /// No description provided for @stateTenseAction.
  ///
  /// In en, this message translates to:
  /// **'Start a reset'**
  String get stateTenseAction;

  /// No description provided for @stateOverloadedTitle.
  ///
  /// In en, this message translates to:
  /// **'Overloaded'**
  String get stateOverloadedTitle;

  /// No description provided for @stateOverloadedDescription.
  ///
  /// In en, this message translates to:
  /// **'Your load has increased. It is important to lower the inner noise, restore grounding and bring back some clarity.'**
  String get stateOverloadedDescription;

  /// No description provided for @stateOverloadedAction.
  ///
  /// In en, this message translates to:
  /// **'Start recovery'**
  String get stateOverloadedAction;

  /// No description provided for @stateCriticalTitle.
  ///
  /// In en, this message translates to:
  /// **'Critical'**
  String get stateCriticalTitle;

  /// No description provided for @stateCriticalDescription.
  ///
  /// In en, this message translates to:
  /// **'Your state needs attention right now. It is better not to wait and go to more direct and supportive help.'**
  String get stateCriticalDescription;

  /// No description provided for @stateCriticalAction.
  ///
  /// In en, this message translates to:
  /// **'Get help'**
  String get stateCriticalAction;

  /// No description provided for @professionCategoryLifestyleTitle.
  ///
  /// In en, this message translates to:
  /// **'Life context'**
  String get professionCategoryLifestyleTitle;

  /// No description provided for @professionCategoryWorkTitle.
  ///
  /// In en, this message translates to:
  /// **'Work and career'**
  String get professionCategoryWorkTitle;

  /// No description provided for @professionCategoryServiceTitle.
  ///
  /// In en, this message translates to:
  /// **'Service and high load'**
  String get professionCategoryServiceTitle;

  /// No description provided for @professionSelectorHelper.
  ///
  /// In en, this message translates to:
  /// **'Choose your life context so recommendations become more accurate and useful.'**
  String get professionSelectorHelper;

  /// No description provided for @professionPickerTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose a professional profile'**
  String get professionPickerTitle;

  /// No description provided for @professionPickerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'This helps tailor recommendations and support flows more precisely.'**
  String get professionPickerSubtitle;

  /// No description provided for @professionStudentTitle.
  ///
  /// In en, this message translates to:
  /// **'Student'**
  String get professionStudentTitle;

  /// No description provided for @professionStudentSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Study, exams, deadlines, and concentration.'**
  String get professionStudentSubtitle;

  /// No description provided for @professionStudentShort.
  ///
  /// In en, this message translates to:
  /// **'Student'**
  String get professionStudentShort;

  /// No description provided for @professionOfficeWorkerTitle.
  ///
  /// In en, this message translates to:
  /// **'Office worker'**
  String get professionOfficeWorkerTitle;

  /// No description provided for @professionOfficeWorkerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Work schedule, meetings, workload, and balance.'**
  String get professionOfficeWorkerSubtitle;

  /// No description provided for @professionOfficeWorkerShort.
  ///
  /// In en, this message translates to:
  /// **'Office'**
  String get professionOfficeWorkerShort;

  /// No description provided for @professionFreelancerTitle.
  ///
  /// In en, this message translates to:
  /// **'Freelancer'**
  String get professionFreelancerTitle;

  /// No description provided for @professionFreelancerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Flexible rhythm, projects, and self-organization.'**
  String get professionFreelancerSubtitle;

  /// No description provided for @professionFreelancerShort.
  ///
  /// In en, this message translates to:
  /// **'Freelance'**
  String get professionFreelancerShort;

  /// No description provided for @professionEntrepreneurTitle.
  ///
  /// In en, this message translates to:
  /// **'Entrepreneur'**
  String get professionEntrepreneurTitle;

  /// No description provided for @professionEntrepreneurSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Responsibility, decisions, and a high pace.'**
  String get professionEntrepreneurSubtitle;

  /// No description provided for @professionEntrepreneurShort.
  ///
  /// In en, this message translates to:
  /// **'Business'**
  String get professionEntrepreneurShort;

  /// No description provided for @professionManagerTitle.
  ///
  /// In en, this message translates to:
  /// **'Manager'**
  String get professionManagerTitle;

  /// No description provided for @professionManagerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Team, deadlines, and stress management.'**
  String get professionManagerSubtitle;

  /// No description provided for @professionManagerShort.
  ///
  /// In en, this message translates to:
  /// **'Manager'**
  String get professionManagerShort;

  /// No description provided for @professionJobSeekerTitle.
  ///
  /// In en, this message translates to:
  /// **'Job seeker'**
  String get professionJobSeekerTitle;

  /// No description provided for @professionJobSeekerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Uncertainty, search, and motivation support.'**
  String get professionJobSeekerSubtitle;

  /// No description provided for @professionJobSeekerShort.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get professionJobSeekerShort;

  /// No description provided for @professionCaregiverTitle.
  ///
  /// In en, this message translates to:
  /// **'Caregiver'**
  String get professionCaregiverTitle;

  /// No description provided for @professionCaregiverSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Caring for loved ones, energy, and recovery.'**
  String get professionCaregiverSubtitle;

  /// No description provided for @professionCaregiverShort.
  ///
  /// In en, this message translates to:
  /// **'Family'**
  String get professionCaregiverShort;

  /// No description provided for @professionHealthcareWorkerTitle.
  ///
  /// In en, this message translates to:
  /// **'Healthcare worker'**
  String get professionHealthcareWorkerTitle;

  /// No description provided for @professionHealthcareWorkerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Shifts, high responsibility, and emotional load.'**
  String get professionHealthcareWorkerSubtitle;

  /// No description provided for @professionHealthcareWorkerShort.
  ///
  /// In en, this message translates to:
  /// **'Healthcare'**
  String get professionHealthcareWorkerShort;

  /// No description provided for @professionMilitaryOrReservistTitle.
  ///
  /// In en, this message translates to:
  /// **'Military / reservist'**
  String get professionMilitaryOrReservistTitle;

  /// No description provided for @professionMilitaryOrReservistSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Heightened readiness, tension, discipline, and adaptation.'**
  String get professionMilitaryOrReservistSubtitle;

  /// No description provided for @professionMilitaryOrReservistShort.
  ///
  /// In en, this message translates to:
  /// **'Service'**
  String get professionMilitaryOrReservistShort;

  /// No description provided for @professionPoliceOfficerTitle.
  ///
  /// In en, this message translates to:
  /// **'Police officer'**
  String get professionPoliceOfficerTitle;

  /// No description provided for @professionPoliceOfficerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Alertness, stressful situations, and quick recovery.'**
  String get professionPoliceOfficerSubtitle;

  /// No description provided for @professionPoliceOfficerShort.
  ///
  /// In en, this message translates to:
  /// **'Police'**
  String get professionPoliceOfficerShort;

  /// No description provided for @professionFirefighterTitle.
  ///
  /// In en, this message translates to:
  /// **'Firefighter'**
  String get professionFirefighterTitle;

  /// No description provided for @professionFirefighterSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Emergency calls, endurance, and high load.'**
  String get professionFirefighterSubtitle;

  /// No description provided for @professionFirefighterShort.
  ///
  /// In en, this message translates to:
  /// **'Firefighter'**
  String get professionFirefighterShort;

  /// No description provided for @professionDriverTitle.
  ///
  /// In en, this message translates to:
  /// **'Driver'**
  String get professionDriverTitle;

  /// No description provided for @professionDriverSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Road, concentration, fatigue, routine, and safety.'**
  String get professionDriverSubtitle;

  /// No description provided for @professionDriverShort.
  ///
  /// In en, this message translates to:
  /// **'Driver'**
  String get professionDriverShort;

  /// No description provided for @professionOtherTitle.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get professionOtherTitle;

  /// No description provided for @professionOtherSubtitle.
  ///
  /// In en, this message translates to:
  /// **'A universal mode without narrow specialization.'**
  String get professionOtherSubtitle;

  /// No description provided for @professionOtherShort.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get professionOtherShort;

  /// No description provided for @personalDetailsBasicsTitle.
  ///
  /// In en, this message translates to:
  /// **'Basics'**
  String get personalDetailsBasicsTitle;

  /// No description provided for @personalDetailsBasicsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Core personalization settings.'**
  String get personalDetailsBasicsSubtitle;

  /// No description provided for @personalDetailsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get personalDetailsLanguage;

  /// No description provided for @personalDetailsTimeZone.
  ///
  /// In en, this message translates to:
  /// **'Time zone'**
  String get personalDetailsTimeZone;

  /// No description provided for @personalDetailsTimeZoneHint.
  ///
  /// In en, this message translates to:
  /// **'If the user is in another region, keep the saved profile time zone value.'**
  String get personalDetailsTimeZoneHint;

  /// No description provided for @personalDetailsDailyRhythmTitle.
  ///
  /// In en, this message translates to:
  /// **'Daily rhythm'**
  String get personalDetailsDailyRhythmTitle;

  /// No description provided for @personalDetailsDailyRhythmSubtitle.
  ///
  /// In en, this message translates to:
  /// **'When and how it is easier for you to practice.'**
  String get personalDetailsDailyRhythmSubtitle;

  /// No description provided for @personalDetailsDailyRoutine.
  ///
  /// In en, this message translates to:
  /// **'Daily routine'**
  String get personalDetailsDailyRoutine;

  /// No description provided for @personalDetailsEnergyDip.
  ///
  /// In en, this message translates to:
  /// **'Energy dip'**
  String get personalDetailsEnergyDip;

  /// No description provided for @personalDetailsSessionFormat.
  ///
  /// In en, this message translates to:
  /// **'Session format'**
  String get personalDetailsSessionFormat;

  /// No description provided for @personalDetailsWorkFormat.
  ///
  /// In en, this message translates to:
  /// **'Work format'**
  String get personalDetailsWorkFormat;

  /// No description provided for @personalDetailsSleepScheduleLabel.
  ///
  /// In en, this message translates to:
  /// **'Sleep schedule'**
  String get personalDetailsSleepScheduleLabel;

  /// No description provided for @personalDetailsHasChildrenLabel.
  ///
  /// In en, this message translates to:
  /// **'Has children'**
  String get personalDetailsHasChildrenLabel;

  /// No description provided for @personalDetailsStateTitle.
  ///
  /// In en, this message translates to:
  /// **'State'**
  String get personalDetailsStateTitle;

  /// No description provided for @personalDetailsStateSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Used to choose tone and intervention type.'**
  String get personalDetailsStateSubtitle;

  /// No description provided for @personalDetailsCurrentStress.
  ///
  /// In en, this message translates to:
  /// **'Current stress'**
  String get personalDetailsCurrentStress;

  /// No description provided for @personalDetailsCurrentEnergy.
  ///
  /// In en, this message translates to:
  /// **'Current energy'**
  String get personalDetailsCurrentEnergy;

  /// No description provided for @personalDetailsSupportSystem.
  ///
  /// In en, this message translates to:
  /// **'Support system'**
  String get personalDetailsSupportSystem;

  /// No description provided for @personalDetailsLow.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get personalDetailsLow;

  /// No description provided for @personalDetailsHigh.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get personalDetailsHigh;

  /// No description provided for @personalDetailsWeak.
  ///
  /// In en, this message translates to:
  /// **'Weak'**
  String get personalDetailsWeak;

  /// No description provided for @personalDetailsStrong.
  ///
  /// In en, this message translates to:
  /// **'Strong'**
  String get personalDetailsStrong;

  /// No description provided for @personalDetailsSupportStyle.
  ///
  /// In en, this message translates to:
  /// **'Support style'**
  String get personalDetailsSupportStyle;

  /// No description provided for @personalDetailsSelfHelpExperience.
  ///
  /// In en, this message translates to:
  /// **'Self-help experience'**
  String get personalDetailsSelfHelpExperience;

  /// No description provided for @personalDetailsEmergencyHelp.
  ///
  /// In en, this message translates to:
  /// **'Emergency help'**
  String get personalDetailsEmergencyHelp;

  /// No description provided for @personalDetailsCrisisPlanTitle.
  ///
  /// In en, this message translates to:
  /// **'Crisis plan'**
  String get personalDetailsCrisisPlanTitle;

  /// No description provided for @personalDetailsCrisisPlanSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Quick access to support actions.'**
  String get personalDetailsCrisisPlanSubtitle;

  /// No description provided for @personalDetailsTriggersSleepTitle.
  ///
  /// In en, this message translates to:
  /// **'Triggers and sleep'**
  String get personalDetailsTriggersSleepTitle;

  /// No description provided for @personalDetailsTriggersSleepSubtitle.
  ///
  /// In en, this message translates to:
  /// **'You can choose several options.'**
  String get personalDetailsTriggersSleepSubtitle;

  /// No description provided for @personalDetailsStressTriggersTitle.
  ///
  /// In en, this message translates to:
  /// **'What most often triggers stress'**
  String get personalDetailsStressTriggersTitle;

  /// No description provided for @personalDetailsChooseAllThatApply.
  ///
  /// In en, this message translates to:
  /// **'Choose all that apply.'**
  String get personalDetailsChooseAllThatApply;

  /// No description provided for @personalDetailsSleepProblemsTitle.
  ///
  /// In en, this message translates to:
  /// **'Sleep problems'**
  String get personalDetailsSleepProblemsTitle;

  /// No description provided for @personalDetailsChooseAllThatFit.
  ///
  /// In en, this message translates to:
  /// **'Choose all that fit.'**
  String get personalDetailsChooseAllThatFit;

  /// No description provided for @personalDetailsGoalsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Briefly describe what you want to improve.'**
  String get personalDetailsGoalsSubtitle;

  /// No description provided for @personalDetailsGoalsHint.
  ///
  /// In en, this message translates to:
  /// **'For example: less anxiety and better sleep'**
  String get personalDetailsGoalsHint;

  /// No description provided for @personalDetailsTrustedContactTitle.
  ///
  /// In en, this message translates to:
  /// **'Trusted contact'**
  String get personalDetailsTrustedContactTitle;

  /// No description provided for @personalDetailsTrustedContactSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Someone you can quickly call or message in a difficult moment.'**
  String get personalDetailsTrustedContactSubtitle;

  /// No description provided for @personalDetailsName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get personalDetailsName;

  /// No description provided for @personalDetailsNameHint.
  ///
  /// In en, this message translates to:
  /// **'For example: Anna'**
  String get personalDetailsNameHint;

  /// No description provided for @personalDetailsPhone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get personalDetailsPhone;

  /// No description provided for @personalDetailsNote.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get personalDetailsNote;

  /// No description provided for @personalDetailsNoteHint.
  ///
  /// In en, this message translates to:
  /// **'For example: sister, better to text on WhatsApp'**
  String get personalDetailsNoteHint;

  /// No description provided for @personalDetailsClearContact.
  ///
  /// In en, this message translates to:
  /// **'Clear contact'**
  String get personalDetailsClearContact;

  /// No description provided for @personalDetailsRoutineEarlyBird.
  ///
  /// In en, this message translates to:
  /// **'Early bird'**
  String get personalDetailsRoutineEarlyBird;

  /// No description provided for @personalDetailsRoutineBalanced.
  ///
  /// In en, this message translates to:
  /// **'Balanced'**
  String get personalDetailsRoutineBalanced;

  /// No description provided for @personalDetailsRoutineNightOwl.
  ///
  /// In en, this message translates to:
  /// **'Night owl'**
  String get personalDetailsRoutineNightOwl;

  /// No description provided for @personalDetailsDipMorning.
  ///
  /// In en, this message translates to:
  /// **'Morning'**
  String get personalDetailsDipMorning;

  /// No description provided for @personalDetailsDipAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Afternoon'**
  String get personalDetailsDipAfternoon;

  /// No description provided for @personalDetailsDipEvening.
  ///
  /// In en, this message translates to:
  /// **'Evening'**
  String get personalDetailsDipEvening;

  /// No description provided for @personalDetailsDipNone.
  ///
  /// In en, this message translates to:
  /// **'No obvious dip'**
  String get personalDetailsDipNone;

  /// No description provided for @personalDetailsSessionShort.
  ///
  /// In en, this message translates to:
  /// **'Short sessions'**
  String get personalDetailsSessionShort;

  /// No description provided for @personalDetailsSessionMedium.
  ///
  /// In en, this message translates to:
  /// **'Medium sessions'**
  String get personalDetailsSessionMedium;

  /// No description provided for @personalDetailsSessionLong.
  ///
  /// In en, this message translates to:
  /// **'Long sessions'**
  String get personalDetailsSessionLong;

  /// No description provided for @personalDetailsSupportGentle.
  ///
  /// In en, this message translates to:
  /// **'Gentle'**
  String get personalDetailsSupportGentle;

  /// No description provided for @personalDetailsSupportStructured.
  ///
  /// In en, this message translates to:
  /// **'Structured'**
  String get personalDetailsSupportStructured;

  /// No description provided for @personalDetailsSupportDirect.
  ///
  /// In en, this message translates to:
  /// **'Direct'**
  String get personalDetailsSupportDirect;

  /// No description provided for @personalDetailsSupportWarm.
  ///
  /// In en, this message translates to:
  /// **'Warm'**
  String get personalDetailsSupportWarm;

  /// No description provided for @personalDetailsWorkOffice.
  ///
  /// In en, this message translates to:
  /// **'Office'**
  String get personalDetailsWorkOffice;

  /// No description provided for @personalDetailsWorkRemote.
  ///
  /// In en, this message translates to:
  /// **'Remote'**
  String get personalDetailsWorkRemote;

  /// No description provided for @personalDetailsWorkHybrid.
  ///
  /// In en, this message translates to:
  /// **'Hybrid'**
  String get personalDetailsWorkHybrid;

  /// No description provided for @personalDetailsWorkShift.
  ///
  /// In en, this message translates to:
  /// **'Shift'**
  String get personalDetailsWorkShift;

  /// No description provided for @personalDetailsWorkFlexible.
  ///
  /// In en, this message translates to:
  /// **'Flexible'**
  String get personalDetailsWorkFlexible;

  /// No description provided for @personalDetailsWorkOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get personalDetailsWorkOther;

  /// No description provided for @personalDetailsSleepStableOption.
  ///
  /// In en, this message translates to:
  /// **'Stable'**
  String get personalDetailsSleepStableOption;

  /// No description provided for @personalDetailsSleepUnstableOption.
  ///
  /// In en, this message translates to:
  /// **'Unstable'**
  String get personalDetailsSleepUnstableOption;

  /// No description provided for @personalDetailsSleepShiftOption.
  ///
  /// In en, this message translates to:
  /// **'Shift'**
  String get personalDetailsSleepShiftOption;

  /// No description provided for @personalDetailsExperienceNone.
  ///
  /// In en, this message translates to:
  /// **'No experience'**
  String get personalDetailsExperienceNone;

  /// No description provided for @personalDetailsExperienceBeginner.
  ///
  /// In en, this message translates to:
  /// **'Beginner'**
  String get personalDetailsExperienceBeginner;

  /// No description provided for @personalDetailsExperienceIntermediate.
  ///
  /// In en, this message translates to:
  /// **'Intermediate'**
  String get personalDetailsExperienceIntermediate;

  /// No description provided for @personalDetailsExperienceAdvanced.
  ///
  /// In en, this message translates to:
  /// **'Advanced'**
  String get personalDetailsExperienceAdvanced;

  /// No description provided for @personalDetailsEmergencySelfHelp.
  ///
  /// In en, this message translates to:
  /// **'Self-help'**
  String get personalDetailsEmergencySelfHelp;

  /// No description provided for @personalDetailsEmergencyContactPerson.
  ///
  /// In en, this message translates to:
  /// **'Contact trusted person'**
  String get personalDetailsEmergencyContactPerson;

  /// No description provided for @personalDetailsEmergencyHotline.
  ///
  /// In en, this message translates to:
  /// **'Reach out for help'**
  String get personalDetailsEmergencyHotline;

  /// No description provided for @personalDetailsEmergencyDepends.
  ///
  /// In en, this message translates to:
  /// **'Depends on situation'**
  String get personalDetailsEmergencyDepends;

  /// No description provided for @personalDetailsTriggerWork.
  ///
  /// In en, this message translates to:
  /// **'Work'**
  String get personalDetailsTriggerWork;

  /// No description provided for @personalDetailsTriggerCareer.
  ///
  /// In en, this message translates to:
  /// **'Career'**
  String get personalDetailsTriggerCareer;

  /// No description provided for @personalDetailsTriggerFamily.
  ///
  /// In en, this message translates to:
  /// **'Family'**
  String get personalDetailsTriggerFamily;

  /// No description provided for @personalDetailsTriggerRelationships.
  ///
  /// In en, this message translates to:
  /// **'Relationships'**
  String get personalDetailsTriggerRelationships;

  /// No description provided for @personalDetailsTriggerSleep.
  ///
  /// In en, this message translates to:
  /// **'Sleep'**
  String get personalDetailsTriggerSleep;

  /// No description provided for @personalDetailsTriggerHealth.
  ///
  /// In en, this message translates to:
  /// **'Health'**
  String get personalDetailsTriggerHealth;

  /// No description provided for @personalDetailsTriggerMoney.
  ///
  /// In en, this message translates to:
  /// **'Money'**
  String get personalDetailsTriggerMoney;

  /// No description provided for @personalDetailsTriggerUncertainty.
  ///
  /// In en, this message translates to:
  /// **'Uncertainty'**
  String get personalDetailsTriggerUncertainty;

  /// No description provided for @personalDetailsTriggerAnxiety.
  ///
  /// In en, this message translates to:
  /// **'Anxiety'**
  String get personalDetailsTriggerAnxiety;

  /// No description provided for @personalDetailsTriggerSocial.
  ///
  /// In en, this message translates to:
  /// **'Social life'**
  String get personalDetailsTriggerSocial;

  /// No description provided for @personalDetailsSleepProblemFallingAsleep.
  ///
  /// In en, this message translates to:
  /// **'Hard to fall asleep'**
  String get personalDetailsSleepProblemFallingAsleep;

  /// No description provided for @personalDetailsSleepProblemNightWaking.
  ///
  /// In en, this message translates to:
  /// **'Wake up at night'**
  String get personalDetailsSleepProblemNightWaking;

  /// No description provided for @personalDetailsSleepProblemEarlyWaking.
  ///
  /// In en, this message translates to:
  /// **'Early waking'**
  String get personalDetailsSleepProblemEarlyWaking;

  /// No description provided for @personalDetailsSleepProblemLightSleep.
  ///
  /// In en, this message translates to:
  /// **'Light sleep'**
  String get personalDetailsSleepProblemLightSleep;

  /// No description provided for @personalDetailsSleepProblemRacingThoughts.
  ///
  /// In en, this message translates to:
  /// **'Racing thoughts'**
  String get personalDetailsSleepProblemRacingThoughts;

  /// No description provided for @personalDetailsSleepProblemIrregularSchedule.
  ///
  /// In en, this message translates to:
  /// **'Irregular schedule'**
  String get personalDetailsSleepProblemIrregularSchedule;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'he', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'he':
      return AppLocalizationsHe();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
