import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class NepaliDate {
  final int year;
  final int month;
  final int day;

  const NepaliDate({
    required this.year,
    required this.month,
    required this.day,
  });

  @override
  String toString() => '$year/$month/$day';

  String toKey() => '${year.toString().padLeft(4, '0')}-'
      '${month.toString().padLeft(2, '0')}-'
      '${day.toString().padLeft(2, '0')}';
}

class AdDate {
  final int year;
  final int month;
  final int day;

  const AdDate({
    required this.year,
    required this.month,
    required this.day,
  });

  @override
  String toString() => '$year/$month/$day';

  String toKey() => '${year.toString().padLeft(4, '0')}-'
      '${month.toString().padLeft(2, '0')}-'
      '${day.toString().padLeft(2, '0')}';
}

class NepaliDateConverter {
  final Map<String, AdDate> _bsToAd;
  final Map<String, NepaliDate> _adToBs;

  NepaliDateConverter._(this._bsToAd, this._adToBs);

  static Future<NepaliDateConverter> load() async {
    try {
      final jsonString = await rootBundle.loadString('assets/bs_ad_dates.json');
      final Map<String, dynamic> data = json.decode(jsonString);
      final bsToAd = <String, AdDate>{};
      final adToBs = <String, NepaliDate>{};

      data.forEach((yearKey, dayList) {
        for (var dayMap in (dayList as List)) {
          final bsDate = NepaliDate(
            year: dayMap['bsYear'] as int,
            month: dayMap['bsMonth'] as int,
            day: dayMap['bsDay'] as int,
          );

          final adDate = AdDate(
            year: dayMap['adYear'] as int,
            month: dayMap['adMonth'] as int,
            day: dayMap['adDay'] as int,
          );

          bsToAd[bsDate.toKey()] = adDate;
          adToBs[adDate.toKey()] = bsDate;
        }
      });

      return NepaliDateConverter._(bsToAd, adToBs);
    } catch (e) {
      throw Exception('Failed to initialize converter: $e');
    }
  }

  AdDate? convertBsToAd(NepaliDate bsDate) => _bsToAd[bsDate.toKey()];
  NepaliDate? convertAdToBs(AdDate adDate) => _adToBs[adDate.toKey()];
}
