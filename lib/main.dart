// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:veritas/bloc/messages_bloc.dart';
import 'package:veritas/model/message_model.dart';
import 'repository/hive_repository.dart';
import 'repository/supabase_repository.dart';
import 'screens/home_screen.dart';
import 'secrets/api_keys.dart';
import 'themes/colors.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Optimal pathe for the local database
  final directory = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(directory.path);
  //Custom hive adapter
  Hive.registerAdapter(MessageModelAdapter());
  //Supabase initialization
  await Supabase.initialize(
    url: projectURL,
    anonKey: apiKey,
  );
  //Supabase client instance
  final supabase = Supabase.instance.client;

  runApp(MultiBlocProvider(providers: [
    RepositoryProvider(
        create: (context) => HiveRepository()
          ..openFacultytBox()
          ..openStudentBox()),
    BlocProvider(
      create: (context) =>
          MessagesBloc(HiveRepository(), SupabaseRepository(client: supabase)),
    )
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
              color: background, surfaceTintColor: Colors.transparent),
          scaffoldBackgroundColor: background),
      home: const HomeScreen(),
    );
  }
}
