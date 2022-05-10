import 'package:chopper/chopper.dart';
import 'package:infinite_list/core/configuration.dart';
import 'package:infinite_list/core/network/model_converter.dart';

part "photos_service.chopper.dart";

@ChopperApi(baseUrl: '/')
abstract class PhotosService extends ChopperService {
  @Get(path: 'photos')
  Future<Response> getAll();

  @Get(path: 'photos?_page={page}')
  Future<Response> getPhotos(@Path() int page);

  static PhotosService create() {
    final client = ChopperClient(
      baseUrl: Configuration.baseUrl,
      interceptors: [HttpLoggingInterceptor()],
      converter: ModelConverter(), //const FormUrlEncodedConverter(),
      errorConverter: const JsonConverter(),
      services: [
        _$PhotosService(),
      ],
    );
    return _$PhotosService(client);
  }
}
