import 'package:flutter_test/flutter_test.dart';

import 'package:user_profile/main.dart';

void main() {
  testWidgets('renders register screen', (WidgetTester tester) async {
    await tester.pumpWidget(const UserProfileApp());
    await tester.pump();

    expect(find.text('User Register'), findsOneWidget);
  });
}
