import 'package:flutter_test/flutter_test.dart';
import 'package:nepali_date_converter/nepali_date_converter.dart';

void main() {
  test('Nepali to English conversion', () {
    // BS: 2000-09-18 should correspond to AD: 1944-04-13.
    NepaliDate bsDate = NepaliDate(year: 2000, month: 9, day: 18);
    DateTime adDate = nepaliToEnglish(bsDate);
    expect(adDate.year, 1944);
    expect(adDate.month, 4);
    expect(adDate.day, 13);
  });

  test('English to Nepali conversion', () {
    // AD: 1944-04-13 should correspond to BS: 2000-09-18.
    DateTime adDate = DateTime(1944, 4, 13);
    NepaliDate bsDate = englishToNepali(adDate);
    expect(bsDate.year, 2000);
    expect(bsDate.month, 9);
    expect(bsDate.day, 18);
  });
}
