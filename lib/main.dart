import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuncjob/blocs/auth/auth_bloc.dart';
import 'package:tuncjob/blocs/images/images_bloc.dart';
import 'package:tuncjob/blocs/swipe/swipe_bloc.dart';
import 'package:tuncjob/config/app_router.dart';
import 'package:tuncjob/config/theme.dart';
import 'package:tuncjob/models/models.dart';
import 'package:tuncjob/repositories/auth/auth_repository.dart';
import 'package:tuncjob/repositories/database/database_storage.dart';
import 'package:tuncjob/screens/screens.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepository(),
        ),
        RepositoryProvider(
          create: (context) => DatabaseStorage(),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => ImagesBloc(
              databaseStorage: context.read<DatabaseStorage>(),
            )..add(LoadImages()),
          ),
          BlocProvider(
            create: (context) => SwipeBloc()
              ..add(
                LoadUsers(users: User.users),
              ),
          ),
        ],
        child: MaterialApp(
          title: 'TuncJob',
          theme: theme(),
          initialRoute: HomeScreen.routeName,
          onGenerateRoute: AppRouter.onGenerateRoute,
        ),
      ),
    );
  }
}
