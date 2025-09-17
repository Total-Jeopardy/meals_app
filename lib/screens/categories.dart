import 'package:flutter/material.dart';
import 'package:meals_app_/data/dummy_data.dart';
import 'package:meals_app_/models/categories.dart';
import 'package:meals_app_/models/meals.dart';
import 'package:meals_app_/screens/meals.dart';
import 'package:meals_app_/widgets/category_item.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key, required this.showMeal});

  final List<Meal> showMeal;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _aniimationController;

  @override
  void initState() {
    _aniimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    super.initState();

    _aniimationController.forward();
  }

  @override
  void dispose() {
    _aniimationController.dispose();
    super.dispose();
  }

  void onTapCategoryItem(BuildContext context, Category category) {
    final List<Meal> categorizedList = widget.showMeal
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) =>
            MealsScren(title: category.title, meals: categorizedList),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: AnimatedBuilder(
          animation: _aniimationController,
          child: GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            children: [
              for (final category in availableCategories)
                CategoryItem(
                  category: category,
                  onSelectCategory: () {
                    onTapCategoryItem(context, category);
                  },
                ),
            ],
          ),
          builder: (context, child) => SlideTransition(
            position: Tween(begin: Offset(0, 0.3), end: Offset(0, 0)).animate(
              CurvedAnimation(
                parent: _aniimationController,
                curve: Curves.easeInBack,
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
