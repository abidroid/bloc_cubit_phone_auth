import 'package:bloc_cubit_phone_auth/cubits/auth_cubit/auth_cubit.dart';
import 'package:bloc_cubit_phone_auth/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyPhoneNumber extends StatefulWidget {
  const VerifyPhoneNumber({super.key});

  @override
  State<VerifyPhoneNumber> createState() => _VerifyPhoneNumberState();
}

class _VerifyPhoneNumberState extends State<VerifyPhoneNumber> {
  late TextEditingController otpController;

  @override
  void initState() {
    super.initState();
    otpController = TextEditingController();
  }

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Phone Number'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: otpController,
              maxLength: 6,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "6 Digit OTP",
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
                    String otp = otpController.text;
                    BlocProvider.of<AuthCubit>(context).verifyOTP(otp);
                  },
                  child: const Text('Verify'));
            }, listener: (context, state) {
              if (state is AuthLoggedInState) {
                Navigator.popUntil(context, (route) => route.isFirst);
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
                  return const HomeScreen();
                }));
              } else if (state is AuthErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    state.error.toString(),
                  ),
                  duration: const Duration(seconds: 1),
                  backgroundColor: Colors.red,
                ));
              }
            })
          ],
        ),
      ),
    );
  }
}
