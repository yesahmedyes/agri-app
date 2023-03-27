import 'package:agriapp/logic/login/login_bloc.dart';
import 'package:agriapp/presentation/widgets/buttons/full_width_button.dart';
import 'package:agriapp/presentation/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/login_code_field.dart';
import 'widgets/login_phone_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();

  final _phoneForm = GlobalKey<FormState>();
  final _codeForm = GlobalKey<FormState>();

  void _submitPhoneNumber(BuildContext context) {
    final isValid = _phoneForm.currentState!.validate();

    if (isValid) {
      final phoneNumber = _phoneController.text;
      context.read<LoginBloc>().add(LoginSendPhoneEvent(phoneNumber: phoneNumber));
    }
  }

  void _submitCode(BuildContext context) {
    final isValid = _codeForm.currentState!.validate();

    if (isValid) {
      final otp = _codeController.text;
      context.read<LoginBloc>().add(LoginSendOtpEvent(otp: otp));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: BlocListener<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state is LoginFailedState) {
                  customDialog(
                    context: context,
                    text: state.error,
                    actionText: 'Ok',
                    action: () {
                      _phoneController.clear();
                      _codeController.clear();
                      context.read<LoginBloc>().add(LoginSetToInitialEvent());

                      Navigator.of(context).pop();
                    },
                  );
                }
              },
              listenWhen: (previous, current) => previous is! LoginFailedState && current is LoginFailedState,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Let's Get Started", style: Theme.of(context).textTheme.headline1),
                        const SizedBox(height: 8),
                        Text('App use karny kayliyay pehly apna phone number verify karain', style: Theme.of(context).textTheme.bodyText1),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  Form(key: _phoneForm, child: LoginPhoneField(phoneController: _phoneController)),
                  Form(key: _codeForm, child: LoginCodeField(codeController: _codeController)),
                  const SizedBox(height: 30),
                  BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      return FullWidthButton(
                        onPressed: (state is LoginOtpWaitingState) ? () => _submitCode(context) : () => _submitPhoneNumber(context),
                        text: (state is LoginOtpVerifyingState || state is LoginPhoneSentState) ? null : ((state is LoginOtpWaitingState) ? 'Submit code' : 'Get code'),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
