import 'package:flutter/material.dart';
import 'package:infinite_list/core/album_manager.dart';
import 'package:infinite_list/ui/components/loading_more.dart';
import 'package:infinite_list/ui/components/photo_cart.dart';

import '../../core/data/models/photo_dao.dart';

class InfiniteListView extends StatelessWidget {
  final AlbumProvider provider;
  final ScrollController _scrollController = ScrollController();
  final List<Photo> photos;

  InfiniteListView({Key? key, required this.provider, required this.photos})
      : super(key: key) {
    _scrollController.addListener(onScrolled);
  }

  @override
  build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
      controller: _scrollController,
      itemCount: photos.length + 1,
      itemBuilder: (context, index) => buildCart(index),
      // To make listView scrollable even if there is only a single item.
      physics: const AlwaysScrollableScrollPhysics(),
    ));
  }

  buildCart(index) {
    return index >= photos.length
        ? const LoadingMore()
        : PhotoCart(
            photo: photos[index],
            id: index,
          );
  }

  onScrolled() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      provider.loadMore();
    }
  }
}
