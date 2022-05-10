import 'package:flutter/material.dart';
import 'package:infinite_list/core/album_manager.dart';
import 'package:infinite_list/core/data/hive/hive_repository.dart';
import 'package:infinite_list/core/data/models/models.dart';
import 'package:infinite_list/core/network/photos_service.dart';
import 'package:infinite_list/core/services/album_service.dart';
import 'package:infinite_list/ui/app_theme.dart';
import 'package:infinite_list/ui/screens/album_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  await HiveRepository.initContext;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider.value(
            value: AlbumService(HiveRepository(), PhotosService.create())),
        ChangeNotifierProxyProvider<AlbumService, AlbumProvider>(
          create: (context) => AlbumProvider(
              albumService: Provider.of<AlbumService>(context, listen: false)),
          update: (context, service, provider) =>
              AlbumProvider(albumService: service),
        )
      ],
      child: MaterialApp(
        theme: AppTheme.light(),
        darkTheme: AppTheme.dark(),
        home: const AlbumScreen(),
      ),
    );
  }
}
