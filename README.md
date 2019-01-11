# Money Field

A simple to use TextEditingController for handling money values.

## Install

### 1. Add money_field to your pubspec.yaml:

```yaml
dependencies:
    money_field: ^1.0.0
```

### 2. Install it

```
flutter packages get
```

### 3. Import it:

```dart
import 'package:money_field/money_field.dart';
```

## Usage

```dart
final _moneyFieldController = MoneyFieldController();

...

TextFormField(
    controller: _moneyFieldController,
    keyboardType: TextInputType.number,
),
```

### Customization Options

```dart
final _moneyFieldController = MoneyFieldController(
    decimalSeparator = '.',
    thousandsSeparator = ',',
    invalidFormatError = 'Invalid input format',
    invalidLengthError = 'Length must be less than or equal to 9',
    maxDigitsBeforeDecimal = 9
);
```

### Convert Input to Double

```dart
final _moneyFieldController = MoneyFieldController();

var doubleValue = _moneyFieldController.doubleValue();
```

### Field Validation

```dart
final _moneyFieldController = MoneyFieldController();

TextFormField(
    controller: _moneyFieldController,
    keyboardType: TextInputType.number,
    validator: (_) {
        return _moneyFieldController.moneyFieldValidator();
    },
),
```

### Check if Input is Valid

If you'd just like to check if the input is valid, without using the validator, you can:

```dart
final _moneyFieldController = MoneyFieldController();

bool isFormatValid = _moneyFieldController.isFormatValid();
bool isLengthValid = _moneyFieldController.isLengthValid();

// Checks if format and length are valid
bool isValid = _moneyFieldController.isInputValid();
```

## Issues

If you encounter any issues, feel free to post them on the [GitHub page](https://github.com/Erigitic/money-field/issues).