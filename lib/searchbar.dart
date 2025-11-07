import 'package:flutter/material.dart';

class MySearchBar extends StatefulWidget {
  final bool isDark;
  final ValueChanged<bool> onThemeToggle;
  final ValueChanged<String> onSearchChanged;

  const MySearchBar({
    super.key,
    required this.isDark,
    required this.onThemeToggle,
    required this.onSearchChanged,
  });

  @override
  State<MySearchBar> createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
      builder: (BuildContext context, SearchController controller) {
        return SearchBar(
          controller: controller,
          hintText: 'Search...',
          padding: const WidgetStatePropertyAll<EdgeInsets>(
            EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          ),
          onTap: () {
            controller.openView();
          },
          onChanged: (String value) {
            controller.openView();
            widget.onSearchChanged(value);
          },
          leading: const Icon(Icons.search),
          trailing: <Widget>[
            Tooltip(
              message: 'Change brightness mode',
              child: IconButton(
                isSelected: widget.isDark,
                onPressed: () {
                  widget.onThemeToggle(!widget.isDark);
                },
                icon: const Icon(Icons.wb_sunny_outlined),
                selectedIcon: const Icon(Icons.brightness_2_outlined),
              ),
            ),
          ],
        );
      },
      suggestionsBuilder: (BuildContext context, SearchController controller) {
        return List<Widget>.generate(8, (int index) {
          final item = 'Item ${index + 1}';
          return ListTile(
            title: Text(item),
            onTap: () {
              widget.onSearchChanged(item);
              controller.closeView(item);
            },
          );
        });
      },
    );
  }
}
