import 'package:wowsinfo/services/data/BaseDataProvider.dart';

/// This gets data via API or something similar
abstract class APIDataProvider<T> extends BaseDataProvider<T> {
  // The address of the link, usually made of a base link and extra fields
  String getRequestLink() => getBaseLink() + getExtraFields();
  String getBaseLink();
  String getExtraFields();
}
