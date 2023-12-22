// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:tuncjob/models/user_match_model.dart';

class ChatScreen extends StatelessWidget {
  static const String routeName = '/chat';
  final UserMatch userMatch;
  const ChatScreen({
    Key? key,
    required this.userMatch,
  }) : super(key: key);

  static Route route({required UserMatch userMatch}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => ChatScreen(
        userMatch: userMatch,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        title: Column(
          children: [
            CircleAvatar(
              radius: 15,
              backgroundImage: NetworkImage(userMatch.matchedUser.imageUrls[0]),
            ),
            Text(
              userMatch.matchedUser.name,
              style: Theme.of(context).textTheme.headlineMedium,
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: userMatch.chat != null
                  ? SizedBox(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: userMatch.chat![0].messages.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: userMatch
                                        .chat![0].messages[index].senderId ==
                                    1
                                ? Align(
                                    alignment: Alignment.topRight,
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .background,
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      child: Text(
                                        userMatch
                                            .chat![0].messages[index].message,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge,
                                      ),
                                    ),
                                  )
                                : Align(
                                    alignment: Alignment.topLeft,
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 15,
                                          backgroundImage: NetworkImage(
                                            userMatch.matchedUser.imageUrls[0],
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          child: Text(
                                            userMatch.chat![0].messages[index]
                                                .message,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge!
                                                .copyWith(color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                          );
                        },
                      ),
                    )
                  : const SizedBox(),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            height: 100,
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.send_outlined,
                    ),
                  ),
                ),
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Type Here...",
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      contentPadding: EdgeInsets.only(left: 20, bottom: 5),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
