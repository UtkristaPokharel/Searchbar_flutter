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
  final List<String> itemNames = [
    'Avocado',
    'Banana',
    'Tangerine',
    'Doughnut',
    'Carrot',
    'Chicken',
    'Mango',
    'Chips',
  ];
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
            setState(() {});
          },
          leading: const Icon(Icons.search),
          trailing: <Widget>[
            if (controller.text.isNotEmpty)
              IconButton(
                tooltip: 'Clear search',
                onPressed: () {
                  widget.onSearchChanged('');
                  try {
                    controller.text = '';
                  } catch (_) {}
                  setState(() {});
                },
                icon: const Icon(Icons.clear),
              ),

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
        final query = controller.text.trim().toLowerCase();
        final suggestions = query.isEmpty
            ? itemNames
            : itemNames.where((item) {
                final itemLower = item.toLowerCase();
                return itemLower.contains(query);
              }).toList();
        return List<Widget>.generate(suggestions.length, (int index) {
          final item = suggestions[index];
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
