import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yes_no_app/domain/entities/message.dart';
import 'package:yes_no_app/presentation/providers/chat_provider.dart';
import 'package:yes_no_app/presentation/widgets/chat/her_message_bubble.dart';
import 'package:yes_no_app/presentation/widgets/chat/my_message_bubble.dart';
import 'package:yes_no_app/presentation/widgets/shared/message_field_box.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://s.yimg.com/ny/api/res/1.2/lfGbhiwRIyGHinVMmwVPHg--/YXBwaWQ9aGlnaGxhbmRlcjt3PTY0MDtoPTc4NQ--/https://media.zenfs.com/en_US/News/HollywoodLife.com/emma-stone-ftr-FFN_Spiderman_Premiere_KMFF_062812_9232550120629133316.jpg')),
          ),
          title: const Text('Mi amor ❤️'),
          centerTitle: true,
        ),
        body: _ChatView());
  }
}

class _ChatView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final chatProvider = context.watch<ChatProvider>();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
              controller: chatProvider.chatScrollController,
              itemCount: chatProvider.messageList.length,
              itemBuilder: (context, index) {
                final message = chatProvider.messageList[index];

                return (message.fromWho == FromWho.her)
                    ? HerMessageBubble(message: message)
                    : MyMessageBubble(message: message);
              },
            )),

            // Caja de mensaje
            const SizedBox(height: 5),

            MessageFieldBox(
              onValue: (value) => chatProvider.addMessage(value),
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
