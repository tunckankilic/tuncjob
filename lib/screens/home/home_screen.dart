import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuncjob/blocs/swipe/swipe_bloc.dart';
import 'package:tuncjob/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/';

  const HomeScreen({super.key});

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const HomeScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Home'),
      body: BlocBuilder<SwipeBloc, SwipeState>(
        builder: (context, state) {
          if (state is SwipeLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SwipeLoaded) {
            return Column(
              children: [
                Draggable(
                  feedback: UserCard(
                    user: state.users[0],
                  ),
                  childWhenDragging: UserCard(
                    user: state.users[0],
                  ),
                  child: UserCard(
                    user: state.users[0],
                  ),
                  onDragEnd: (details) {
                    if (details.velocity.pixelsPerSecond.dx < 0) {
                      context.read<SwipeBloc>().add(
                            SwipeLeft(
                              user: state.users[0],
                            ),
                          );
                      log("Swiped Left");
                    } else {
                      context.read<SwipeBloc>().add(
                            SwipeRight(
                              user: state.users[0],
                            ),
                          );
                      log("Swipred Right");
                    }
                  },
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 60),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          context.read<SwipeBloc>().add(
                                SwipeLeft(
                                  user: state.users[0],
                                ),
                              );
                        },
                        child: ChoiceButton(
                          width: 60,
                          height: 60,
                          size: 25,
                          color: Theme.of(context).colorScheme.secondary,
                          icon: Icons.clear_rounded,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          context.read<SwipeBloc>().add(
                                SwipeRight(
                                  user: state.users[0],
                                ),
                              );
                        },
                        child: const ChoiceButton(
                          width: 80,
                          height: 80,
                          size: 30,
                          hasGradient: true,
                          color: Colors.white,
                          icon: Icons.favorite,
                        ),
                      ),
                      ChoiceButton(
                        width: 60,
                        height: 60,
                        size: 25,
                        color: Theme.of(context).colorScheme.secondary,
                        icon: Icons.watch_later,
                      ),
                    ],
                  ),
                )
              ],
            );
          } else {
            return const Center(
              child: Text("Something Went Wrong"),
            );
          }
        },
      ),
    );
  }
}
