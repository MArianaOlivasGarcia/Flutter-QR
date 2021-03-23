
import 'dart:convert';
// Para importar el @required
import 'package:meta/meta.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;


Scan scanFromJson(String str) => Scan.fromJson(json.decode(str));

String scanToJson(Scan data) => json.encode(data.toJson());

class Scan {
    Scan({
        this.id,
        this.tipo,
        @required this.valor,
    }) {

      if ( this.valor.contains('http') ) {
        this.tipo = 'http';
      } else {
        this.tipo = 'geo';
      }

    }

    int id;
    String tipo;
    String valor;


    LatLng getLatLng(){

      final latLng = this.valor.substring(4).split(',');
      final lat = double.parse( latLng[0] );
      final lng = double.parse( latLng[1] );

      return LatLng(lat,lng);
      
    }

    factory Scan.fromJson(Map<String, dynamic> json ) => Scan(
        id: json["id"],
        tipo: json["tipo"],
        valor: json["valor"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "tipo": tipo,
        "valor": valor,
    };
}
