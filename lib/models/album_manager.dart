import 'package:flutter/material.dart';
import 'package:infinite_list/models/dao/photo.dart';
import 'package:infinite_list/models/services/album_service.dart';

class AlbumProvider extends ChangeNotifier {
  final IAlbumService albumService;
  bool _isLoadMore = false;
  bool _isLoading = false;

  /// is there any data?
  bool get hasPhotos => albumService.models.isNotEmpty;

  /// first sync is in progress or no?
  bool get isLoading => _isLoading;

  /// is retreiving more photos?
  bool get isLoadMore => _isLoadMore;

  /// read local storage
  List<Photo> get photos => List.unmodifiable(albumService.models);

  AlbumProvider({required this.albumService});

  /// load first page remotely
  Future initialLoad() async {
    _isLoading = true;
    notifyListeners();

    try {
      await albumService.load();
    } finally {
      _isLoading = false;

      notifyListeners();
    }
  }

  /// load one more page of data
  Future loadMore() async {
    if (_isLoadMore) return;

    _isLoadMore = true;

    notifyListeners();

    try {
      // await Future.delayed(const Duration(milliseconds: 5000));
      await albumService.load();
    } finally {
      _isLoadMore = false;

      notifyListeners();
    }
  }

  /// like/unlike photo user choosed, and update storage
  Future likeIt(Photo photo, int index) async {
    photo.like = !photo.like;
    albumService.update(photo, index);

    notifyListeners();
  }
}
