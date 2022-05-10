import 'package:infinite_list/core/data/models/dao/photo.dart';

import 'models/models.dart';

abstract class Repository {
  Future<List<Photo>> findAllRecipes();
  Stream<List<Photo>> watchAllRecipes();
  Future add<T>(T entity);
  Future update<T>(T entity, int index);
  Future delete<T>(int index);

  Future init();
  void close();
}
