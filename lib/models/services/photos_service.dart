import 'package:chopper/chopper.dart';
import 'package:infinite_list/models/services/configuration.dart';

part "photos_service.chopper.dart";

@ChopperApi(baseUrl: '/')
abstract class PhotosService extends ChopperService {
  @Get(path: 'photos?_page={page}')
  Future<Response> getPhotos(@Path() String page);

  static PhotosService create() {
    final client = ChopperClient(
      baseUrl: Configuration.baseUrl,
      interceptors: [HttpLoggingInterceptor()],
      converter: const FormUrlEncodedConverter(), //ModelConverter(),
      errorConverter: const JsonConverter(),
      services: [
        _$PhotosService(),
      ],
    );
    return _$PhotosService(client);
  }
}
