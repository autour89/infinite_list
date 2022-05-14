import 'package:infinite_list/core/data/models/photo_dao.dart';

abstract class Repository {
  Future<List<Photo>> get album;
  Stream<List<Photo>> watchAlbum();
  Future add<T>(T entity);
  Future update<T>(T entity, int index);
  Future delete<T>(int index);

  Future init();
  void close();
}
