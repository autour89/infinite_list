// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photos_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$PhotosService extends PhotosService {
  _$PhotosService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = PhotosService;

  @override
  Future<Response<dynamic>> getAll() {
    final $url = '/photos';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getPhotos(int page) {
    final $url = '/photos?_page=${page}';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }
}
