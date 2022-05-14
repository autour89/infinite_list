import 'package:flutter/material.dart';
import 'package:infinite_list/core/data/models/photo_dao.dart';
import 'package:infinite_list/core/services/album_service.dart';

class AlbumProvider extends ChangeNotifier {
  final IAlbumService albumService;
  bool _isLoading = false;

  /// is there any data?
  Future<bool> get hasPhotos async => (await albumService.models).isNotEmpty;

  /// first sync is in progress or no?
  bool get isLoading => _isLoading;

  /// read local storage
  Future<List<Photo>> get photos => albumService.models;

  AlbumProvider({required this.albumService});

  /// load first page remotely
  Future initialLoad() async {
    if (_isLoading) return;

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
    if (_isLoading) return;

    _isLoading = true;

    try {
      // await Future.delayed(const Duration(milliseconds: 5000));
      await albumService.load();
    } finally {
      _isLoading = false;

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
