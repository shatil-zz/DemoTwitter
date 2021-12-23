import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'integration_test_utils.dart';
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('Post a new twit', (WidgetTester tester) async {
    await startAppForPostATwit(tester);
    await userLogin(tester);
    await createPost(tester);
  });
}
