import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app_/providers/favourites_provider.dart';
import 'package:meals_app_/providers/filters_provider.dart';
import 'package:meals_app_/screens/categories.dart';
import 'package:meals_app_/screens/filters_screen.dart';
import 'package:meals_app_/screens/meals.dart';
import 'package:meals_app_/widgets/main_drawer.dart';

class TabScreen extends ConsumerStatefulWidget {
  const TabScreen({super.key});

  @override
  ConsumerState<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends ConsumerState<TabScreen> {
  int selectedPageIndex = 0;

  void changeTab(int index) {
    setState(() {
      selectedPageIndex = index;
    });
  }

  void _onSelectMealItem(String identifer) {
    Navigator.pop(context);
    if (identifer == 'filters') {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (ctx) => FiltersScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final favouriteMeals = ref.watch(FavouritesProvider);
    final availableMeals = ref.watch(mealsProvider);

    Widget activePage = CategoriesScreen(showMeal: availableMeals);
    String titleContent = 'Categories';

    if (selectedPageIndex == 1) {
      setState(() {
        activePage = MealsScren(meals: favouriteMeals);
        titleContent = 'Favourites';
      });
    }

    return Scaffold(
      appBar: AppBar(title: Text(titleContent)),
      body: activePage,
      drawer: MainDrawer(
        onSelectItem: (identifier) {
          _onSelectMealItem(identifier);
        },
      ),

      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          changeTab(index);
        },
        currentIndex: selectedPageIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favourites'),
        ],
      ),
    );
  }
}
