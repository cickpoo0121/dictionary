import 'dart:io';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqliteHelper {
  String dbFile = 'lexitron.sqlite';
  Database _db;

  // copy DB file to app
  void openDB() async {
    // find db app's folder
    String dbPath = await getDatabasesPath();
    String fullPaht = join(dbPath, dbFile);
    print(fullPaht);

    // DB existed?
    bool existed = await databaseExists(fullPaht);

    if (!existed) {
      // no DB
      //copy DB
      // check whether the db folder exists
      try {
        Directory(dirname(fullPaht)).create(recursive: true);
      } catch (_) {
        print('Cannot find folder');
      }

      // copy from asset folder
      print('Copping db...');
      ByteData data = await rootBundle.load(join('assets/db', dbFile));
      // convert data to int
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(fullPaht).writeAsBytes(bytes, flush: true);
      print('DB copied');
    } else {
      print('DB existed');
    }

    // open DB
    _db = await openDatabase(fullPaht, readOnly: true, singleInstance: true);
  }

  void closeDB() async {
    await _db.close();
    print('DB closed');
  }

  searchDB(word) async {
    // List list =
    //     await _db.rawQuery('SELECT * FROM eng2th WHERE esearch = ?2  AND ecat = ?1 ',['N','abandon']);

    //  await print(word);
    var searchlist = await _db.query('eng2th',
        columns: ['tentry,ecat,esearch'],
        where: '"esearch" = ? ',
        whereArgs: ['$word']);

    if (searchlist.length > 0) {
      // print(searchlist);
      // print(list[0]['tentry']);
    } else {
      print('Not found');
    }

    return searchlist;
  }

  randomDB() async {
    var ranlist = await _db.query(
      'eng2th',
      columns: ['tentry,ecat,esearch'],
      orderBy: 'Random()',
      limit: 1,
      // where: ' "ecat" = ?',
      // whereArgs: ['N'],
    );

    if (ranlist.length > 0) {
      // print(list);
      // print(list[0]['tentry']);
    } else {
      print('Not found');
    }

    return ranlist;
  }
}
