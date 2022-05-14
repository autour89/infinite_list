import 'package:hive_flutter/hive_flutter.dart';
import 'package:infinite_list/core/data/models/photo_dto.dart' as dto;
import 'package:infinite_list/core/data/models/photo_dao.dart' as dao;

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

  factory Photo.fromDto(dto.Photo photoDto, int page) {
    return Photo(
        albumId: photoDto.albumId,
        id: photoDto.id,
        title: photoDto.title,
        url: photoDto.url,
        thumbnailUrl: photoDto.thumbnailUrl,
        page: page);
  }

  factory Photo.fromDao(dao.Photo photoDao) {
    return Photo(
        albumId: photoDao.albumId,
        id: photoDao.id,
        title: photoDao.title,
        url: photoDao.url,
        thumbnailUrl: photoDao.thumbnailUrl,
        page: photoDao.page,
        like: photoDao.like);
  }

  Map<String, dynamic> toJson() => {
        'albumId': albumId,
        'id': id,
        'title': title,
        'url': url,
        'thumbnailUrl': thumbnailUrl,
        'page': page,
        'like': like
      };
}
