
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:qr/models/scan_model.dart';



class MapaPage extends StatefulWidget {
  @override
  _MapaPageState createState() => _MapaPageState();
}



class _MapaPageState extends State<MapaPage> {

  /* GOOGLE MAP CONTROLLER */
  Completer<GoogleMapController> _controller = Completer();
  /*  JUGAR CON EL TIPO DEL MAPA */
  MapType tipoMapa = MapType.normal;

  @override
  Widget build(BuildContext context) {

    final Scan scan = ModalRoute.of(context).settings.arguments;


    final CameraPosition puntoInicial = CameraPosition(
      target: scan.getLatLng() ,
      zoom: 17,
      /* inclinación */
      tilt: 50
    );

    /* MARCADORES */
    Set<Marker> misMarkers = new Set<Marker>();
    misMarkers.add(
      new Marker(
        markerId: MarkerId('geo-location'),
        position: scan.getLatLng()
      )
    );
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Coordenadas'),
        actions: [
          IconButton(
            icon: Icon( Icons.location_disabled ),
            onPressed: () async {

              final GoogleMapController controller = await _controller.future;

              controller.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: scan.getLatLng(),
                    zoom: 17,
                    tilt: 50
                  )
                )
              );

            },
          )
        ],
      ),
      body: GoogleMap(
        mapType: tipoMapa,
        markers: misMarkers,
        initialCameraPosition: puntoInicial,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon( Icons.layers ),
        onPressed: () {
          
          if ( tipoMapa == MapType.normal ) {
            tipoMapa = MapType.satellite;
          } else {
            tipoMapa = MapType.normal;
          }

          setState(() {
            
          });

        },
      ),
    );
  }
}