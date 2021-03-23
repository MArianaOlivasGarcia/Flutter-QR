import 'package:flutter/material.dart';
import 'package:qr/models/scan_model.dart';
import 'package:qr/providers/db_provider.dart';

class ScanProvider extends ChangeNotifier {

  List<Scan> scans = [];
  String tipoSeleccionado = 'http';

  Future<Scan> crearScan( String valor ) async {

    final nuevoScan = new Scan(valor: valor);
    // Ya que retorna el id del nuevo elemento creado
    final id = await DBProvider.db.nuevoScan(nuevoScan);
    // Asignar el id de la base de datos al modelo
    nuevoScan.id = id;

    // Para que se muestre en la interfaz del usuario
    if ( this.tipoSeleccionado == nuevoScan.tipo ) {
      this.scans.add( nuevoScan );
      notifyListeners();
    }

    return nuevoScan;
  }



  cargarScans() async {
    final scans = await DBProvider.db.getScans();
    this.scans = [...scans];
    notifyListeners();
  }


  cargarScansPorTipo( String tipo ) async {
    final scans = await DBProvider.db.getScansByTipo( tipo );
    this.tipoSeleccionado = tipo;
    this.scans = [...scans];
    notifyListeners();
  }


  borrarTodos() async {
    await DBProvider.db.deleteAllScans();
    this.scans = [];
    notifyListeners();
  }

  borrarScanPorId( int id ) async {
    await DBProvider.db.deleteScanById( id );
    // Dentro del cargarScansPorTipo llama el notifyListeners
    // this.cargarScansPorTipo( this.tipoSeleccionado );
 
  }

}