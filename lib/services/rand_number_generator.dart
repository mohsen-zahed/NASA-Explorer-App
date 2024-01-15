import 'package:flutter/material.dart';

class NumberGenerator {
  static int _lastNumber = 2;
  static int _numberForOthers = 1;
  static List<int> _generatedNumbersForOthers = [];
  static List<int> _generatedNumbers = [];

  static int generateNumber() {
    _lastNumber++;
    _generatedNumbers.add(_lastNumber);
    return _lastNumber;
  }

  static int generateNumbersForOther() {
    _numberForOthers++;
    _generatedNumbersForOthers.add(_numberForOthers);
    return _numberForOthers;
  }

  static List<int> getGeneratedNumbers() {
    return _generatedNumbers;
  }

  static int getLastGeneratedNumber() {
    return _lastNumber;
  }
}
