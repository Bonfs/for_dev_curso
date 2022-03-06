import 'package:flutter/widgets.dart';

import './strings/strings.dart';

class R {
  R._();

  static Translations strings = PtBr();

  static void load(Locale locale) {
    switch(locale.toString()) {
      case 'en_US':
        R.strings = EnUs();
        break;
      default:
        R.strings = PtBr();
    }
  }
}