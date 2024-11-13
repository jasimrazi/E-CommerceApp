import 'package:flutter/material.dart';

class SelectionProvider with ChangeNotifier {
  double rating = 3.0;
  int selectedImageIndex = 0;

  void updateRating(double newRating) {
    rating = newRating;
    notifyListeners();
  }

  void updateSelectedImage(int newIndex) {
    selectedImageIndex = newIndex;
    notifyListeners();
  }
}
