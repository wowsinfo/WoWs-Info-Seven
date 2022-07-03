import 'package:flutter/material.dart';
import 'package:wowsinfo/localisation/localisation.dart';

class AppSettingsPage extends StatefulWidget {
  const AppSettingsPage({Key? key}) : super(key: key);

  @override
  State<AppSettingsPage> createState() => _AppSettingsPageState();
}

class _AppSettingsPageState extends State<AppSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Localisation.of(context).app_name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _DropdownListTile(
              options: ['A', 'B', 'C'],
              title: Text('Server'),
              value: 'A',
              onChanged: (value) {},
            ),
            const Divider(),
            CheckboxListTile(
              title: Text('Dark mode'),
              value: true,
              onChanged: (checked) {},
            ),
            ListTile(
              title: Text('Theme colour'),
              subtitle: Container(
                color: Colors.blue,
                height: 24,
              ),
              onTap: () {},
            ),
            const Divider(),
            ListTile(
              title: Text(Localisation.of(context).settings_app_send_feedback),
              subtitle: Text(
                Localisation.of(context).settings_app_send_feedback_subtitle,
              ),
              onTap: () {},
            ),
            ListTile(
              title: Text(Localisation.of(context).settings_app_report_issues),
              subtitle: Text('TODO: add the github link here'),
              onTap: () {},
            ),
            const Divider(),
            ListTile(
              title: Text(Localisation.of(context).settings_open_source_github),
              subtitle: Text('TODO: add the github link here'),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                Localisation.of(context).settings_open_source_licence,
              ),
              onTap: () {
                showAboutDialog(context: context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// A customised [ListTile] that displays a dropdown menu in the subtitle.
class _DropdownListTile extends StatelessWidget {
  const _DropdownListTile({
    Key? key,
    required this.options,
    required this.value,
    required this.title,
    required this.onChanged,
  }) : super(key: key);

  final List<String> options;
  final String value;
  final Widget title;
  final void Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    GlobalKey? dropdownButtonKey = GlobalKey();

    void openDropdown() {
      GestureDetector? detector;

      /// Find the button that opens the dropdown
      void searchForGestureDetector(BuildContext? element) {
        element?.visitChildElements((element) {
          if (element.widget is GestureDetector) {
            detector = element.widget as GestureDetector?;
          } else {
            searchForGestureDetector(element);
          }
        });
      }

      searchForGestureDetector(dropdownButtonKey.currentContext);
      assert(detector != null, 'Dropdown button not found');

      detector?.onTap?.call();
    }

    // PopupMenuButton should be used instead
    return ListTile(
      onTap: () => openDropdown(),
      title: title,
      subtitle: AbsorbPointer(
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            key: dropdownButtonKey,
            isExpanded: true,
            isDense: true, // shrink the dropdown button
            focusColor: Colors.transparent, // hides the focus within dropdown
            value: value,
            items: options
                .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
                .toList(growable: false),
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }
}
