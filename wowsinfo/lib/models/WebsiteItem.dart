/// A simple object that holds some data for a website
class WebsiteItem {
  String title;
  String link;
  bool favourite;

  WebsiteItem(this.title, this.link, {this.favourite = false});
}
