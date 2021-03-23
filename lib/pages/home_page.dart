
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr/pages/direcciones_page.dart';
import 'package:qr/pages/mapas_page.dart';
import 'package:qr/providers/scan_provider.dart';
import 'package:qr/providers/ui_provider.dart';
import 'package:qr/widgets/custom_navigationBar.dart';
import 'package:qr/widgets/scan_button.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Historial'),
        actions: [
          IconButton(
            onPressed: (){
              // Puedo llamar directamente el metodo sin almacenarlo en una variable
              Provider.of<ScanProvider>(context, listen: false).borrarTodos();
            },
            icon: Icon( Icons.delete_forever_outlined )
          )
        ],
      ),
      body: _HomePageBody(),
      bottomNavigationBar: CustomNavigationBar(),
      floatingActionButton: ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}





class _HomePageBody extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

      // Obtener el selectedMenuOption del provider
      final uiProvider = Provider.of<UiProvider>(context);
    
      final currentIndex = uiProvider.selectedMenuOption;

      // Usar el ScanListProvider
      // Listen en false, porque este no es el punto cuando quiero que se redibuje
      final scanProvider = Provider.of<ScanProvider>(context, listen: false);



      switch ( currentIndex ) {
        case 0:
          scanProvider.cargarScansPorTipo('geo');
          return MapasPage();
          
        case 1:
          scanProvider.cargarScansPorTipo('http');
          return DireccionesPage();
      
        default:
          return MapasPage();
      }

  }
}