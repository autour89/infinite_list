import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:infinite_list/models/dao/photo.dart';
import 'package:infinite_list/models/services/configuration.dart';

abstract class IDataService {
  List<Photo> get album;
  Future add<T>(T entity);
  Future update<T>(T entity, int index);
  Future delete<T>(int index);
}

class DbContextRepository implements IDataService {
  late Box<Photo> _album;

  DbContextRepository() {
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
  List<Photo> get album => _album.values.toList().cast<Photo>();

  ///add entity to the box
  @override
  Future add<T>(T entity) async {
    if (entity is Photo) {
      _album.add(entity);
    }
  }

  /// update stored entity
  @override
  Future update<T>(T entity, int index) async {
    if (entity is Photo) {
      await _album.putAt(index, entity);
    }
  }

  /// delete the entity by index
  @override
  Future delete<T>(int index) async {
    if (T == Photo) {
      await _album.delete(index);
    }
  }
}
