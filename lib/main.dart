import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuncjob/blocs/auth/auth_bloc.dart';
import 'package:tuncjob/blocs/onboarding/onboarding_bloc.dart';
import 'package:tuncjob/blocs/profile/profile_bloc.dart';
import 'package:tuncjob/blocs/swipe/swipe_bloc.dart';
import 'package:tuncjob/config/app_router.dart';
import 'package:tuncjob/config/theme.dart';
import 'package:tuncjob/cubits/sign_up/signup_cubit.dart';
import 'package:tuncjob/models/models.dart';
import 'package:tuncjob/repositories/auth/auth_repository.dart';
import 'package:tuncjob/repositories/database/database_storage.dart';
import 'package:tuncjob/repositories/storage/storage_repository.dart';
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
        ),
        RepositoryProvider(
          create: (context) => StorageRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => SignupCubit(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => OnboardingBloc(
              databaseStorage: context.read<DatabaseStorage>(),
              storageRepository: context.read<StorageRepository>(),
            )..add(
                StartOnboarding(),
              ),
          ),
          BlocProvider(
            create: (context) => ProfileBloc(
              authBloc: context.read<AuthBloc>(),
              databaseStorage: context.read<DatabaseStorage>(),
            )..add(
                LoadProfile(userId: context.read<AuthBloc>().state.user!.uid),
              ),
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
          initialRoute: OnboardingScreen.routeName,
          onGenerateRoute: AppRouter.onGenerateRoute,
        ),
      ),
    );
  }
}
