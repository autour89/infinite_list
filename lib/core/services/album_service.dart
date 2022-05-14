import 'package:http/http.dart' as http;
import 'package:infinite_list/core/data/repository.dart';
import 'package:infinite_list/core/data/models/photo_dao.dart' as dao;
import 'package:infinite_list/core/data/models/photo_dto.dart' as dto;
import 'package:infinite_list/core/configuration.dart';
import 'package:infinite_list/core/network/model_response.dart';
import 'package:infinite_list/core/network/photos_service.dart';

abstract class IAlbumService {
  Future<List<dao.Photo>> get models;
  Future<void> update(dao.Photo photo, int index);
  Future load();
}

class AlbumService implements IAlbumService {
  final Repository _dbContextService;
  final PhotosService _photosService;
  int _page = 0; // page that is going to be load next

  AlbumService(this._dbContextService, this._photosService) {
    initialise();
  }

  Future initialise() async {
    var album = await models;
    _page = album.isNotEmpty ? album.last.page + 1 : 0;
  }

  /// list of photos
  @override
  Future<List<dao.Photo>> get models => _dbContextService.album;

  /// update local album storage
  @override
  Future<void> update(dao.Photo photo, int index) async {
    _dbContextService.update(photo, index);
  }

  /// fetch remote data
  @override
  Future load() async {
    var response = await _photosService.getPhotos(_page);

    // final http.Response response = await fetchPhotos();
    if (response.body is Success) {
      var data = (response.body as Success).value;
      for (var json in data) {
        _dbContextService
            .add(dao.Photo.fromDto(dto.Photo.fromJson(json), _page));
      }
      _page++;
    }
  }

  Future<http.Response> fetchPhotos() {
    // simple get request, may be it's better to use chooper
    return http.get(Uri.parse('${Configuration.photosEndPoint}?_page=$_page'));
  }
}
