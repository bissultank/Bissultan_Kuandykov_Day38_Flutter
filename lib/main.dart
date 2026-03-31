import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/datasource/local_data_source.dart';
import 'data/datasource/remote_data_source.dart';
import 'data/repository/notes_repository_impl.dart';
import 'domain/notes_repository.dart';
import 'presentation/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final localDS = LocalDataSource();
  await localDS.init();

  final repository = NotesRepositoryImpl(
    local: localDS,
    remote: RemoteDataSource(),
  );

  runApp(
    Provider<NotesRepository>.value(
      value: repository,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Планнер',
      theme: ThemeData.dark(useMaterial3: true),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
