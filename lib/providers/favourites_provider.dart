import 'package:flutter_riverpod/legacy.dart';
import 'package:meals_app_/models/meals.dart';

class FavouriteNofier extends StateNotifier<List<Meal>> {
  FavouriteNofier() : super([]);

  bool toggleFavouriteStatus(Meal meal) {
    final isMealFavourite = state.contains(meal);

    if (isMealFavourite) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final FavouritesProvider = StateNotifierProvider<FavouriteNofier, List<Meal>>((
  ref,
) {
  return FavouriteNofier();
});
