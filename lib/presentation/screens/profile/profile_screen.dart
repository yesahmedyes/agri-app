import 'package:agriapp/data/repositories/profile_repository.dart';
import 'package:agriapp/presentation/screens/profile/bloc/profile_bloc.dart';
import 'package:agriapp/presentation/widgets/buttons/full_width_button.dart';
import 'package:agriapp/presentation/widgets/form/custom_text_form_field.dart';
import 'package:agriapp/presentation/widgets/navigation/customAppBarBack.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController fullNameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController phoneNumberController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      fullNameController.text = user.displayName ?? '';
      emailController.text = user.email ?? '';
      phoneNumberController.text = user.phoneNumber ?? '';
    }
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileBloc>(
      create: (context) => ProfileBloc(profileRepository: context.read<ProfileRepository>()),
      child: Scaffold(
        appBar: const CustomAppBarBack(text: 'Profile'),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 60),
          child: Column(
            children: [
              CustomTextFormField(controller: fullNameController, text: 'Full Name'),
              const SizedBox(height: 30),
              CustomTextFormField(controller: emailController, text: 'Email Address'),
              const SizedBox(height: 30),
              CustomTextFormField(
                controller: phoneNumberController,
                text: 'Phone Number',
                enabled: false,
              ),
              const SizedBox(height: 40),
              BlocConsumer<ProfileBloc, ProfileState>(
                listener: (context, state) {
                  if (state is ProfileSubmitSuccessState) {
                    FocusScope.of(context).unfocus();

                    Navigator.pop(context);
                  }
                },
                builder: (context, state) {
                  return FullWidthButton(
                    text: (state is ProfileSubmittingState) ? null : 'Submit',
                    onPressed: () {
                      context.read<ProfileBloc>().add(ProfileSubmitEvent(fullName: fullNameController.text, email: emailController.text));
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
