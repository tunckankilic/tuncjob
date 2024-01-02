import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuncjob/blocs/onboarding/onboarding_bloc.dart';
import 'package:tuncjob/cubits/sign_up/signup_cubit.dart';
import 'package:tuncjob/repositories/auth/auth_repository.dart';
import 'package:tuncjob/repositories/database/database_storage.dart';
import 'package:tuncjob/repositories/storage/storage_repository.dart';
import 'package:tuncjob/screens/onboarding/onboarding_screens/social_screen.dart';
import 'package:tuncjob/widgets/widgets.dart';

import 'onboarding_screens/screens.dart';

class OnboardingScreen extends StatelessWidget {
  static const String routeName = '/onboarding';

  const OnboardingScreen({super.key});

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => MultiBlocProvider(providers: [
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
      ], child: const OnboardingScreen()),
    );
  }

  static const List<Tab> tabs = <Tab>[
    Tab(text: 'Start'),
    Tab(text: 'Email'),
    Tab(text: 'Email Verification'),
    Tab(text: 'Demographics'),
    Tab(text: 'Pictures'),
    Tab(text: 'Biography'),
    Tab(text: "Social"),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Builder(builder: (BuildContext context) {
        final TabController tabController = DefaultTabController.of(context);
        tabController.addListener(() {
          if (!tabController.indexIsChanging) {}
        });
        return Scaffold(
          appBar: const CustomAppBar(
            title: 'TuncJob',
            hasActions: false,
          ),
          body: TabBarView(
            children: [
              Start(tabController: tabController),
              Email(tabController: tabController),
              EmailVerification(tabController: tabController),
              Demo(tabController: tabController),
              Pictures(tabController: tabController),
              Bio(tabController: tabController),
              Social(tabController: tabController),
            ],
          ),
        );
      }),
    );
  }
}
