import 'package:infinite_list/core/data/models/photo_dto.dart' as dto;

class Photo {
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;
  final int page;
  bool like;

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

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
        albumId: json['albumId'],
        id: json['id'],
        title: json['title'],
        url: json['url'],
        thumbnailUrl: json['thumbnailUrl'],
        page: json['page'],
        like: json['like']);
  }

  factory Photo.empty() =>
      Photo(albumId: 0, id: 0, title: '', url: '', thumbnailUrl: '');

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
