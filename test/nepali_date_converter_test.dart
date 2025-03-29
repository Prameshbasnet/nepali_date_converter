import 'package:flutter_test/flutter_test.dart';
import 'package:nepali_date_converter/nepali_date_converter.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Nepali Date Converter', () {
    late NepaliDateConverter converter;

    setUpAll(() async {
      converter = await NepaliDateConverter.load();
    });

    test('BS to AD conversion for date in JSON', () {
      final bsDate = NepaliDate(year: 2081, month: 12, day: 16);
      final adDate = converter.convertBsToAd(bsDate);

      expect(adDate, isNotNull);
      expect(adDate?.year, equals(2025));
      expect(adDate?.month, equals(3));
      expect(adDate?.day, equals(30));
    });

    test('AD to BS conversion for date in JSON', () {
      final adDate = AdDate(year: 1943, month: 4, day: 15);
      final bsDate = converter.convertAdToBs(adDate);

      expect(bsDate, isNotNull);
      expect(bsDate?.year, equals(2000));
      expect(bsDate?.month, equals(1));
      expect(bsDate?.day, equals(2));
    });

    test('Returns null for non-existent BS date', () {
      final bsDate = NepaliDate(year: 9999, month: 12, day: 31);
      final adDate = converter.convertBsToAd(bsDate);
      expect(adDate, isNull);
    });

    test('Returns null for non-existent AD date', () {
      final adDate = AdDate(year: 9999, month: 12, day: 31);
      final bsDate = converter.convertAdToBs(adDate);
      expect(bsDate, isNull);
    });
  });
}
