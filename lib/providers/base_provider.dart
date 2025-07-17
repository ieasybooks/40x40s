import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:fourtyfourties/services/api.dart';

class BaseProvider with ChangeNotifier {
  final Api api = Api();
  bool busy = false;
  bool moreBusy = false;
  bool failed = false;
  bool isPagenating = false;

  setBusy(bool value) {
    Timer(const Duration(milliseconds: 50), () {
      busy = value;
      notifyListeners();
    });
  }

  setMoreBusy(bool value) {
    Timer(const Duration(milliseconds: 50), () {
      moreBusy = value;
      notifyListeners();
    });
  }

  setFailed(bool value) {
    Timer(const Duration(milliseconds: 50), () {
      failed = value;
      notifyListeners();
    });
  }

  setPagenation(bool value) {
    Timer(const Duration(milliseconds: 50), () {
      isPagenating = value;
      notifyListeners();
    });
  }
}
