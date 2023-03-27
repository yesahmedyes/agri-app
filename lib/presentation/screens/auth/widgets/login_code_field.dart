import 'package:agriapp/logic/login/login_bloc.dart';
import 'package:agriapp/presentation/widgets/form/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/index.dart';

class LoginCodeField extends StatefulWidget {
  const LoginCodeField({Key? key, required TextEditingController codeController})
      : _codeController = codeController,
        super(key: key);

  final TextEditingController _codeController;

  @override
  State<LoginCodeField> createState() => _LoginCodeFieldState();
}

class _LoginCodeFieldState extends State<LoginCodeField> {
  int? endTime;

  String? codeValidation(String? text) {
    if (text == null || text.isEmpty) {
      return "Please enter the code";
    }
    if (text.length != 6) {
      return "Must be 6 digits in length";
    }
    if (int.tryParse(text) == null) {
      return "Must be not contain letters or symbols";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 60;
      },
      listenWhen: (previous, current) => (previous is! LoginOtpWaitingState && current is LoginOtpWaitingState),
      buildWhen: (previous, current) {
        if (previous is! LoginOtpWaitingState && current is LoginOtpWaitingState || previous is! LoginOtpVerifyingState && current is LoginOtpVerifyingState) {
          return true;
        }
        if (previous is LoginOtpWaitingState && current is! LoginOtpWaitingState || previous is LoginOtpVerifyingState && current is! LoginOtpVerifyingState) {
          return true;
        }
        return false;
      },
      builder: (context, state) {
        if (state is LoginOtpWaitingState || state is LoginOtpVerifyingState) {
          return Column(
            children: [
              const SizedBox(height: 30),
              CustomTextFormField(controller: widget._codeController, enabled: (state is LoginOtpWaitingState) ? true : false, text: 'Code', keyboardType: TextInputType.number, validator: codeValidation),
              const SizedBox(height: 30),
              if (endTime != null)
                CountdownTimer(
                  endTime: endTime,
                  widgetBuilder: (_, time) => (time == null)
                      ? InkWell(
                          onTap: () => context.read<LoginBloc>().add(LoginForceRedemandOtpEvent()),
                          child: Text('Resend token', style: Theme.of(context).textTheme.subtitle2),
                        )
                      : Text("Resend code in: 0:${time.sec}", style: Theme.of(context).textTheme.bodyText1),
                )
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
