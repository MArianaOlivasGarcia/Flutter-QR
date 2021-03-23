import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
// Cuando use mi DBProvider probablemente use el Scan model
// Asi que tambien lo voy exportar para que no haya 
// necesidad de importarlo
import 'package:qr/models/scan_model.dart';
export 'package:qr/models/scan_model.dart';

/* Crear un Singleton */
class DBProvider {

  static Database _database;

  // Mi instancia de mi clase 
  static final DBProvider db = DBProvider._();


  // Constructor privador
  DBProvider._();


  Future<Database> get database async{
    if ( _database != null ) return _database;
    
    _database = await initDB();

    return _database;
  }


  Future<Database> initDB() async {

    // Path donde almacenaremos la base de datos
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    // .db es la extencion de sql
    final path = join( documentsDirectory.path, 'ScansDB.db');
    print( path );

    // Crear la base de datos
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {

        // Ya estaría creada la base de datos
        await db.execute('''
          CREATE TABLE Scans(
            id INTEGER PRIMARY KEY,
            tipo TEXT,
            valor TEXT
          );
        ''');

      }
    );

  }


  Future<int> nuevoScanRaw( Scan scan ) async {

    final id    = scan.id;
    final tipo  = scan.tipo;
    final valor = scan.valor;
    
    // Espere a que la base de batos este lista
    final db = await database;

    final res = await db.rawInsert('''
      INSERT INTO Scans(id, tipo, valor)
      VALUES( $id, '$tipo', '$valor' )
    ''');

    return res;
  }


  Future<int> nuevoScan( Scan scan ) async {

    final db = await database;
    final res = await db.insert('Scans', scan.toJson() );
    // res es el Id del registro insertado

    return res;

  }




  Future<Scan> getScanById( int id ) async {

    final db = await database;
    // Mandar los argumentos en orden en whereArgs
    final res = await db.query('Scans', where: 'id = ?', whereArgs: [id]);
    // res es una lista, y el scan seria el primero
    return res.isNotEmpty ? Scan.fromJson(res.first) : null;

  }

  Future<List<Scan>> getScans() async {

    final db = await database;
    // Mandar los argumentos en orden en whereArgs
    final res = await db.query('Scans');
    
    return res.isNotEmpty ? res.map((scan) => Scan.fromJson(scan)).toList() : [];

  }



  Future<List<Scan>> getScansByTipo( String tipo ) async {

    final db = await database;
    // Mandar los argumentos en orden en whereArgs
    final res = await db.query('Scans', where: 'tipo = ?', whereArgs: [tipo]);
    
    return res.isNotEmpty ? res.map((scan) => Scan.fromJson(scan)).toList() : [];

  }




  Future<List<Scan>> getScansByTipoRaw( String tipo ) async {

    final db = await database;
    // Mandar los argumentos en orden en whereArgs
    final res = await db.rawQuery('''
      SELECT * FROM Scans WHERE tipo = '$tipo'
    ''');
    
    return res.isNotEmpty ? res.map((scan) => Scan.fromJson(scan)).toList() : [];

  }


  Future<int> updateScan( Scan scan ) async {

    final db = await database;
    // Mandar los argumentos en orden en whereArgs
    final res = await db.update('Scans', scan.toJson(), where: 'id = ?', whereArgs: [ scan.id ] );
    
    // Cantidad de registros actualizados
    return res;

  }






  Future<int> deleteScanById( int id ) async {

    final db = await database;
    // Mandar los argumentos en orden en whereArgs
    final res = await db.delete('Scans', where: 'id = ?', whereArgs: [id] );
    
    // Cantidad de registros borrados
    return res;

  }


  Future<int> deleteAllScans() async {

    final db = await database;
    // Mandar los argumentos en orden en whereArgs
    final res = await db.delete('Scans');
    
    // Cantidad de registros borrados
    return res;

  }

  Future<int> deleteAllScansRaw() async {

    final db = await database;
    // Mandar los argumentos en orden en whereArgs
    final res = await db.rawDelete('''
      DELETE FROM Scans
    ''');
    
    // Cantidad de registros borrados
    return res;

  }



}

