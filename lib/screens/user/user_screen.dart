import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuncjob/blocs/swipe/swipe_bloc.dart';
import 'package:tuncjob/models/models.dart';
import 'package:tuncjob/widgets/widgets.dart';

class UsersScreen extends StatelessWidget {
  static const String routeName = '/users';

  static Route route({required User user}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => UsersScreen(user: user),
    );
  }

  final User user;

  const UsersScreen({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 1.9,
            child: Stack(
              children: [
                Hero(
                  tag: 'user_card',
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 45.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 2,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(user.imageUrls[0]),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 60,
                    ),
                    child: BlocBuilder<SwipeBloc, SwipeState>(
                      builder: (context, state) {
                        if (state is SwipeLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (state is SwipeLoaded) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () {
                                  context
                                      .read<SwipeBloc>()
                                      .add(SwipeRight(user: state.users[0]));
                                  Navigator.pop(context);
                                  log('Swiped Right');
                                },
                                child: ChoiceButton(
                                  color: Theme.of(context).colorScheme.primary,
                                  icon: Icons.clear_rounded,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  context
                                      .read<SwipeBloc>()
                                      .add(SwipeLeft(user: state.users[0]));
                                  Navigator.pop(context);
                                  log('Swiped Left');
                                },
                                child: const ChoiceButton(
                                  width: 80,
                                  height: 80,
                                  size: 30,
                                  color: Colors.white,
                                  hasGradient: true,
                                  icon: Icons.favorite,
                                ),
                              ),
                              ChoiceButton(
                                color: Theme.of(context).primaryColor,
                                icon: Icons.watch_later,
                              ),
                            ],
                          );
                        } else {
                          return const Text('Something went wrong.');
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${user.name}, ${user.age}',
                    style: Theme.of(context).textTheme.displayMedium),
                Text(
                  user.jobTitle,
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(fontWeight: FontWeight.normal),
                ),
                const SizedBox(height: 15),
                Text('About', style: Theme.of(context).textTheme.displaySmall),
                Text(user.bio,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(height: 2)),
                const SizedBox(height: 15),
                Text('Interests',
                    style: Theme.of(context).textTheme.displaySmall),
                Row(
                  children: user.interests
                      .map((interest) => Container(
                            padding: const EdgeInsets.all(8.0),
                            margin: const EdgeInsets.only(top: 5.0, right: 5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              gradient: LinearGradient(
                                colors: [
                                  Theme.of(context).primaryColor,
                                  Theme.of(context).colorScheme.primary,
                                ],
                              ),
                            ),
                            child: Text(
                              interest,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(color: Colors.white),
                            ),
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
