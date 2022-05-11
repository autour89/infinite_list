import 'dart:async';

import 'package:infinite_list/core/data/hive/models/photo.dart';
import 'package:infinite_list/core/data/repository.dart';

class MemoryRepository extends Repository {
  final StreamController _albumStreamController =
      StreamController<List<String>>();

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
  Future init() {
    return Future.value();
  }

  @override
  void close() {
    _albumStreamController.close();
  }
}
