import 'package:flutter/material.dart';

class FarmSearchField extends StatelessWidget {
  FarmSearchField({Key? key}) : super(key: key);

  final TextEditingController _controller = TextEditingController();

  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      focusNode: _focusNode,
      style: const TextStyle(fontSize: 16, height: 1.5),
      decoration: InputDecoration(
        hintText: 'Search Place',
        filled: true,
        contentPadding: const EdgeInsets.all(16),
        fillColor: Colors.white,
        suffixIcon: const Icon(Icons.search),
        enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.grey), borderRadius: BorderRadius.circular(10)),
        border: OutlineInputBorder(borderSide: const BorderSide(color: Colors.grey), borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
