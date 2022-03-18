import 'package:flutter/material.dart';

class IndexToSave with ChangeNotifier {
  int indexSaved = -1;

  int get indexNew => indexSaved;

  void setIndex(int passedIndex) {
    indexSaved = passedIndex;
    notifyListeners();
  }
}