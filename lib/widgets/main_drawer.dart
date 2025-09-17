import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key, required this.onSelectItem});

  final Function(String identifier) onSelectItem;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: EdgeInsetsGeometry.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.onPrimary,
                  Theme.of(context).colorScheme.onPrimary.withValues(),
                ],
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.fastfood, size: 48, color: Colors.white),
                SizedBox(width: 10),
                Text(
                  'Cooking Up!',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge!.copyWith(color: Colors.orange),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.restaurant, size: 28, color: Colors.white),
            title: Text(
              'Meals',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 24,
              ),
            ),
            onTap: () {
              onSelectItem('meals');
            },
          ),
          ListTile(
            leading: Icon(Icons.settings, size: 28, color: Colors.white),
            title: Text(
              'Filters',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 24,
              ),
            ),
            onTap: () {
              onSelectItem('filters');
            },
          ),
        ],
      ),
    );
  }
}
