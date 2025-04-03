# Nepali Date Converter (BS ⇄ AD)

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

A Flutter package for converting dates between Nepali Bikram Sambat (BS) and English Gregorian (AD) calendars using official calendar data from [saralpatro.com](https://saralpatro.com).

## Features

- **📅 Simple Date Conversion**  
  Convert between BS and AD.
- **🗃️ Preloaded Dataset**  
  Includes dates from **1975 BS (1918 AD)** to **2099 BS (2043 AD)**
- **🛡️ Type Safe**  
  Strongly typed `NepaliDate` and `AdDate` models
- **🔍 Null Safe**  
  Returns `null` for dates outside dataset range

## Installation

Add this to your app's `pubspec.yaml`:

```yaml
dependencies:
  nepali_date_converter: ^1.0.3
```

## Basic Usage

```dart
import 'package:nepali_date_converter/nepali_date_converter.dart';
```

### BS → AD Conversion

```dart
final bsDate = NepaliDate(year: 2081, month: 12, day: 16);
final adDate = converter.convertBsToAd(bsDate);
print(adDate); // AdDate(2025, 3, 30)
```

### AD → BS Conversion

```dart
final adDate = AdDate(year: 2025, month: 3, day: 30);
final bsDate = converter.convertAdToBs(adDate);
print(bsDate); // NepaliDate(2081, 12, 16)
```
