import 'package:infinite_list/core/data/hive/models/photo.dart';
import 'package:infinite_list/core/data/repository.dart';
import 'package:infinite_list/core/data/sqlite/database_helper.dart';

class SqliteRepository implements Repository {
  final dbHelper = DatabaseHelper.instance;

  @override
  Future<List<Photo>> findAllRecipes() {
    // TODO: implement findAllRecipes
    throw UnimplementedError();
  }

  @override
  Stream<List<Photo>> watchAllRecipes() {
    // TODO: implement watchAllRecipes
    throw UnimplementedError();
  }

  @override
  Future add<T>(T entity) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future delete<T>(int index) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future update<T>(T entity, int index) {
    // TODO: implement update
    throw UnimplementedError();
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
