


import 'meal.dart';

class FoodState{

  final Meal? meal;
  final bool isLoad;
  final bool isError;
  final String errText;
  final bool isSuccess;

  FoodState({
    required this.errText,
    required this.isLoad,
    required this.isError,
    required this.isSuccess,
     this.meal
  });


  FoodState copyWith({
    Meal? meal,
    bool? isLoad,
    bool? isError,
    String? errText,
    bool? isSuccess,
  }){
    return FoodState(
        errText: errText ?? this.errText,
        isLoad: isLoad ?? this.isLoad,
        isError: isError ?? this.isError,
        isSuccess: isSuccess ?? this.isSuccess,
      meal: meal ?? this.meal

    );
  }




}