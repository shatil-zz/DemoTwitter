import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'integration_test_utils.dart';

String userName = "Anik 0010";
String currentDate = "18";

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('Post a new twit', (WidgetTester tester) async {
    await tester.pumpAndSettle();
    await userLogin(tester);
    await createPost(tester);
  });
}
