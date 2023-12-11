import 'package:bloc_cubit_phone_auth/cubits/auth_cubit/auth_cubit.dart';
import 'package:bloc_cubit_phone_auth/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: BlocConsumer<AuthCubit, AuthState>(builder: (context, state) {
        return ElevatedButton(
          onPressed: () {
            BlocProvider.of<AuthCubit>(context).logOut();
          },
          child: const Text('Log Out'),
        );
      }, listener: (context, state) {
        if (state is AuthLoggedOutState) {
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
            return SignInScreen();
          }));
        }
      }),
    );
  }
}
