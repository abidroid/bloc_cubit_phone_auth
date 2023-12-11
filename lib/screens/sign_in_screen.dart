import 'package:bloc_cubit_phone_auth/cubits/auth_cubit/auth_cubit.dart';
import 'package:bloc_cubit_phone_auth/screens/verify_phone_number.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInScreen extends StatelessWidget {
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login with Phone'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              controller: phoneController,
              maxLength: 10,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Phone Number",
                counterText: "",
              ),
            ),
            const SizedBox(height: 10),
            BlocConsumer<AuthCubit, AuthState>(builder: (context, state) {
              if (state is AuthLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return ElevatedButton(
                  onPressed: () {
                    String phoneNumber = '+92${phoneController.text}';
                    BlocProvider.of<AuthCubit>(context).sendOTP(phoneNumber);
                  },
                  child: const Text('Sign In'));
            }, listener: (context, state) {
              if (state is AuthCodeSentState) {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                  return const VerifyPhoneNumber();
                }));
              }
            })
          ],
        ),
      ),
    );
  }
}
