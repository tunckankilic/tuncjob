import 'package:flutter/material.dart';
import 'package:tuncjob/screens/onboarding/onboarding_screens/social_screen.dart';
import 'package:tuncjob/widgets/widgets.dart';

import 'onboarding_screens/screens.dart';

class OnboardingScreen extends StatelessWidget {
  static const String routeName = '/onboarding';

  const OnboardingScreen({super.key});

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const OnboardingScreen(),
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
    Tab(
      text: "Passing to",
    )
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
              Container()
            ],
          ),
        );
      }),
    );
  }
}
