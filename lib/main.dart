import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuncjob/blocs/swipe/swipe_bloc.dart';
import 'package:tuncjob/config/app_router.dart';
import 'package:tuncjob/config/theme.dart';
import 'package:tuncjob/models/models.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SwipeBloc()
            ..add(
              LoadUsersEvent(users: User.users),
            ),
        ),
      ],
      child: MaterialApp(
        title: 'TuncJob',
        theme: theme(),
        initialRoute: HomeScreen.routeName,
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}
