import 'package:flutter/material.dart';
import 'package:meals_app_/models/meals.dart';
import 'package:meals_app_/screens/meals_details.dart';
import 'package:meals_app_/widgets/meal_item.dart';

class MealsScren extends StatelessWidget {
  const MealsScren({super.key, this.title, required this.meals});

  final String? title;
  final List<Meal> meals;

  void selectMeal(Meal meal, BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (ctx) => MealsDetailsScreen(meal: meal)));
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemCount: meals.length,
      itemBuilder: (context, index) => MealItem(
        meal: meals[index],
        onTapMealItem: (Meal meal) {
          selectMeal(meal, context);
        },
      ),
    );

    if (meals.isEmpty) {
      content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Oop....Nothing here',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 5),
            Text(
              'Try Selecting Another Category',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ],
        ),
      );
    }

    if (title == null) {
      return content;
    }

    return Scaffold(
      appBar: AppBar(title: Text(title!)),
      body: content,
    );
  }
}
