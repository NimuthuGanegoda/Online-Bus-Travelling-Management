import 'package:driver_app/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('renders driver login experience', (tester) async {
    await tester.pumpWidget(const DriverApp(supabaseReady: false));

    expect(find.text('SL BusTrack'), findsOneWidget);
    expect(find.text('Driver sign in'), findsOneWidget);
    expect(find.text('Login as Driver'), findsOneWidget);
  });
}
