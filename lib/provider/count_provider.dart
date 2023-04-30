import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



final personName = Provider((ref) => 'hello world');
final countProvider = ChangeNotifierProvider((ref) => CountProvider());

final count = StateProvider<int>((ref) => 100);

class CountProvider extends ChangeNotifier{
  int number = 0;


  void increment(){
    number++;
    notifyListeners();
  }


  void decrement(){
  number--;
  notifyListeners();
  }



}