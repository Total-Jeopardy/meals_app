import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app_/models/meals.dart';
import 'package:meals_app_/providers/favourites_provider.dart';

class MealsDetailsScreen extends ConsumerWidget {
  const MealsDetailsScreen({super.key, required this.meal});

  final Meal meal;

  void showSnackBars(BuildContext context) {}

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favouriteMeals = ref.watch(FavouritesProvider);
    final isFavourite = favouriteMeals.contains(meal);

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
            onPressed: () {
              final wasAdded = ref
                  .read(FavouritesProvider.notifier)
                  .toggleFavouriteStatus(meal);
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: Duration(milliseconds: 700),
                  content: Text(
                    wasAdded
                        ? 'Meal Added to Favourites'
                        : 'Meal Removed From Favourites',
                  ),
                ),
              );
            },
            icon: AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return RotationTransition(
                  turns: Tween(begin: 0.75, end: 1.0).animate(animation),
                  child: child,
                );
              },
              child: Icon(
                isFavourite ? Icons.star : Icons.star_border,
                key: ValueKey(isFavourite),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Hero(
                tag: meal.id,
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(16),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Image(
                    image: NetworkImage(meal.imageUrl),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 300,
                  ),
                ),
              ),
              SizedBox(height: 12),
              Text(
                'Ingredients',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              for (final ingredients in meal.ingredients)
                Text(
                  ingredients,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              SizedBox(height: 24),
              for (final stpe in meal.steps)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 8,
                  ),
                  child: Text(
                    textAlign: TextAlign.center,
                    stpe,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
