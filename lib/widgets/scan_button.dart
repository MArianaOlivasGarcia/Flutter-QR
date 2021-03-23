import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr/providers/scan_provider.dart';
import 'package:qr/utils/utilis.dart' as utils;

class ScanButton extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon( Icons.filter_center_focus ),
      onPressed: () async {

        String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                                                    '#3D8BEF', 
                                                    'Cancelar', 
                                                    false, 
                                                    ScanMode.QR );
        /* print( barcodeScanRes ); */
        if ( barcodeScanRes == '-1' ) {
          // El usuario cancelo
          return;
        }

        // Pista: Cuando esta la instancia dentro de un método siempre es listen: false
        final scanProvider = Provider.of<ScanProvider>(context, listen: false);
        final nuevoScan = await scanProvider.crearScan( barcodeScanRes );

        utils.launchURL(context, nuevoScan);

      },
    );
  }


}