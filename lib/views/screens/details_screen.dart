import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final String imageUrl;
  final int id;

  const DetailsScreen({Key? key, required this.imageUrl, required this.id})
      : super(key: key);

  @override
  build(BuildContext context) {
    return Hero(
      tag: '$id',
      child: Center(
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          placeholder: (context, url) => CupertinoActivityIndicator(
            color: Theme.of(context).indicatorColor,
          ),
          errorWidget: (context, url, error) => Icon(
            Icons.error,
            color: Theme.of(context).indicatorColor,
          ),
        ),
      ),
    );
  }
}
