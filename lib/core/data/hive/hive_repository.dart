import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:infinite_list/core/configuration.dart';
import 'package:infinite_list/core/data/hive/models/photo.dart';
import 'package:infinite_list/core/data/models/photo_dao.dart' as dao;
import 'package:infinite_list/core/data/repository.dart';

class HiveRepository implements Repository {
  late Box<Photo> _album;

  HiveRepository() {
    configure();
  }

  Future configure() async {
    _album = Hive.box(Configuration.albumBox);
  }

  /// open db connection
  static Future initContext = Future(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Hive.initFlutter();
    Hive.registerAdapter(PhotoAdapter());
    await Hive.openBox<Photo>(Configuration.albumBox);
  });

  /// get all photos
  @override
  Future<List<dao.Photo>> get album {
    final photos = <dao.Photo>[];
    _album.values.forEach(
      (photo) => photos.add(dao.Photo.fromJson(photo.toJson())),
    );
    return Future<List<dao.Photo>>.value(photos);
  }

  ///add entity to the box
  @override
  Future add<T>(T entity) async {
    if (entity is dao.Photo) {
      _album.add(Photo.fromDao(entity));
    }
  }

  /// update stored entity
  @override
  Future update<T>(T entity, int index) async {
    if (entity is dao.Photo) {
      await _album.putAt(index, Photo.fromDao(entity));
    }
  }

  /// delete the entity by index
  @override
  Future delete<T>(int index) async {
    if (T == dao.Photo) {
      await _album.delete(index);
    }
  }

  @override
  void close() {
    // TODO: implement close
  }

  @override
  Future init() {
    // TODO: implement init
    throw UnimplementedError();
  }

  @override
  Stream<List<dao.Photo>> watchAlbum() {
    // TODO: implement watchAlbum
    throw UnimplementedError();
  }
}
