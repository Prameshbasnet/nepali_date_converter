library nepali_date_converter;

/// A simple model to represent a Nepali (BS) date.
class NepaliDate {
  final int year;
  final int month;
  final int day;

  NepaliDate({required this.year, required this.month, required this.day});

  @override
  String toString() => '$year-$month-$day';
}

/// Sample data for BS month lengths.
/// Each year maps to a list of 12 integers representing the days in each BS month.
/// This data is only provided for a few sample years. In a complete implementation,
/// you will need to include data for the full range of years you plan to support.
final Map<int, List<int>> bsMonthData = {
  2000: [30, 32, 31, 32, 31, 30, 30, 30, 29, 30, 29, 31],
  2001: [31, 31, 31, 32, 31, 30, 30, 30, 29, 30, 29, 31],
  2002: [31, 31, 31, 32, 31, 30, 30, 30, 29, 30, 29, 31],
};

/// Converts a Nepali (BS) date to an English (AD) date.
///
/// This function uses a base BS date of 2000-09-18 corresponding to AD 1944-04-13.
/// It calculates the day offset from the base date using the [bsMonthData] lookup table.
DateTime nepaliToEnglish(NepaliDate bsDate) {
  // Define the base conversion point.
  const int baseBsYear = 2000;
  const int baseBsMonth = 9;
  const int baseBsDay = 18;
  final DateTime baseAdDate = DateTime(1944, 4, 13);

  int totalDays = 0;

  if (bsDate.year == baseBsYear) {
    // If converting within the same year:
    if (bsDate.month == baseBsMonth) {
      totalDays += bsDate.day - baseBsDay;
    } else if (bsDate.month > baseBsMonth) {
      // Add remaining days in the base month.
      totalDays += bsMonthData[baseBsYear]![baseBsMonth - 1] - baseBsDay;
      // Add full months between the base month and the target month.
      for (int m = baseBsMonth + 1; m < bsDate.month; m++) {
        totalDays += bsMonthData[baseBsYear]![m - 1];
      }
      // Add days from the target month.
      totalDays += bsDate.day;
    } else {
      // For BS dates before the base month (within the same year), further logic is needed.
      throw Exception(
          "Conversion for dates before the base date is not implemented.");
    }
  } else if (bsDate.year > baseBsYear) {
    // For BS years after the base year:
    // 1. Add remaining days of the base month.
    totalDays += bsMonthData[baseBsYear]![baseBsMonth - 1] - baseBsDay;
    // 2. Add remaining months of the base year.
    for (int m = baseBsMonth + 1; m <= 12; m++) {
      totalDays += bsMonthData[baseBsYear]![m - 1];
    }
    // 3. Add full years between the base year and the target year.
    for (int year = baseBsYear + 1; year < bsDate.year; year++) {
      if (!bsMonthData.containsKey(year)) {
        throw Exception("BS data for year $year not available.");
      }
      totalDays += bsMonthData[year]!.reduce((a, b) => a + b);
    }
    // 4. Add months in the target year before the target month.
    if (!bsMonthData.containsKey(bsDate.year)) {
      throw Exception("BS data for year ${bsDate.year} not available.");
    }
    for (int m = 1; m < bsDate.month; m++) {
      totalDays += bsMonthData[bsDate.year]![m - 1];
    }
    // 5. Finally, add the days of the target month.
    totalDays += bsDate.day;
  } else {
    // For BS years before the base year.
    throw Exception(
        "Conversion for dates before the base date is not implemented.");
  }

  // Return the AD date by adding the total offset days to the base AD date.
  return baseAdDate.add(Duration(days: totalDays));
}

/// Converts an English (AD) date to a Nepali (BS) date.
///
/// This function calculates the difference in days from the base AD date (1944-04-13)
/// and maps it to the BS date using the [bsMonthData] table.
NepaliDate englishToNepali(DateTime adDate) {
  // Base conversion point.
  const int baseBsYear = 2000;
  const int baseBsMonth = 9;
  const int baseBsDay = 18;
  final DateTime baseAdDate = DateTime(1944, 4, 13);

  if (adDate.isBefore(baseAdDate)) {
    throw Exception(
        "Conversion for dates before the base date is not implemented.");
  }

  // Calculate the number of days between the given AD date and the base AD date.
  int diffDays = adDate.difference(baseAdDate).inDays;

  // Start from the base BS date.
  int bsYear = baseBsYear;
  int bsMonth = baseBsMonth;
  int bsDay = baseBsDay;

  // Adjust the days remaining in the base month.
  int daysInCurrentMonth = bsMonthData[bsYear]![bsMonth - 1] - bsDay;
  if (diffDays <= daysInCurrentMonth) {
    bsDay += diffDays;
    return NepaliDate(year: bsYear, month: bsMonth, day: bsDay);
  } else {
    diffDays -= daysInCurrentMonth;
    bsMonth++;
    bsDay = 0;
  }

  // Loop through the BS months (and years if necessary) until all days are accounted for.
  while (true) {
    // If the month exceeds 12, move to the next year.
    if (bsMonth > 12) {
      bsYear++;
      bsMonth = 1;
      if (!bsMonthData.containsKey(bsYear)) {
        throw Exception("BS data for year $bsYear not available.");
      }
    }
    int monthDays = bsMonthData[bsYear]![bsMonth - 1];
    if (diffDays < monthDays) {
      bsDay = diffDays + 1;
      break;
    } else {
      diffDays -= monthDays;
      bsMonth++;
    }
  }
  return NepaliDate(year: bsYear, month: bsMonth, day: bsDay);
}
