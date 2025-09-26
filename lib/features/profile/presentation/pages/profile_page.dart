import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/profile_bloc.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_textfield.dart';

class ProfilePage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileLoaded) {
            nameController.text = state.profile.name;
            emailController.text = state.profile.email;
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  CustomTextField(
                    controller: nameController,
                    hint: "Name",
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: emailController,
                    hint: "Email",
                  ),
                  const SizedBox(height: 24),
                  CustomButton(
                    text: "Update",
                    onPressed: () {
                      final updatedProfile = state.profile.copyWith(
                        name: nameController.text,
                        email: emailController.text,
                      );
                      context
                          .read<ProfileBloc>()
                          .add(UpdateProfileEvent(updatedProfile));
                    },
                  )
                ],
              ),
            );
          } else if (state is ProfileError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox();
        },
      ),
    );
  }
}
