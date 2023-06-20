import 'package:flutter/material.dart';
import 'package:yes_no_app/config/helpers/get_yes_no_answer.dart';
import 'package:yes_no_app/domain/entities/message.dart';

class ChatProvider extends ChangeNotifier {
  final ScrollController chatScrollController = ScrollController();
  final getYesNoAnswer = GetYesNoAnswer();

  List<Message> messageList = [
    Message(
      text: 'Hello',
      fromWho: FromWho.me,
    ),
    Message(
      text: 'Hi',
      fromWho: FromWho.her,
    ),
  ];

  Future<void> addMessage(String text) async {
    if (text.isEmpty) return;

    final newMessage = Message(
      text: text,
      fromWho: FromWho.me,
    );
    messageList.add(newMessage);

    if (text.endsWith('?')) {
      await herReply();
    }

    notifyListeners();
    scrollToBottom();
  }

  Future<void> herReply() async {
    final answer = await getYesNoAnswer.getAnswer();

    messageList.add(answer);
    scrollToBottom();
    notifyListeners();
  }

  void scrollToBottom() {
    chatScrollController.animateTo(
      chatScrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}
