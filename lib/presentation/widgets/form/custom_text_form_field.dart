import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  final bool enabled;
  final double? padding;
  final String? Function(String?)? validator;
  final String? prefix;
  final TextInputType keyboardType;
  final Widget? suffixIcon;

  const CustomTextFormField({
    Key? key,
    required this.controller,
    required this.text,
    this.padding,
    this.validator,
    this.enabled = true,
    this.keyboardType = TextInputType.name,
    this.prefix,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: (padding != null) ? EdgeInsets.symmetric(vertical: padding!) : EdgeInsets.zero,
      child: TextFormField(
        controller: controller,
        enabled: enabled,
        keyboardType: keyboardType,
        validator: validator,
        decoration: InputDecoration(
          prefix: (prefix != null) ? Padding(padding: const EdgeInsets.only(right: 4), child: Text(prefix!, style: Theme.of(context).textTheme.bodyText2)) : null,
          enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.grey), borderRadius: BorderRadius.circular(10)),
          border: OutlineInputBorder(borderSide: const BorderSide(color: Colors.grey), borderRadius: BorderRadius.circular(10)),
          contentPadding: const EdgeInsets.all(18),
          labelText: text,
          fillColor: Colors.white,
          filled: true,
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
