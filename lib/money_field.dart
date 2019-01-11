library money_field;

import 'package:flutter/material.dart';

class MoneyFieldController extends TextEditingController {
	final String decimalSeparator;
	final String thousandsSeparator;
	final String invalidFormatError;
	final String invalidLengthError;
	final int maxDigitsBeforeDecimal;

	MoneyFieldController({
		this.decimalSeparator = '.',
		this.thousandsSeparator = ',',
		this.invalidFormatError = 'Invalid input format',
		this.invalidLengthError = 'Length must be less than or equal to 9',
		this.maxDigitsBeforeDecimal = 9
	}) {
		_validateParameters();
	}
	
	double doubleValue() {
		if (isInputValid()) {
			String sanitizedInput = getSanitizedInput();

			return double.parse(sanitizedInput);
		}

		return 0.00;
	}

	/// Sanitizes the field input of the thousands separator to ensure proper parsing.
	String getSanitizedInput() {
		String tempText = this.text;

		tempText = tempText.replaceAll(this.thousandsSeparator, '');

		return tempText;
	}

	/// Checks to make sure the parameters are valid in order to avoid any issues.
	void _validateParameters() {
		if (this.decimalSeparator == this.thousandsSeparator) {
			throw new ArgumentError('Separators can\'t have the same vlaue.');
		}
	}

	/// Checks if the input format is valid.
	/// 
	/// Returns true if the input matches the regex.
	bool isFormatValid() {
		var regExp = new RegExp(r'(?=.*?\d)^(([1-9]\d{0,2}(\' + this.thousandsSeparator + '\\d{3})*)|\\d+)?(\\' + this.decimalSeparator + '\\d{2})?\$');

		return regExp.hasMatch(this.text);
	}

	/// Checks if the input length is valid.
	/// 
	/// Returns true if the length is <= [this.maxDigitsBeforeDecimal].
	bool isLengthValid() {
		return getSanitizedInput().split(this.decimalSeparator)[0].length <= this.maxDigitsBeforeDecimal;
	}

	/// Checks if the format and length of input is valid.
	/// 
	/// Returns true if valid.
	bool isInputValid() {
		return isFormatValid() && isLengthValid();
	}

	/// Validates the field and returns the proper error message, or null if there is no error.
	String moneyFieldValidator() {
		if (!isFormatValid()) {
			return this.invalidFormatError;
		}

		if (!isLengthValid()) {
			return this.invalidLengthError;
		}

		return null;
	}
}
