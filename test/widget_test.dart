import 'package:citybike/main_common.dart';
import 'package:citybike/main_dev.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('shows pass selection screen on app start', (tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: devProviders,
        child: const CityBikeApp(),
      ),
    );
    await tester.pump(const Duration(milliseconds: 1200));
    await tester.pump();

    expect(find.text('BikeShare'), findsOneWidget);
    expect(find.text('Choose your pass'), findsOneWidget);
  });
}
