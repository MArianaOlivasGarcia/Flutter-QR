
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr/providers/scan_provider.dart';
import 'package:qr/utils/utilis.dart' as utils;

class ScanList extends StatelessWidget {

  final String tipo;

  const ScanList({Key key, @required this.tipo}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // Aquí si necesito estar escuchando los cambios
    // cuando haya un nuevo scan se redibuja
    // dentro de un build normalmente es listen: true
    final scanProvider = Provider.of<ScanProvider>(context);
    final scans = scanProvider.scans;
    
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: scans.length,
      itemBuilder: ( _, i ) => Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.red[400],
        ),
        onDismissed: (DismissDirection direction) {
          
          Provider.of<ScanProvider>(context, listen: false).borrarScanPorId( scans[i].id );

        },
        child: ListTile(
          leading: Icon( this.tipo == 'http' ? Icons.home : Icons.map,
            color: Theme.of(context).primaryColor
          ),
          title: Text( scans[i].valor ),
          subtitle: Text( scans[i].id.toString() ),
          trailing: Icon( Icons.keyboard_arrow_right_outlined,
            color: Colors.grey
          ),
          onTap: () => utils.launchURL(context, scans[i])
        ),
      ),
    );
  }
}