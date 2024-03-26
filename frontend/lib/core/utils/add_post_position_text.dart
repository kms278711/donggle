import 'package:flutter/material.dart';

String postPositionText(String name) {
  // Get the last character of the name
  final String? lastText = name.isNotEmpty ? name.characters.last : null;

  if (lastText == null) {
    return name;
  }
  // Convert to Unicode
  final int unicodeVal = lastText.runes.first;
  // Return the name if it's not a Hangul syllable
  if (unicodeVal < 0xAC00 || unicodeVal > 0xD7A3) {
    return name;
  }
  // Check if there's a final consonant
  final int last = (unicodeVal - 0xAC00) % 28;
  // Append '을' if there is a final consonant, otherwise '를'
  final String str = last > 0 ? "을" : "를";
  return name + str;
}