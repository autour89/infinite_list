import 'package:flutter/material.dart';
import 'package:infinite_list/models/album_manager.dart';
import 'package:infinite_list/views/components/loading_more.dart';
import 'package:infinite_list/views/components/photo_cart.dart';

class InfiniteListView extends StatelessWidget {
  final AlbumProvider provider;
  final ScrollController _scrollController = ScrollController();

  InfiniteListView({Key? key, required this.provider}) : super(key: key) {
    _scrollController.addListener(onScrolled);
  }

  @override
  build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
      controller: _scrollController,
      itemCount: provider.photos.length + 1,
      itemBuilder: (context, index) => buildCart(index),
      // To make listView scrollable even if there is only a single item.
      physics: const AlwaysScrollableScrollPhysics(),
    ));
  }

  buildCart(index) {
    return index >= provider.photos.length
        ? const LoadingMore()
        : PhotoCart(
            photo: provider.photos[index],
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
