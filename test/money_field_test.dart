import 'package:flutter_test/flutter_test.dart';

import 'package:money_field/money_field.dart';

void main() {
	test('allows zero to one decimal separator', () {
		final MoneyFieldController controller = MoneyFieldController();

		controller.text = '12.12.12';
		expect(controller.isInputValid(), false);

		controller.text = '12.12';
		expect(controller.isInputValid(), true);

		controller.text = '12';
		expect(controller.isInputValid(), true);
	});

	test('requires two digits after decimal separator', () {
		final MoneyFieldController controller = MoneyFieldController();

		controller.text = '12.1';
		expect(controller.isInputValid(), false);

		controller.text = '12.123';
		expect(controller.isInputValid(), false);

		controller.text = '12.12';
		expect(controller.isInputValid(), true);
	});

	test('throws error when over max digits', () {
		final MoneyFieldController controller = MoneyFieldController(maxDigitsBeforeDecimal: 2);

		controller.text = '12';
		expect(controller.isInputValid(), true);

		controller.text = '12.34';
		expect(controller.isInputValid(), true);

		controller.text = '123';
		expect(controller.isInputValid(), false);

		controller.text = '123.45';
		expect(controller.isInputValid(), false);
	});

	test('properly sanitizes thousands separators from input', () {
		final MoneyFieldController controller = MoneyFieldController();

		controller.text = '123,456.78';
		String sanitized = controller.getSanitizedInput();
		expect('123456.78', sanitized);

		controller.text = '123,456,789';
		sanitized = controller.getSanitizedInput();
		expect('123456789', sanitized);
	});

	test('properly converts input to a double', () {
		final MoneyFieldController controller = MoneyFieldController();

		controller.text = '123,456.78';
		double value = 123456.78;
		expect(controller.doubleValue(), value);

		controller.text = '123,456';
		value = 123456;
		expect(controller.doubleValue(), value);

		controller.text = '1234.56';
		value = 1234.56;
		expect(controller.doubleValue(), value);

		controller.text = '1234';
		value = 1234;
		expect(controller.doubleValue(), value);
	});

	test('properly validates thousands separator', () {
		final MoneyFieldController controller = MoneyFieldController();

		controller.text = '12,34';
		expect(controller.isInputValid(), false);

		controller.text = '12,34.56';
		expect(controller.isInputValid(), false);

		controller.text = '12,345';
		expect(controller.isInputValid(), true);

		controller.text = '12,345,678.90';
		expect(controller.isInputValid(), true);
	});
	
	test('returns correct error string', () {
		final MoneyFieldController controller = MoneyFieldController();

		controller.text = '12,34';
		expect(controller.moneyFieldValidator(), controller.invalidFormatError);

		controller.text = '1234567890.12';
		expect(controller.moneyFieldValidator(), controller.invalidLengthError);
	});
}
