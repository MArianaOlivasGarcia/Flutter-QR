import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr/pages/home_page.dart';
import 'package:qr/pages/mapa_page.dart';
import 'package:qr/providers/scan_provider.dart';
import 'package:qr/providers/ui_provider.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider( create: (_) => new UiProvider() ),
        ChangeNotifierProvider( create: (_) => new ScanProvider() ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'QR Reader',
        initialRoute: 'home',
        routes: {
          'home': (_) => HomePage(),
          'mapas': (_) => MapaPage(),
        },
        /* theme: ThemeData.dark() */
        theme: ThemeData(
          primaryColor: Colors.deepPurple,
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.deepPurple
          )
        )
      ),
    );
  }
}