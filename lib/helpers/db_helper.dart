import 'dart:io';

import 'package:guide_app/helpers/utils.dart';
import 'package:guide_app/models/place_model.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {


  static Future<sql.Database> get dataBase async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      path.join(dbPath, DBUtils.places_db_name),
      onCreate: (db, version) async {
        // Run the CREATE TABLE statement on the database.
        await db.execute("CREATE TABLE ${DBUtils.places_table_name}(${DBUtils.placeId} TEXT PRIMARY KEY, ${DBUtils.placeTitle} TEXT, ${DBUtils.placeImage} TEXT)");
        //await db.execute("CREATE TABLE ${DBUtils.places_table_name}(${DBUtils.placeId} TEXT PRIMARY KEY, ${DBUtils.placeTitle} TEXT, ${DBUtils.placeAddress} TEXT, ${DBUtils.placeImage} TEXT, ${DBUtils.placeLatitude} DOUBLE, ${DBUtils.placeLongitude} DOUBLE)");

        return db;
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 2,
    );
  }

  static Future<void> insertPlace(PlaceModel placeModel) async {
    // Get a reference to the database.
    final sql.Database db = await DBHelper.dataBase;

    // Insert the Task into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same PlaceModel is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      DBUtils.places_table_name,
      placeModel.toMap,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,//when a conflict happened what should do
    );
  }
  
  
  static Future<List<PlaceModel>> fetchPlaces() async {
    // Get a reference to the database.
    final sql.Database db = await dataBase;
    
   List<Map<String,Object>> maps = await db.query('${DBUtils.places_table_name}');

    // Convert the List<Map<String, dynamic> into a List<PlaceModel>.
    return List.generate(maps.length, (i) {
      return PlaceModel(
          id: maps[i][DBUtils.placeId],
          title: maps[i][DBUtils.placeTitle],
          image: File(maps[i][DBUtils.placeImage]),
          location: null);
    });
  }
}
