

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr/providers/ui_provider.dart';

class CustomNavigationBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    // Obtener el selectedMenuOption del provider
    final uiProvider = Provider.of<UiProvider>(context);

    final currentIndex = uiProvider.selectedMenuOption;


    return BottomNavigationBar(
      currentIndex: currentIndex,
      // set del provider, es como una asignacion a una propiedad =
      onTap: ( int i ) => uiProvider.selectedMenuOption = i,
      elevation: 0,
      items: <BottomNavigationBarItem>[
        
        BottomNavigationBarItem(
          icon: Icon ( Icons.map ),
          label: 'Mapa'
        ),

        BottomNavigationBarItem(
          icon: Icon ( Icons.compass_calibration ),
          label: 'Direcciones',
        )

      ],
    );
  }
}