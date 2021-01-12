import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class JoinOrLogin extends ChangeNotifier {

  bool _isJoin = false;

  bool get isJoin => _isJoin;

  void toggle() {
    _isJoin = !_isJoin;
    notifyListeners();
  }
}