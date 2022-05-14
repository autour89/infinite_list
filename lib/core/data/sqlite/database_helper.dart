import 'package:infinite_list/core/data/models/photo_dao.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlbrite/sqlbrite.dart';
import 'package:synchronized/synchronized.dart';

class DatabaseHelper {
  static const _databaseName = 'MyAlbum.db';
  static const _databaseVersion = 1;

  static late BriteDatabase _streamDatabase;

  // make this a singleton class
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static var lock = Lock();

  static const photoTable = 'Photo';

  // only have a single app-wide reference to the database
  static Database? _database;

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
        CREATE TABLE $photoTable (
          id INTEGER PRIMARY KEY,
          albumId INTEGER,
          title TEXT,
          url TEXT,
          thumbnailUrl TEXT,
          page INTEGER,
          like INTEGER
        )
        ''');
  }

  // this opens the database (and creates it if it doesn't exist)
  Future<Database> _initDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);
    Sqflite.setDebugModeOn(true);
    return openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    // Use this object to prevent concurrent access to data
    await lock.synchronized(
      () async {
        // lazily instantiate the db the first time it is accessed
        if (_database == null) {
          _database = await _initDatabase();
          _streamDatabase = BriteDatabase(_database!);
        }
      },
    );
    return _database!;
  }

  Future<BriteDatabase> get streamDatabase async {
    await database;
    return _streamDatabase;
  }

  Future<List<Photo>> findAllPhotos() async {
    final db = await instance.streamDatabase;
    final album = await db.query(photoTable);
    return _parseAlbum(album);
  }

  Stream<List<Photo>> watchAlbum() async* {
    final db = await instance.streamDatabase;
    yield* db.createQuery(photoTable).mapToList((row) => Photo.fromJson(row));
  }

  Future<int> insert(String table, Map<String, dynamic> row) async {
    final db = await instance.streamDatabase;
    return db.insert(table, row);
  }

  Future<int> update(
      String table, String columnId, int id, Map<String, dynamic> row) async {
    final db = await instance.streamDatabase;
    return db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> delete(String table, String columnId, int id) async {
    final db = await instance.streamDatabase;
    return db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

  void close() {
    _streamDatabase.close();
  }

  List<Photo> _parseAlbum(List<Map<String, dynamic>> album) {
    final photos = <Photo>[];
    album.forEach((photoMap) => photos.add(Photo.fromJson(photoMap)));
    return photos;
  }
}
