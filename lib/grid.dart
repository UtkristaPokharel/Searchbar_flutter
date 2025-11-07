import 'package:flutter/material.dart';

class Mygrid extends StatelessWidget {
  final String searchQuery;
  const Mygrid({super.key, this.searchQuery = ''});

  @override
  Widget build(BuildContext context) {
    final itemNames = [
  'Avocado',
  'Banana',
  'Tangerine',
  'Doughnut',
  'Carrot',
  'Chicken',
  'Mango',
  'Chips',
];
    final items = List.generate(
      itemNames.length,
      (i) => {
        'image': 'assets/images/pic${i + 1}.jpeg',
        'title': itemNames[i],
      },
    );

    final query = searchQuery.trim().toLowerCase();

    final filtered = query.isEmpty
        ? items
        : items.where((item) {
            final title = (item['title'] as String).toLowerCase();
            return title.contains(query);
          }).toList();

    return Expanded(
      child: filtered.isEmpty
          ? Center(
              child: Text(
                'No results found',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            )
          : GridView.builder(
              itemCount: filtered.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12.0,
                mainAxisSpacing: 12.0,
                childAspectRatio: 0.72,
              ),
              itemBuilder: (BuildContext context, int index) {
                final item = filtered[index];
                final imagePath = item['image'] as String;
                final title = item['title'] as String;

                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Expanded(
                        child: ClipRRect(
                          child: Image.asset(
                            imagePath,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Theme.of(
                                  context,
                                ).colorScheme.primary.withAlpha(26),
                                child: Center(
                                  child: Icon(
                                    Icons.broken_image,
                                    size: 48,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Builder(
                          builder: (BuildContext context) {
                            final Color textColor = Theme.of(
                              context,
                            ).colorScheme.onSurface;

                            return Text(
                              title,
                              textAlign: TextAlign.center,
                              style: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.copyWith(color: textColor),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
