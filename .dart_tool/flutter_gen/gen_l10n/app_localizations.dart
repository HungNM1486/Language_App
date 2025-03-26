import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_vi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/app_localizations.dart';
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
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('vi')
  ];

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @selectAppLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select app language'**
  String get selectAppLanguage;

  /// No description provided for @profileInfo.
  ///
  /// In en, this message translates to:
  /// **'Profile Information'**
  String get profileInfo;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logout;

  /// No description provided for @courses.
  ///
  /// In en, this message translates to:
  /// **'courses'**
  String get courses;

  /// No description provided for @learningGoals.
  ///
  /// In en, this message translates to:
  /// **'Learning Goals'**
  String get learningGoals;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @sound.
  ///
  /// In en, this message translates to:
  /// **'Sound'**
  String get sound;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @support.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get support;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @areYouSureLogout.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to log out?'**
  String get areYouSureLogout;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @agree.
  ///
  /// In en, this message translates to:
  /// **'Agree'**
  String get agree;

  /// No description provided for @noAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get noAccount;

  /// No description provided for @avatar.
  ///
  /// In en, this message translates to:
  /// **'Avatar'**
  String get avatar;

  /// No description provided for @signup.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get signup;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'Or'**
  String get or;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @enterYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get enterYourEmail;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// No description provided for @loginName.
  ///
  /// In en, this message translates to:
  /// **'Login Name'**
  String get loginName;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// No description provided for @addCourse.
  ///
  /// In en, this message translates to:
  /// **'Add Course'**
  String get addCourse;

  /// No description provided for @removeCourse.
  ///
  /// In en, this message translates to:
  /// **'Remove Course'**
  String get removeCourse;

  /// No description provided for @goalsUnderDevelopment.
  ///
  /// In en, this message translates to:
  /// **'Learning goals settings page (under development)'**
  String get goalsUnderDevelopment;

  /// No description provided for @themeUnderDevelopment.
  ///
  /// In en, this message translates to:
  /// **'Theme settings page (under development)'**
  String get themeUnderDevelopment;

  /// No description provided for @soundUnderDevelopment.
  ///
  /// In en, this message translates to:
  /// **'Sound settings page (under development)'**
  String get soundUnderDevelopment;

  /// No description provided for @notificationsUnderDevelopment.
  ///
  /// In en, this message translates to:
  /// **'Notifications settings page (under development)'**
  String get notificationsUnderDevelopment;

  /// No description provided for @supportUnderDevelopment.
  ///
  /// In en, this message translates to:
  /// **'Support page (under development)'**
  String get supportUnderDevelopment;

  /// No description provided for @aboutUnderDevelopment.
  ///
  /// In en, this message translates to:
  /// **'About page (under development)'**
  String get aboutUnderDevelopment;

  /// No description provided for @developmentTeamInfo.
  ///
  /// In en, this message translates to:
  /// **'Development Team Information'**
  String get developmentTeamInfo;

  /// No description provided for @contactSupport.
  ///
  /// In en, this message translates to:
  /// **'Contact Support'**
  String get contactSupport;

  /// No description provided for @introduction.
  ///
  /// In en, this message translates to:
  /// **'Introduction'**
  String get introduction;

  /// No description provided for @developmentTeam.
  ///
  /// In en, this message translates to:
  /// **'Development Team'**
  String get developmentTeam;

  /// No description provided for @contact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get contact;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get saveChanges;

  /// No description provided for @deleteConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete your account? This action cannot be undone.'**
  String get deleteConfirmation;

  /// No description provided for @courseNotifications.
  ///
  /// In en, this message translates to:
  /// **'Course Notifications'**
  String get courseNotifications;

  /// No description provided for @courseNotificationsDesc.
  ///
  /// In en, this message translates to:
  /// **'Receive notifications about course progress and updates.'**
  String get courseNotificationsDesc;

  /// No description provided for @reminderNotifications.
  ///
  /// In en, this message translates to:
  /// **'Learning Reminders'**
  String get reminderNotifications;

  /// No description provided for @reminderNotificationsDesc.
  ///
  /// In en, this message translates to:
  /// **'Receive reminders to maintain your learning habit.'**
  String get reminderNotificationsDesc;

  /// No description provided for @updateNotifications.
  ///
  /// In en, this message translates to:
  /// **'App Updates'**
  String get updateNotifications;

  /// No description provided for @updateNotificationsDesc.
  ///
  /// In en, this message translates to:
  /// **'Receive notifications when a new version is available.'**
  String get updateNotificationsDesc;

  /// No description provided for @selectTheme.
  ///
  /// In en, this message translates to:
  /// **'Select Theme'**
  String get selectTheme;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @system.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get system;

  /// No description provided for @themeSaved.
  ///
  /// In en, this message translates to:
  /// **'Theme settings saved'**
  String get themeSaved;

  /// No description provided for @selectGoal.
  ///
  /// In en, this message translates to:
  /// **'Select Learning Goal'**
  String get selectGoal;

  /// No description provided for @basic.
  ///
  /// In en, this message translates to:
  /// **'Basic'**
  String get basic;

  /// No description provided for @basicDesc.
  ///
  /// In en, this message translates to:
  /// **'Learn basic skills, suitable for beginners.'**
  String get basicDesc;

  /// No description provided for @advanced.
  ///
  /// In en, this message translates to:
  /// **'Advanced'**
  String get advanced;

  /// No description provided for @advancedDesc.
  ///
  /// In en, this message translates to:
  /// **'Develop in-depth skills, for those with a foundation.'**
  String get advancedDesc;

  /// No description provided for @expert.
  ///
  /// In en, this message translates to:
  /// **'Expert'**
  String get expert;

  /// No description provided for @expertDesc.
  ///
  /// In en, this message translates to:
  /// **'Achieve advanced proficiency, ideal for mastery.'**
  String get expertDesc;

  /// No description provided for @continueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButton;

  /// No description provided for @goalTime.
  ///
  /// In en, this message translates to:
  /// **'Goal Completion Time'**
  String get goalTime;

  /// No description provided for @selectGoalTime.
  ///
  /// In en, this message translates to:
  /// **'Select Goal Completion Time'**
  String get selectGoalTime;

  /// No description provided for @oneMonth.
  ///
  /// In en, this message translates to:
  /// **'1 Month'**
  String get oneMonth;

  /// No description provided for @oneMonthDesc.
  ///
  /// In en, this message translates to:
  /// **'Complete your goal in a short, intensive period.'**
  String get oneMonthDesc;

  /// No description provided for @threeMonths.
  ///
  /// In en, this message translates to:
  /// **'3 Months'**
  String get threeMonths;

  /// No description provided for @threeMonthsDesc.
  ///
  /// In en, this message translates to:
  /// **'A balanced pace to achieve your learning goal.'**
  String get threeMonthsDesc;

  /// No description provided for @sixMonths.
  ///
  /// In en, this message translates to:
  /// **'6 Months'**
  String get sixMonths;

  /// No description provided for @sixMonthsDesc.
  ///
  /// In en, this message translates to:
  /// **'A longer period for thorough mastery.'**
  String get sixMonthsDesc;

  /// No description provided for @goalTimeSaved.
  ///
  /// In en, this message translates to:
  /// **'Goal completion time saved'**
  String get goalTimeSaved;

  /// No description provided for @studyTime.
  ///
  /// In en, this message translates to:
  /// **'Study Time'**
  String get studyTime;

  /// No description provided for @selectStudyTime.
  ///
  /// In en, this message translates to:
  /// **'Select Study Time'**
  String get selectStudyTime;

  /// No description provided for @breakfast.
  ///
  /// In en, this message translates to:
  /// **'During Breakfast'**
  String get breakfast;

  /// No description provided for @commuting.
  ///
  /// In en, this message translates to:
  /// **'While Commuting'**
  String get commuting;

  /// No description provided for @lunch.
  ///
  /// In en, this message translates to:
  /// **'During Lunch'**
  String get lunch;

  /// No description provided for @dinner.
  ///
  /// In en, this message translates to:
  /// **'During Dinner'**
  String get dinner;

  /// No description provided for @studyTimeSaved.
  ///
  /// In en, this message translates to:
  /// **'Study time saved'**
  String get studyTimeSaved;

  /// No description provided for @goalCompletion.
  ///
  /// In en, this message translates to:
  /// **'Goal Setup Complete'**
  String get goalCompletion;

  /// No description provided for @congratulations.
  ///
  /// In en, this message translates to:
  /// **'Congratulations!'**
  String get congratulations;

  /// No description provided for @goalSetSuccess.
  ///
  /// In en, this message translates to:
  /// **'You have successfully set your learning goal.'**
  String get goalSetSuccess;

  /// No description provided for @goalOverview.
  ///
  /// In en, this message translates to:
  /// **'Goal Overview'**
  String get goalOverview;

  /// No description provided for @goalLabel.
  ///
  /// In en, this message translates to:
  /// **'Goal'**
  String get goalLabel;

  /// No description provided for @timeLabel.
  ///
  /// In en, this message translates to:
  /// **'Completion Time'**
  String get timeLabel;

  /// No description provided for @studyTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'Study Time'**
  String get studyTimeLabel;

  /// No description provided for @finishButton.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get finishButton;

  /// No description provided for @activity.
  ///
  /// In en, this message translates to:
  /// **'Activity'**
  String get activity;

  /// No description provided for @activityOverview.
  ///
  /// In en, this message translates to:
  /// **'Activity Overview'**
  String get activityOverview;

  /// No description provided for @totalStudyTime.
  ///
  /// In en, this message translates to:
  /// **'Total Study Time'**
  String get totalStudyTime;

  /// No description provided for @totalCourses.
  ///
  /// In en, this message translates to:
  /// **'Total Courses'**
  String get totalCourses;

  /// No description provided for @community.
  ///
  /// In en, this message translates to:
  /// **'Community'**
  String get community;

  /// No description provided for @noPosts.
  ///
  /// In en, this message translates to:
  /// **'No posts yet'**
  String get noPosts;

  /// No description provided for @createPost.
  ///
  /// In en, this message translates to:
  /// **'Create Post'**
  String get createPost;

  /// No description provided for @postTitle.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get postTitle;

  /// No description provided for @postContent.
  ///
  /// In en, this message translates to:
  /// **'Content'**
  String get postContent;

  /// No description provided for @submitPost.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submitPost;

  /// No description provided for @likes.
  ///
  /// In en, this message translates to:
  /// **'Likes'**
  String get likes;

  /// No description provided for @comments.
  ///
  /// In en, this message translates to:
  /// **'Comments'**
  String get comments;

  /// No description provided for @addComment.
  ///
  /// In en, this message translates to:
  /// **'Add a comment'**
  String get addComment;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'vi': return AppLocalizationsVi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
