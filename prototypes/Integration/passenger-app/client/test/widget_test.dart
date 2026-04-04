import 'package:flutter_test/flutter_test.dart';
import 'package:passenger_app/main.dart';

void main() {
  testWidgets('renders passenger login experience', (tester) async {
    await tester.pumpWidget(const PassengerApp(supabaseReady: false));

    expect(find.text('SL BusTrack'), findsOneWidget);
    expect(find.text('Passenger sign in'), findsOneWidget);
    expect(find.text('Login as Passenger'), findsOneWidget);
  });
}
