import 'package:flutter/material.dart';
import 'package:infinite_list/models/models.dart';
import 'package:infinite_list/views/app_theme.dart';
import 'package:infinite_list/views/screens/album_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  await DbContextRepository.initContext;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider.value(value: AlbumService(DbContextRepository())),
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
