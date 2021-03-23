

import 'package:flutter/cupertino.dart';

class UiProvider extends ChangeNotifier {

  int _selectedMenuOption = 0;

  int get selectedMenuOption {
    return this._selectedMenuOption;
  }

  set selectedMenuOption( int i ) {
    this._selectedMenuOption = i;
    // Notificar a todos los widgets
    notifyListeners();
  }


}