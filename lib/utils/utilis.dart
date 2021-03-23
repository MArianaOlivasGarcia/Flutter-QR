
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:qr/models/scan_model.dart';

void launchURL( BuildContext context, Scan scan ) async {
  
  final url = scan.valor;

  if ( scan.tipo == 'http' ) {
    await canLaunch(url) 
        ? await launch(url) 
        : throw 'Could not launch $url';

  } else {
    // GEO 
    Navigator.pushNamed(context, 'mapas', arguments: scan);
  }

  
}