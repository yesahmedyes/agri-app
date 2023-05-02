import 'package:agriapp/logic/chat/chat_bloc.dart';
import 'package:agriapp/presentation/widgets/custom_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/chat_texts_widget.dart';

class ChatHome extends StatelessWidget {
  ChatHome({super.key});

  final TextEditingController _controller = TextEditingController();

  _sendNextChat(BuildContext context) {
    if (_controller.text.isNotEmpty) {
      context.read<ChatBloc>().add(ChatNextEvent(question: _controller.text));

      _controller.clear();

      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: BlocBuilder<ChatBloc, ChatState>(
          buildWhen: (previous, current) {
            return previous.props != current.props;
          },
          builder: (context, state) {
            return Column(
              mainAxisAlignment: (state is ChatInitialState) ? MainAxisAlignment.spaceBetween : MainAxisAlignment.end,
              children: [
                if (state is ChatInitialState)
                  Column(
                    children: [
                      const SizedBox(height: 40),
                      Text('Kissan GPT', style: Theme.of(context).textTheme.headline1),
                      const SizedBox(height: 8),
                      Text('Farming related sawalat poochain', style: Theme.of(context).textTheme.bodyText1),
                    ],
                  ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (state is ChatLoadedState)
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: ChatTextsWidget(chats: state.chats),
                          ),
                        ),
                      if (state is ChatLoadingState)
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: ChatTextsWidget(chats: state.chats),
                          ),
                        ),
                      if (state is ChatLoadingState)
                        Container(
                          width: 25,
                          height: 25,
                          margin: const EdgeInsets.only(top: 8, bottom: 25),
                          child: const CustomProgressIndicator(strokeWidth: 3),
                        ),
                      TextFormField(
                        controller: _controller,
                        textInputAction: TextInputAction.go,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.grey), borderRadius: BorderRadius.circular(10)),
                          border: OutlineInputBorder(borderSide: const BorderSide(color: Colors.grey), borderRadius: BorderRadius.circular(10)),
                          contentPadding: const EdgeInsets.all(18),
                          hintText: 'Enter a question',
                          fillColor: Colors.white,
                          filled: true,
                          suffixIcon: InkWell(
                            onTap: () => _sendNextChat(context),
                            child: const Icon(Icons.send, size: 20),
                          ),
                        ),
                        minLines: 1,
                        maxLines: 5,
                        onFieldSubmitted: (_) => _sendNextChat(context),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
