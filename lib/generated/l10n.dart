// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Add Review` 
  String get add_review {
    return Intl.message('Add Review', name: 'add_review', desc: '', args: []);
  }

  /// `About this course`
  String get about_this_course {
    return Intl.message(
      'About this course',
      name: 'about_this_course',
      desc: '',
      args: [],
    );
  }

  /// `Mentor`
  String get mentor {
    return Intl.message('Mentor', name: 'mentor', desc: '', args: []);
  }

  /// `Courses`
  String get courses {
    return Intl.message('Courses', name: 'courses', desc: '', args: []);
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  /// `Enroll`
  String get enroll {
    return Intl.message('Enroll', name: 'enroll', desc: '', args: []);
  }

  /// `Buy Now`
  String get buy_now {
    return Intl.message('Buy Now', name: 'buy_now', desc: '', args: []);
  }

  /// `Watch`
  String get watch {
    return Intl.message('Watch', name: 'watch', desc: '', args: []);
  }

  /// `An error occurred`
  String get error_occurred {
    return Intl.message(
      'An error occurred',
      name: 'error_occurred',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get retry {
    return Intl.message('Retry', name: 'retry', desc: '', args: []);
  }

  /// `Field and rating are required`
  String get field_and_rating_are_required {
    return Intl.message(
      'Field and rating are required',
      name: 'field_and_rating_are_required',
      desc: '',
      args: [],
    );
  }

  /// `Network error`
  String get network_error {
    return Intl.message(
      'Network error',
      name: 'network_error',
      desc: '',
      args: [],
    );
  }

  /// `Edit Your Review`
  String get edit_your_review {
    return Intl.message(
      'Edit Your Review',
      name: 'edit_your_review',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message('Done', name: 'done', desc: '', args: []);
  }

  /// `Error deleting`
  String get error_deleting {
    return Intl.message(
      'Error deleting',
      name: 'error_deleting',
      desc: '',
      args: [],
    );
  }

  /// `Check your email or password`
  String get check_email_or_password {
    return Intl.message(
      'Check your email or password',
      name: 'check_email_or_password',
      desc: '',
      args: [],
    );
  }

  /// `Ar`
  String get en {
    return Intl.message('Ar', name: 'en', desc: '', args: []);
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Invalid Email`
  String get invalid_email {
    return Intl.message(
      'Invalid Email',
      name: 'invalid_email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Forget Password?`
  String get forget_password {
    return Intl.message(
      'Forget Password?',
      name: 'forget_password',
      desc: '',
      args: [],
    );
  }

  /// `At least 8 characters, including lowercase, uppercase, and symbols`
  String get at_least_8_char_lower_upper_symbols {
    return Intl.message(
      'At least 8 characters, including lowercase, uppercase, and symbols',
      name: 'at_least_8_char_lower_upper_symbols',
      desc: '',
      args: [],
    );
  }

  /// `Google`
  String get google {
    return Intl.message('Google', name: 'google', desc: '', args: []);
  }

  /// `GitHub`
  String get git_hub {
    return Intl.message('GitHub', name: 'git_hub', desc: '', args: []);
  }

  /// `Don't have an account?`
  String get dont_have_account {
    return Intl.message(
      'Don\'t have an account?',
      name: 'dont_have_account',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message('Register', name: 'register', desc: '', args: []);
  }

  /// `Connection Error`
  String get connection_error {
    return Intl.message(
      'Connection Error',
      name: 'connection_error',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred`
  String get an_error_occurred {
    return Intl.message(
      'An error occurred',
      name: 'an_error_occurred',
      desc: '',
      args: [],
    );
  }

  /// `or login`
  String get or_login {
    return Intl.message('or login', name: 'or_login', desc: '', args: []);
  }

  /// `GitHub Account`
  String get github_account {
    return Intl.message(
      'GitHub Account',
      name: 'github_account',
      desc: '',
      args: [],
    );
  }

  /// `Bio`
  String get bio {
    return Intl.message('Bio', name: 'bio', desc: '', args: []);
  }

  /// `Confirm Password`
  String get confirm_password {
    return Intl.message(
      'Confirm Password',
      name: 'confirm_password',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message('Name', name: 'name', desc: '', args: []);
  }

  /// `Add Image`
  String get add_image {
    return Intl.message('Add Image', name: 'add_image', desc: '', args: []);
  }

  /// `Edite Image`
  String get edite_image {
    return Intl.message('Edite Image', name: 'edite_image', desc: '', args: []);
  }

  /// `Send code`
  String get Send_code {
    return Intl.message('Send code', name: 'Send_code', desc: '', args: []);
  }

  /// `Email not found`
  String get Email_not_found {
    return Intl.message(
      'Email not found',
      name: 'Email_not_found',
      desc: '',
      args: [],
    );
  }

  /// `All fields are required`
  String get all_fields_required {
    return Intl.message(
      'All fields are required',
      name: 'all_fields_required',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get passwords_do_not_match {
    return Intl.message(
      'Passwords do not match',
      name: 'passwords_do_not_match',
      desc: '',
      args: [],
    );
  }

  /// `code sent`
  String get code_sent {
    return Intl.message('code sent', name: 'code_sent', desc: '', args: []);
  }

  /// `Register Completed`
  String get register_completed {
    return Intl.message(
      'Register Completed',
      name: 'register_completed',
      desc: '',
      args: [],
    );
  }

  /// `This email is already in use`
  String get email_already_exist {
    return Intl.message(
      'This email is already in use',
      name: 'email_already_exist',
      desc: '',
      args: [],
    );
  }

  /// `Verify Code`
  String get verify_code {
    return Intl.message('Verify Code', name: 'verify_code', desc: '', args: []);
  }

  /// `Send`
  String get send {
    return Intl.message('Send', name: 'send', desc: '', args: []);
  }

  /// `Resend code?`
  String get resend_code {
    return Intl.message(
      'Resend code?',
      name: 'resend_code',
      desc: '',
      args: [],
    );
  }

  /// `wrong code`
  String get error_code {
    return Intl.message('wrong code', name: 'error_code', desc: '', args: []);
  }

  /// `New Password`
  String get newPassword {
    return Intl.message(
      'New Password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get resetPassword {
    return Intl.message(
      'Reset Password',
      name: 'resetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm New Password`
  String get confirmNewPassword {
    return Intl.message(
      'Confirm New Password',
      name: 'confirmNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Reset password done`
  String get reset_password_done {
    return Intl.message(
      'Reset password done',
      name: 'reset_password_done',
      desc: '',
      args: [],
    );
  }

  /// `Server error , Please try later.`
  String get error_in_server {
    return Intl.message(
      'Server error , Please try later.',
      name: 'error_in_server',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Submit`
  String get submit {
    return Intl.message('Submit', name: 'submit', desc: '', args: []);
  }

  /// `Old Password`
  String get old_password {
    return Intl.message(
      'Old Password',
      name: 'old_password',
      desc: '',
      args: [],
    );
  }

  /// `My Profile`
  String get my_profile {
    return Intl.message('My Profile', name: 'my_profile', desc: '', args: []);
  }

  /// `Change Password`
  String get change_password {
    return Intl.message(
      'Change Password',
      name: 'change_password',
      desc: '',
      args: [],
    );
  }

  /// `Setting`
  String get setting {
    return Intl.message('Setting', name: 'setting', desc: '', args: []);
  }

  /// `Friends`
  String get friends {
    return Intl.message('Friends', name: 'friends', desc: '', args: []);
  }

  /// `Participants`
  String get participants {
    return Intl.message(
      'Participants',
      name: 'participants',
      desc: '',
      args: [],
    );
  }

  /// `Teachers`
  String get teachers {
    return Intl.message('Teachers', name: 'teachers', desc: '', args: []);
  }

  /// `wrong password`
  String get error_old_password {
    return Intl.message(
      'wrong password',
      name: 'error_old_password',
      desc: '',
      args: [],
    );
  }

  /// `check information`
  String get check_info {
    return Intl.message(
      'check information',
      name: 'check_info',
      desc: '',
      args: [],
    );
  }

  /// `Add Project`
  String get add_new_project {
    return Intl.message(
      'Add Project',
      name: 'add_new_project',
      desc: '',
      args: [],
    );
  }

  /// `Please fill required fields`
  String get fill_details {
    return Intl.message(
      'Please fill required fields',
      name: 'fill_details',
      desc: '',
      args: [],
    );
  }

  /// `Basic Information`
  String get basic_information {
    return Intl.message(
      'Basic Information',
      name: 'basic_information',
      desc: '',
      args: [],
    );
  }

  /// `Project Content`
  String get project_content {
    return Intl.message(
      'Project Content',
      name: 'project_content',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `Choose File to upload`
  String get choose_file_to_upload {
    return Intl.message(
      'Choose File to upload',
      name: 'choose_file_to_upload',
      desc: '',
      args: [],
    );
  }

  /// `Project Title`
  String get project_title {
    return Intl.message(
      'Project Title',
      name: 'project_title',
      desc: '',
      args: [],
    );
  }

  /// `Enter your project title`
  String get enter_project_title {
    return Intl.message(
      'Enter your project title',
      name: 'enter_project_title',
      desc: '',
      args: [],
    );
  }

  /// `Project Description`
  String get project_description {
    return Intl.message(
      'Project Description',
      name: 'project_description',
      desc: '',
      args: [],
    );
  }

  /// `Enter a brief description of your project`
  String get enter_description {
    return Intl.message(
      'Enter a brief description of your project',
      name: 'enter_description',
      desc: '',
      args: [],
    );
  }

  /// `projectkind`
  String get project_kind {
    return Intl.message(
      'projectkind',
      name: 'project_kind',
      desc: '',
      args: [],
    );
  }

  /// `Select a tag`
  String get select_a_tag {
    return Intl.message(
      'Select a tag',
      name: 'select_a_tag',
      desc: '',
      args: [],
    );
  }

  /// `Technologies`
  String get technologies {
    return Intl.message(
      'Technologies',
      name: 'technologies',
      desc: '',
      args: [],
    );
  }

  /// `Select technologies`
  String get select_technologies {
    return Intl.message(
      'Select technologies',
      name: 'select_technologies',
      desc: '',
      args: [],
    );
  }

  /// `Project Links`
  String get project_links {
    return Intl.message(
      'Project Links',
      name: 'project_links',
      desc: '',
      args: [],
    );
  }

  /// `GitHub URL`
  String get github_url {
    return Intl.message('GitHub URL', name: 'github_url', desc: '', args: []);
  }

  /// `Enter GitHub link`
  String get enter_github_url {
    return Intl.message(
      'Enter GitHub link',
      name: 'enter_github_url',
      desc: '',
      args: [],
    );
  }

  /// `Demo URL`
  String get demo_url {
    return Intl.message('Demo URL', name: 'demo_url', desc: '', args: []);
  }

  /// `Enter demo link`
  String get enter_demo_url {
    return Intl.message(
      'Enter demo link',
      name: 'enter_demo_url',
      desc: '',
      args: [],
    );
  }

  /// `Steam URL`
  String get steam_url {
    return Intl.message('Steam URL', name: 'steam_url', desc: '', args: []);
  }

  /// `Enter Steam link`
  String get enter_steam_url {
    return Intl.message(
      'Enter Steam link',
      name: 'enter_steam_url',
      desc: '',
      args: [],
    );
  }

  /// `Save as draft`
  String get save_as_draft {
    return Intl.message(
      'Save as draft',
      name: 'save_as_draft',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message('Next', name: 'next', desc: '', args: []);
  }

  /// `Login or Sign Up`
  String get Login_or_SignUp {
    return Intl.message(
      'Login or Sign Up',
      name: 'Login_or_SignUp',
      desc: '',
      args: [],
    );
  }

  /// `About this Path`
  String get learn_path_info {
    return Intl.message(
      'About this Path',
      name: 'learn_path_info',
      desc: '',
      args: [],
    );
  }

  /// `Sort by name`
  String get participant_trtip {
    return Intl.message(
      'Sort by name',
      name: 'participant_trtip',
      desc: '',
      args: [],
    );
  }

  /// `Sort by points`
  String get Participants_tarteep {
    return Intl.message(
      'Sort by points',
      name: 'Participants_tarteep',
      desc: '',
      args: [],
    );
  }

  /// `Learn Path`
  String get Learn_Path {
    return Intl.message('Learn Path', name: 'Learn_Path', desc: '', args: []);
  }

  /// `Contest`
  String get Contest {
    return Intl.message('Contest', name: 'Contest', desc: '', args: []);
  }

  /// `Project`
  String get Project {
    return Intl.message('Project', name: 'Project', desc: '', args: []);
  }

  /// `More`
  String get More {
    return Intl.message('More', name: 'More', desc: '', args: []);
  }

  /// `Push notifications`
  String get push_notifications {
    return Intl.message(
      'Push notifications',
      name: 'push_notifications',
      desc: '',
      args: [],
    );
  }

  /// `Dark Mode`
  String get dark_mode {
    return Intl.message('Dark Mode', name: 'dark_mode', desc: '', args: []);
  }

  /// `Add a payment method`
  String get add_a_payment_method {
    return Intl.message(
      'Add a payment method',
      name: 'add_a_payment_method',
      desc: '',
      args: [],
    );
  }

  /// `Delete history`
  String get delete_history {
    return Intl.message(
      'Delete history',
      name: 'delete_history',
      desc: '',
      args: [],
    );
  }

  /// `Change language`
  String get change_language {
    return Intl.message(
      'Change language',
      name: 'change_language',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
  }

  /// `Edit profile`
  String get edit_profile {
    return Intl.message(
      'Edit profile',
      name: 'edit_profile',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get All {
    return Intl.message('All', name: 'All', desc: '', args: []);
  }

  /// `My`
  String get My {
    return Intl.message('My', name: 'My', desc: '', args: []);
  }

  /// `search project`
  String get search_project {
    return Intl.message(
      'search project',
      name: 'search_project',
      desc: '',
      args: [],
    );
  }

  /// `Read More`
  String get read_more {
    return Intl.message('Read More', name: 'read_more', desc: '', args: []);
  }

  /// `Details`
  String get details {
    return Intl.message('Details', name: 'details', desc: '', args: []);
  }

  /// `Close`
  String get close {
    return Intl.message('Close', name: 'close', desc: '', args: []);
  }

  /// `Please wait for the admin to accept.`
  String get attent_admin_To_Accept {
    return Intl.message(
      'Please wait for the admin to accept.',
      name: 'attent_admin_To_Accept',
      desc: '',
      args: [],
    );
  }

  /// `You can't send more than 3 project requests a month`
  String get cant_send_more_in_month {
    return Intl.message(
      'You can\'t send more than 3 project requests a month',
      name: 'cant_send_more_in_month',
      desc: '',
      args: [],
    );
  }

  /// `Current Streak`
  String get current_streak {
    return Intl.message(
      'Current Streak',
      name: 'current_streak',
      desc: '',
      args: [],
    );
  }

  /// `Course Completed`
  String get course_completed {
    return Intl.message(
      'Course Completed',
      name: 'course_completed',
      desc: '',
      args: [],
    );
  }

  /// `Days`
  String get days {
    return Intl.message('Days', name: 'days', desc: '', args: []);
  }

  /// `Total Points`
  String get total_points {
    return Intl.message(
      'Total Points',
      name: 'total_points',
      desc: '',
      args: [],
    );
  }

  /// `Certificates`
  String get certificates {
    return Intl.message(
      'Certificates',
      name: 'certificates',
      desc: '',
      args: [],
    );
  }

  /// `Achievement`
  String get achievement {
    return Intl.message('Achievement', name: 'achievement', desc: '', args: []);
  }

  /// `My Contest`
  String get my_contest {
    return Intl.message('My Contest', name: 'my_contest', desc: '', args: []);
  }

  /// `Profile Updated`
  String get profile_updated {
    return Intl.message(
      'Profile Updated',
      name: 'profile_updated',
      desc: '',
      args: [],
    );
  }

  /// `update`
  String get update {
    return Intl.message('update', name: 'update', desc: '', args: []);
  }

  /// `Completed`
  String get Completed {
    return Intl.message('Completed', name: 'Completed', desc: '', args: []);
  }

  /// `not Completed`
  String get Not_Completed {
    return Intl.message(
      'not Completed',
      name: 'Not_Completed',
      desc: '',
      args: [],
    );
  }

  /// `Quiz`
  String get Quiz {
    return Intl.message('Quiz', name: 'Quiz', desc: '', args: []);
  }

  /// `Failed to fetch video data`
  String get fetch_video_failed {
    return Intl.message(
      'Failed to fetch video data',
      name: 'fetch_video_failed',
      desc: '',
      args: [],
    );
  }

  /// `Invalid video URL`
  String get invalid_video_url {
    return Intl.message(
      'Invalid video URL',
      name: 'invalid_video_url',
      desc: '',
      args: [],
    );
  }

  /// `Your best Score`
  String get your_best_score {
    return Intl.message(
      'Your best Score',
      name: 'your_best_score',
      desc: '',
      args: [],
    );
  }

  /// `Restart Quiz`
  String get restart_quiz {
    return Intl.message(
      'Restart Quiz',
      name: 'restart_quiz',
      desc: '',
      args: [],
    );
  }

  /// `Back to video`
  String get back_to_video {
    return Intl.message(
      'Back to video',
      name: 'back_to_video',
      desc: '',
      args: [],
    );
  }

  /// `TEST`
  String get test {
    return Intl.message('TEST', name: 'test', desc: '', args: []);
  }

  /// `Question`
  String get question {
    return Intl.message('Question', name: 'question', desc: '', args: []);
  }

  /// `Back`
  String get back {
    return Intl.message('Back', name: 'back', desc: '', args: []);
  }

  /// `choose course`
  String get choose_course {
    return Intl.message(
      'choose course',
      name: 'choose_course',
      desc: '',
      args: [],
    );
  }

  /// `choose learn path`
  String get choose_learn_path {
    return Intl.message(
      'choose learn path',
      name: 'choose_learn_path',
      desc: '',
      args: [],
    );
  }

  /// `Watch later`
  String get watchLater {
    return Intl.message('Watch later', name: 'watchLater', desc: '', args: []);
  }

  /// `View`
  String get view {
    return Intl.message('View', name: 'view', desc: '', args: []);
  }

  /// `no items`
  String get NoItem {
    return Intl.message('no items', name: 'NoItem', desc: '', args: []);
  }

  /// `active`
  String get active {
    return Intl.message('active', name: 'active', desc: '', args: []);
  }

  /// `ended`
  String get ended {
    return Intl.message('ended', name: 'ended', desc: '', args: []);
  }

  /// `coming`
  String get coming {
    return Intl.message('coming', name: 'coming', desc: '', args: []);
  }

  /// `join`
  String get join {
    return Intl.message('join', name: 'join', desc: '', args: []);
  }

  /// `Register`
  String get contest_register {
    return Intl.message(
      'Register',
      name: 'contest_register',
      desc: '',
      args: [],
    );
  }

  /// `complete in browser mode`
  String get complete_as_browser {
    return Intl.message(
      'complete in browser mode',
      name: 'complete_as_browser',
      desc: '',
      args: [],
    );
  }

  /// `Student`
  String get student {
    return Intl.message('Student', name: 'student', desc: '', args: []);
  }

  /// `Teacher`
  String get teacher {
    return Intl.message('Teacher', name: 'teacher', desc: '', args: []);
  }

  /// `choose contest`
  String get choose_contest {
    return Intl.message(
      'choose contest',
      name: 'choose_contest',
      desc: '',
      args: [],
    );
  }

  /// `search`
  String get search {
    return Intl.message('search', name: 'search', desc: '', args: []);
  }

  /// `Leader Board`
  String get Leader_Board {
    return Intl.message(
      'Leader Board',
      name: 'Leader_Board',
      desc: '',
      args: [],
    );
  }

  /// `{status, select, active {Active} ended {Ended} coming {Coming Soon} `
  String contestStatus(Object Active, Object Ended) {
    return Intl.message(
      '{status, select, active $Active ended $Ended coming {Coming Soon} ',
      name: 'contestStatus',
      desc: '',
      args: [Active, Ended],
    );
  }

  /// `You can't open programming contest now`
  String get You_cant_open_programming_contest_now {
    return Intl.message(
      'You can\'t open programming contest now',
      name: 'You_cant_open_programming_contest_now',
      desc: '',
      args: [],
    );
  }

  /// `time is finish , test over`
  String get Timeisfinishedtocopmletetest {
    return Intl.message(
      'time is finish , test over',
      name: 'Timeisfinishedtocopmletetest',
      desc: '',
      args: [],
    );
  }

  /// `wait until the contest open`
  String get wait_until_the_contest_open {
    return Intl.message(
      'wait until the contest open',
      name: 'wait_until_the_contest_open',
      desc: '',
      args: [],
    );
  }

  /// `comments`
  String get comments {
    return Intl.message('comments', name: 'comments', desc: '', args: []);
  }

  /// `add comment`
  String get add_comment {
    return Intl.message('add comment', name: 'add_comment', desc: '', args: []);
  }

  /// `reply`
  String get reply {
    return Intl.message('reply', name: 'reply', desc: '', args: []);
  }

  /// `Hide replies`
  String get hide_replies {
    return Intl.message(
      'Hide replies',
      name: 'hide_replies',
      desc: '',
      args: [],
    );
  }

  /// `Replies`
  String get replies {
    return Intl.message('Replies', name: 'replies', desc: '', args: []);
  }

  /// `Add a reply`
  String get add_reply {
    return Intl.message('Add a reply', name: 'add_reply', desc: '', args: []);
  }

  /// `hours`
  String get hours {
    return Intl.message('hours', name: 'hours', desc: '', args: []);
  }

  /// `videos`
  String get videos {
    return Intl.message('videos', name: 'videos', desc: '', args: []);
  }

  /// `participant`
  String get participant {
    return Intl.message('participant', name: 'participant', desc: '', args: []);
  }

  /// `Reviews`
  String get Reviews {
    return Intl.message('Reviews', name: 'Reviews', desc: '', args: []);
  }

  /// `About this course`
  String get About_this_course {
    return Intl.message(
      'About this course',
      name: 'About_this_course',
      desc: '',
      args: [],
    );
  }

  /// `Mentor`
  String get Mentor {
    return Intl.message('Mentor', name: 'Mentor', desc: '', args: []);
  }

  /// `remove watch later`
  String get remove_watch_later {
    return Intl.message(
      'remove watch later',
      name: 'remove_watch_later',
      desc: '',
      args: [],
    );
  }

  /// `add watch later`
  String get add_watch_later {
    return Intl.message(
      'add watch later',
      name: 'add_watch_later',
      desc: '',
      args: [],
    );
  }

  /// `Leader Board`
  String get leader {
    return Intl.message('Leader Board', name: 'leader', desc: '', args: []);
  }

  /// `not participant`
  String get leaderbord {
    return Intl.message(
      'not participant',
      name: 'leaderbord',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `remove path status`
  String get remove_path_status {
    return Intl.message(
      'remove path status',
      name: 'remove_path_status',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to log out?`
  String get Are_you_sure_you_want_to_log_out {
    return Intl.message(
      'Are you sure you want to log out?',
      name: 'Are_you_sure_you_want_to_log_out',
      desc: '',
      args: [],
    );
  }

  /// `contest already participate`
  String get contest_already_participate {
    return Intl.message(
      'contest already participate',
      name: 'contest_already_participate',
      desc: '',
      args: [],
    );
  }

  /// `change path status`
  String get change_path_status {
    return Intl.message(
      'change path status',
      name: 'change_path_status',
      desc: '',
      args: [],
    );
  }

  /// `balance`
  String get balance {
    return Intl.message('balance', name: 'balance', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
