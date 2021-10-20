import 'package:chat_example/auth/auth_store.dart';
import 'package:chat_example/auth/auth_ui.dart';
import 'package:chat_example/chat_rooms/chat_room_users_ui.dart';
import 'package:chat_example/chat_rooms/chat_rooms_ui.dart';
import 'package:chat_example/messages/messages_store.dart';
import 'package:chat_example/messages/messages_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({Key? key}) : super(key: key);

  @override
  _ChatsPageState createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grafos Chat'),
        actions: [
          HookConsumer(builder: (context, ref, _) {
            return const AuthForm(smallForm: true);
          })
        ],
      ),
      body: Row(
        children: [
          Container(
            width: 250,
            padding: const EdgeInsets.only(
              left: 12,
              right: 12,
              bottom: 12,
            ),
            child: Column(
              children: [
                TextField(
                  controller: searchController,
                ),
                const Expanded(
                  child: ChatRoomList(),
                ),
                Container(
                  child: Row(
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          showDialog<Object?>(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                child: Container(
                                  width: 150,
                                  height: 120,
                                  padding: const EdgeInsets.all(10),
                                  child: const CreateRoomForm(),
                                ),
                              );
                            },
                          );
                        },
                        icon: const Icon(Icons.add),
                        label: const Text('Create'),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: HookConsumer(
              builder: (context, ref, _) {
                final showInfo = useState(false);
                final chat = ref.watch(selectedChat).asData?.value;
                final state = ref.watch(authStoreProv);

                if (chat == null) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Select a chat'),
                        ),
                        if (state.isAnonymous)
                          const SizedBox(
                            width: 300,
                            child: AuthForm(smallForm: false),
                          ),
                      ],
                    ),
                  );
                }

                return ClipRect(
                  child: Column(
                    children: [
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: Theme.of(context).canvasColor,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 2,
                              spreadRadius: 1,
                            )
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                chat.name,
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ),
                            Row(
                              children: [
                                TextButton(
                                  onPressed: () {},
                                  child: const Icon(Icons.search),
                                ),
                                SizedBox(
                                  width: 130,
                                  child: showInfo.value
                                      ? TextButton.icon(
                                          onPressed: () {
                                            showInfo.value = false;
                                          },
                                          icon: const Icon(Icons.message),
                                          label: const Text('Messages'),
                                        )
                                      : TextButton.icon(
                                          onPressed: () {
                                            showInfo.value = true;
                                          },
                                          icon: const Icon(Icons.info),
                                          label: const Text('Info'),
                                        ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 200),
                            child: showInfo.value
                                ? ChatRoomUsers(room: chat)
                                : const MessageList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
