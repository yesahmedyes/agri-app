import 'package:agriapp/logic/login/login_bloc.dart';
import 'package:agriapp/presentation/widgets/form/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPhoneField extends StatelessWidget {
  const LoginPhoneField({Key? key, required TextEditingController phoneController})
      : _phoneController = phoneController,
        super(key: key);

  final TextEditingController _phoneController;

  String? phoneValidation(String? text) {
    if (text == null || text.isEmpty) {
      return "Please enter a phone number";
    }
    if (text.length != 10 && text.length != 11) {
      return "Must be correct format: +92 XXXXXXXXXX";
    }
    if (int.tryParse(text) == null) {
      return "Must be not contain letters or symbols";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) {
        return ((previous is! LoginInitialState && current is LoginInitialState) || (previous is LoginInitialState && current is! LoginInitialState));
      },
      builder: (context, state) {
        return CustomTextFormField(controller: _phoneController, text: 'Phone Number', prefix: '+92', enabled: (state is LoginInitialState) ? true : false, keyboardType: TextInputType.phone, validator: phoneValidation);
      },
    );
  }
}
