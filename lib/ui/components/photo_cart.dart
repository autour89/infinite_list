import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infinite_list/core/album_manager.dart';
import 'package:infinite_list/core/data/models/models.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:infinite_list/ui/screens/details_screen.dart';
import 'package:provider/provider.dart';
import 'package:infinite_list/core/data/models/photo_dao.dart';

class PhotoCart extends StatelessWidget {
  final double previewSize = 100;
  final Photo photo;
  final int id;

  const PhotoCart({
    Key? key,
    required this.photo,
    required this.id,
  }) : super(key: key);

  @override
  build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Ink(
          child: ListTile(
            contentPadding: const EdgeInsets.all(10),
            leading: buildImagePreview(context),
            trailing: IconButton(
              icon: photo.like
                  ? Icon(
                      Icons.favorite,
                      color: Theme.of(context).indicatorColor,
                    )
                  : Icon(
                      Icons.favorite_outline,
                      color: Theme.of(context).indicatorColor,
                    ),
              onPressed: () {
                context.read<AlbumProvider>().likeIt(photo, id);
              },
            ),
            title: Text(
              photo.title,
              style: Theme.of(context).primaryTextTheme.titleSmall,
            ),
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Theme.of(context).cardColor,
              boxShadow: const [
                BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 1,
                    blurRadius: 7,
                    offset: Offset(0, 3))
              ])),
    );
  }

  /// declearing preview widget, with posibility to open it in full size
  buildImagePreview(BuildContext context) {
    return SizedBox(
      width: previewSize,
      height: previewSize,
      child: Hero(
        tag: '$id',
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                        opaque: false,
                        pageBuilder: (_, __, ___) {
                          return GestureDetector(
                            onTap: () => Navigator.pop(context),
                            onVerticalDragStart: (_) => Navigator.pop(context),
                            child: DetailsScreen(
                              imageUrl: photo.url,
                              id: id,
                            ),
                          );
                        }));
              },
              child: CachedNetworkImage(
                imageUrl: photo.thumbnailUrl,
                placeholder: (context, url) => CupertinoActivityIndicator(
                  color: Theme.of(context).indicatorColor,
                ),
                errorWidget: (context, url, error) => Icon(
                  Icons.error,
                  color: Theme.of(context).indicatorColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
