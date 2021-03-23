
import 'package:flutter/material.dart';
import 'package:qr/widgets/scan_list.dart';

class DireccionesPage extends StatelessWidget {

   @override
  Widget build(BuildContext context) {

    return ScanList(tipo: 'http');

  }
  

}