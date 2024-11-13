import 'package:flutter/material.dart';

class SelectionProvider with ChangeNotifier {
  double rating = 3.0;
  int selectedImageIndex = 0;
  int? selectedSizeIndex;
  String? selectedSize;

  //Update the rating value
  void updateRating(double newRating) {
    rating = newRating;
    notifyListeners();
  }

  //Update the selected image
  void updateSelectedImage(int newIndex) {
    selectedImageIndex = newIndex;
    notifyListeners();
  }

  // Update the selected size index and value
  void updateSelectedSize(int index, String size) {
    selectedSizeIndex = index;
    selectedSize = size;
    notifyListeners();
  }

  //clear selected size for each product
  void clearSelectedSize(){
    selectedSizeIndex = null;
    selectedSize = null;
  }

  
}
