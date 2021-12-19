import 'package:flutter/material.dart';

class LoadingMore extends StatelessWidget {
  final double previewSize = 40;

  const LoadingMore({Key? key}) : super(key: key);

  @override
  build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: ListTile(
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.photo,
              size: previewSize,
              color: Theme.of(context).indicatorColor,
            ),
          ],
        ),
        title: Center(
          child: CircularProgressIndicator(color: Colors.redAccent[100]),
        ),
        trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.favorite_outline,
                size: previewSize,
                color: Theme.of(context).indicatorColor,
              ),
            ]),
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
          ]),
    );
  }
}
