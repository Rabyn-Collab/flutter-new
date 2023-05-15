import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/food_state.dart';
import '../services/movie_service.dart';

final mealProvider = StateNotifierProvider<MealProvider, FoodState>((ref) => MealProvider(
    FoodState(errText: '', isLoad: false, isError: false, isSuccess: false,
        meal: null )
));


class MealProvider extends StateNotifier<FoodState>{
  MealProvider(super.state);


  Future<void> getMeal({required String query})async{
    state = state.copyWith(isLoad: true, isError: false, isSuccess: false);
    final response = await FoodService.getMeals(query: query);
    response.fold(
            (l) => state = state.copyWith(isSuccess: false, isError: true, errText: l, isLoad: false,meal: null),
            (r) => state = state.copyWith(isSuccess: true, isError: false, errText: '', isLoad: false, meal: r)
    );
  }

}