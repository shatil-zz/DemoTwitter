# demo_twitter
- Can post twit
- Can view all twit posted by any users

# Architecture pattern
Bloc and repository with rxdart and provider

# Mock
- Mockito
- Firebase Auth and Firestore fake mock

#DI
inject

# Test
- Unit test
- Widget test
  # Run command for unit and widget test:
  flutter test test/*
  # Run command for specific unit/widget test
  flutter test test/$filepath
  ex. home page test-> flutter test test/widget/home_test.dart
  
- Integration test
# run command:
  flutter drive \
  --driver=test_driver/integration_test.dart \
  --target=integration_test/add_twit_test.dart

# Can login with with following credentials if used already build 
  user1@test.com(abc123)
  user2@test.com(abc123)
  user3@test.com(abc123)