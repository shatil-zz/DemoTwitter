# Demo Twitter
- Can login
- Can post twit
- Can view all twit posted by any users

# Architecture pattern
Bloc and repository with rxdart and provider

# Version
- Flutter 2.8.1 • channel stable
- Dart 2.15.1

# Mock
- Mockito
- Fake Firebase Auth and Firestore

# DI
- inject

# Ready to run
- flutter pub get
- flutter packages pub run build_runner build --delete-conflicting-outputs --verbose

# Test
- Unit test
- Widget test
- Integration test

# Run command for unit and widget test:
- flutter test test/*

# Run command for specific unit/widget test:
- flutter test test/$filepath
- ex. home page test-> flutter test test/widget/home_test.dart

# Run command for integration test:
  flutter drive \--driver=test_driver/integration_test.dart \--target=integration_test/add_twit_test.dart

# Can login with with following credentials if used already build
- email->user1@test.com password->abc123
- email->user2@test.com password->abc123
- email->user3@test.com password->abc123
- email->user4@test.com password->abc123

# Find release apk
- https://drive.google.com/file/d/1wW_JC9Adm4MP9nG09_i53mMdY3ckht_d/view?usp=sharing
# Integration test video link
- https://drive.google.com/file/d/16QwnZQ72V6m0D1z-00Kw_dVsfpwF49sb/view?usp=sharing
