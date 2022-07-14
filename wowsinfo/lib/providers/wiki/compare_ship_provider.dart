import 'package:flutter/foundation.dart';
import 'package:wowsinfo/models/wowsinfo/ship_filter.dart';

class CompareShipProvider with ChangeNotifier {
  ShipFilter? _filter;
  set filter(ShipFilter value) {
    _filter = value;
    notifyListeners();
  }
}
