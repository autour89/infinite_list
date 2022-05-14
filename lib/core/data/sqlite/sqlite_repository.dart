import 'package:infinite_list/core/data/models/photo_dao.dart';
import 'package:infinite_list/core/data/repository.dart';
import 'package:infinite_list/core/data/sqlite/database_helper.dart';

class SqliteRepository implements Repository {
  final dbHelper = DatabaseHelper.instance;

  @override
  Future<List<Photo>> get album => dbHelper.findAllPhotos();

  @override
  Stream<List<Photo>> watchAlbum() => dbHelper.watchAlbum();

  @override
  Future add<T>(T entity) async {
    if (entity is Photo) {
      await dbHelper.insert(DatabaseHelper.photoTable, entity.toJson());
    }
    return Future.value();
  }

  @override
  Future update<T>(T entity, int index) async {
    if (entity is Photo) {
      await dbHelper.update(
          DatabaseHelper.photoTable, 'id', index, entity.toJson());
    }
    return Future.value();
  }

  @override
  Future delete<T>(int index) async {
    if (T is Photo) {
      await dbHelper.delete(DatabaseHelper.photoTable, 'id', index);
    }

    return Future.value();
  }

  @override
  Future init() async {
    await dbHelper.database;
    return Future.value();
  }

  @override
  void close() {
    dbHelper.close();
  }
}
