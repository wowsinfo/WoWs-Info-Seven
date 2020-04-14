import 'package:wowsinfo/core/models/UI/WebsiteItem.dart';

class WebsiteSection {
  String title;
  String subtitle;
  List<WebsiteItem> items = [];

  WebsiteSection(this.title, this.subtitle, this.items);
}