import 'package:hive_flutter/hive_flutter.dart';
import 'package:infinite_list/models/dto/photo_dto.dart';

part 'photo.g.dart';

@HiveType(typeId: 0)
class Photo extends HiveObject {
  @HiveField(0)
  final int albumId;
  @HiveField(1)
  final int id;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final String url;
  @HiveField(4)
  final String thumbnailUrl;
  @HiveField(5)
  bool like;
  @HiveField(6)
  int page;

  Photo(
      {required this.albumId,
      required this.id,
      required this.title,
      required this.url,
      required this.thumbnailUrl,
      this.like = false,
      this.page = 0});

  factory Photo.fromDto(PhotoDto photoDto, int page) {
    return Photo(
        albumId: photoDto.albumId,
        id: photoDto.id,
        title: photoDto.title,
        url: photoDto.url,
        thumbnailUrl: photoDto.thumbnailUrl,
        page: page);
  }
}
