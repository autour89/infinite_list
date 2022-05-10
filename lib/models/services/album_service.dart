import 'package:infinite_list/models/dao/photo.dart';
import 'package:infinite_list/models/dto/photo_dto.dart';
import 'package:infinite_list/models/services/configuration.dart';
import 'package:infinite_list/models/services/network/model_response.dart';
import 'package:infinite_list/models/services/photos_service.dart';
import 'package:infinite_list/models/services/repositories/db_context_repository.dart';
import 'package:http/http.dart' as http;

abstract class IAlbumService {
  List<Photo> get models;
  Future<void> update(Photo photo, int index);
  Future load();
}

class AlbumService implements IAlbumService {
  final IDataService _dbContextService;
  final PhotosService _client;
  int _nextPage = 0; // page that is going to be load next

  AlbumService(this._dbContextService) : _client = PhotosService.create() {
    _nextPage = models.isNotEmpty ? models.last.page + 1 : 0;
  }

  /// list of photos
  @override
  List<Photo> get models => _dbContextService.album;

  /// update local album storage
  @override
  Future<void> update(Photo photo, int index) async {
    _dbContextService.update(photo, index);
  }

  /// fetch remote data
  @override
  Future load() async {
    var response = await _client.getPhotos(_nextPage.toString());

    // final http.Response response = await fetchPhotos();
    if (response.body is Success) {
      var data = (response.body as Success).value;
      for (var json in data) {
        _dbContextService
            .add(Photo.fromDto(PhotoDto.fromJson(json), _nextPage));
      }
      _nextPage++;
    }
  }

  Future<http.Response> fetchPhotos() {
    // simple get request, may be it's better to use chooper
    return http
        .get(Uri.parse('${Configuration.photosEndPoint}?_page=$_nextPage'));
  }
}
