import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';




class DatabaseHelper {

  static final _databaseName = "MyDatabase.db";
  static final _databaseVersion = 1;

  static final table = 'my_table';

  static final Header_tale = 'header_table';
  static final Contact_table = 'contact_table';



  static final s_id='S_Id';
  static final header="Headers";
  static final contactno="Contact_No";
  static final contactname="Contact_Name";


  static final product_id='Id';
  static final product_name='Name';
  static final product_price='Price';
  static final product_shortdescription='ShortDescription';


  static final s_h_id="S_H_Id";
  static final customheader="Custom_Header";
  static final phone_no="Phone_No";
  static final personname="Person_Name";
  static final colors_random="Random_Color";



  static final columnId = '_id';
  static final columnName = 'name';
  static final columnAge = 'age';

  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $Contact_table(
    $s_id INTEGER PRIMARY KEY,
    $product_id product_id,
    $product_name product_Name,
    $product_price product_price,
    $product_shortdescription product_shortdescription
    )
     ''');

    await db.execute('''
    CREATE TABLE $Header_tale(
    $s_h_id INTEGER PRIMARY KEY,
    $customheader Header,
    $personname Contact_Name,
    $phone_no Contact_Number,
    $colors_random Random_color
    )
     ''');
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.

  Future<int> insert(Map<String,dynamic> rows) async{
    Database? db=await instance.database;
    return await db!.insert(Contact_table, rows);
  }

  Future<int> insert_custom_header(Map<String,dynamic> rows) async{
    Database? db=await instance.database;
    return await db!.insert(Header_tale, rows);
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.


  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database? db = await instance.database;
    return await db!.query(Contact_table);
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int?> queryRowCount(String headers) async {
    Database? db = await instance.database;
    return Sqflite.firstIntValue(await db!.rawQuery('SELECT COUNT(*) FROM $table WHERE $header=$headers'));

  }

  Future<List<Map>> queryRowCount1(String headers) async {
    Database? db = await instance.database;
    List<Map> result = await db!.rawQuery("SELECT * FROM $Contact_table WHERE $header=?",[headers]);
    // List<contactsdetails> main=[];

    return result;
  }

  Future<List<Map>> queryRowCount2() async {
    Database? db = await instance.database;
    List<Map> result = await db!.rawQuery("SELECT * FROM $Header_tale ");
    // List<contactsdetails> main=[];
    return result;
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> update(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    int id = row[columnId];
    return await db!.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.



}