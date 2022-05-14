import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infinite_list/core/album_manager.dart';
import 'package:infinite_list/core/data/models/models.dart';
import 'package:infinite_list/ui/components/infinite_list.dart';
import 'package:provider/provider.dart';

import '../../core/data/models/photo_dao.dart';

class AlbumScreen extends StatefulWidget {
  const AlbumScreen({Key? key}) : super(key: key);

  @override
  State<AlbumScreen> createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {
  final String emptyScreenTitle = 'Your album is empty.';

  @override
  build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: SafeArea(child: buildBody()));
  }

  buildBody() {
    return Consumer<AlbumProvider>(
      builder: (context, manager, child) {
        return FutureBuilder(
            future: manager.photos,
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                var photos = snapshot.data as List<Photo>;
                var hasPhotos = photos.isNotEmpty;
                return Stack(
                  children: [
                    Visibility(
                      visible: hasPhotos,
                      child:
                          InfiniteListView(provider: manager, photos: photos),
                    ),
                    Visibility(
                        visible: !manager.isLoading && !hasPhotos,
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                emptyScreenTitle,
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .titleMedium,
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
                      visible: manager.isLoading && !hasPhotos,
                      child: Center(
                        child: CupertinoActivityIndicator(
                          color: Theme.of(context).indicatorColor,
                        ),
                      ),
                    )
                  ],
                );
              } else {
                return Container();
              }
            }));
      },
    );
  }
}
