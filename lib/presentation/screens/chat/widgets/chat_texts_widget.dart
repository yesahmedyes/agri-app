import 'package:agriapp/data/models/chat.dart';
import 'package:agriapp/theme.dart';
import 'package:flutter/material.dart';

class ChatTextsWidget extends StatefulWidget {
  final List<Chat> chats;

  const ChatTextsWidget({Key? key, required this.chats}) : super(key: key);

  @override
  State<ChatTextsWidget> createState() => _ChatTextsWidgetState();
}

class _ChatTextsWidgetState extends State<ChatTextsWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  void didUpdateWidget(covariant ChatTextsWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          for (var i = 0; i < widget.chats.length; i++)
            Padding(
              padding: (i < widget.chats.length - 1) ? const EdgeInsets.only(bottom: 10) : EdgeInsets.zero,
              child: Align(
                alignment: (widget.chats[i].role == "user") ? Alignment.centerRight : Alignment.centerLeft,
                child: IntrinsicWidth(
                  child: Container(
                    decoration: BoxDecoration(color: (widget.chats[i].role == "user") ? darkGreenColor : Colors.black87, borderRadius: BorderRadius.circular(5)),
                    alignment: (widget.chats[i].role == "user") ? Alignment.topRight : Alignment.topLeft,
                    margin: (widget.chats[i].role == "user") ? const EdgeInsets.only(left: 12) : const EdgeInsets.only(right: 12),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(widget.chats[i].content, style: const TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
