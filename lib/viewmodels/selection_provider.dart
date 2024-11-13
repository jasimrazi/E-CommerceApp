import 'package:flutter/material.dart';

class SelectionProvider with ChangeNotifier {
  double rating = 3.0;


  void updateRating(double newRating) {
    rating = newRating;
    notifyListeners();
  }
}
