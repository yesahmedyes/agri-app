import 'package:flutter/material.dart';

class CustomAppBarBack extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onPressed;
  final String? text;
  const CustomAppBarBack({Key? key, this.onPressed, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      elevation: Navigator.of(context).canPop() ? 1 : 0,
      iconTheme: const IconThemeData(color: Colors.white),
      leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: (onPressed == null) ? () => Navigator.of(context).pop() : onPressed),
      titleSpacing: 2,
      title: Text(text ?? '', style: Theme.of(context).textTheme.headline2!.copyWith(height: 1.25, color: Colors.white)),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
