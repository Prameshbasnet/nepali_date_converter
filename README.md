# Nepali Date Converter (BS ⇄ AD)

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

A Flutter package for converting dates between Nepali Bikram Sambat (BS) and English Gregorian (AD) calendars using official calendar data from [saralpatro.com](https://saralpatro.com).

## Features

- **📅 Simple Date Conversion**  
  Convert between BS and AD.
- **🗃️ Preloaded Dataset**  
  Includes dates from **2000 BS (1943 AD)** to **2089 BS (2033 AD)**
- **🛡️ Type Safe**  
  Strongly typed `NepaliDate` and `AdDate` models
- **🔍 Null Safe**  
  Returns `null` for dates outside dataset range

## Installation

Add this to your app's `pubspec.yaml`:

```yaml
dependencies:
  nepali_date_converter: ^0.0.3
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

## License

```
MIT License

Copyright (c) [2025] [Pramesh-Basnet]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included
in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
IN THE SOFTWARE.
```
