import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infinite_list/models/models.dart';
import 'package:infinite_list/views/components/loading_more.dart';
import 'package:infinite_list/views/components/photo_cart.dart';
import 'package:provider/provider.dart';

class AlbumScreen extends StatefulWidget {
  const AlbumScreen({Key? key}) : super(key: key);

  @override
  State<AlbumScreen> createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {
  final ScrollController _scrollController = ScrollController();
  final String emptyScreenTitle = 'Your album is empty.';

  @override
  initState() {
    super.initState();
    _scrollController.addListener(onScrolled);
  }

  @override
  build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: SafeArea(child: buildBody()));
  }

  buildBody() {
    return Consumer<AlbumProvider>(
      builder: (context, manager, child) {
        if (manager.hasPhotos) {
          return buildList(manager);
        } else {
          return Stack(
            children: [
              Visibility(
                  visible: !manager.isLoading,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          emptyScreenTitle,
                          style: Theme.of(context).primaryTextTheme.titleMedium,
                        ),
                        IconButton(
                            iconSize: 40,
                            onPressed: manager.initialLoad,
                            icon: Icon(
                              Icons.autorenew,
                              color: Theme.of(context).indicatorColor,
                            )),
                      ],
                    ),
                  )),
              Visibility(
                visible: manager.isLoading,
                child: Center(
                  child: CupertinoActivityIndicator(
                    color: Theme.of(context).indicatorColor,
                  ),
                ),
              )
            ],
          );
        }
      },
    );
  }

  buildList(AlbumProvider provider) {
    double itemExtent = 120;
    return Expanded(
        child: ListView.builder(
      padding:
          EdgeInsets.only(bottom: itemExtent), //for loading more extra item
      controller: _scrollController,
      itemExtent: itemExtent,
      itemCount: provider.isLoadMore
          ? provider.photos.length + 1
          : provider.photos.length,
      itemBuilder: (context, index) => buildCart(index, provider),
      // To make listView scrollable
      // even if there is only a single item.
      physics: const AlwaysScrollableScrollPhysics(),
    ));
  }

  buildCart(index, AlbumProvider provider) {
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
      context.read<AlbumProvider>().loadMore();
    }
  }
}
