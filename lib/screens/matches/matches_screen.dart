import 'package:flutter/material.dart';
import 'package:tuncjob/models/user_match_model.dart';
import 'package:tuncjob/screens/chat/chat_screen.dart';

import '../../widgets/widgets.dart';

class MatchesScreen extends StatelessWidget {
  static const String routeName = '/matches';

  const MatchesScreen({super.key});

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const MatchesScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final inactiveMatches = UserMatch.matches
        .where((match) => match.userId == 1 && match.chat!.isEmpty)
        .toList();
    final activeMatches = UserMatch.matches
        .where((match) => match.userId == 1 && match.chat!.isNotEmpty)
        .toList();
    return Scaffold(
        appBar: const CustomAppBar(title: 'MATCHES'),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Your Likes",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Column(
                          children: [
                            UserImage.small(
                              height: 70,
                              width: 70,
                              url: inactiveMatches[index]
                                  .matchedUser
                                  .imageUrls[0],
                            ),
                            Text(
                              inactiveMatches[index].matchedUser.name,
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount: inactiveMatches.length,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Your Chats",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: GestureDetector(
                        onTap: () => Navigator.of(context).pushNamed(
                            ChatScreen.routeName,
                            arguments: activeMatches[index]),
                        child: Row(
                          children: [
                            UserImage.small(
                              height: 70,
                              width: 70,
                              url: inactiveMatches[index]
                                  .matchedUser
                                  .imageUrls[0],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    activeMatches[index].matchedUser.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                  ),
                                  Text(
                                    activeMatches[index]
                                        .chat![0]
                                        .messages[0]
                                        .message,
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  Text(
                                    activeMatches[index]
                                        .chat![0]
                                        .messages[0]
                                        .timeString,
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: activeMatches.length,
                  shrinkWrap: true,
                ),
              ],
            ),
          ),
        ));
  }
}
