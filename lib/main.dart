import 'dart:io';

import 'package:bloc_cubit_phone_auth/cubits/auth_cubit/auth_cubit.dart';
import 'package:bloc_cubit_phone_auth/screens/home_screen.dart';
import 'package:bloc_cubit_phone_auth/screens/sign_in_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
          apiKey: 'AIzaSyCRM3eXJCUAoUOVWtuiGJYmvx6zFjLU-X0',
          appId: '1:117538156123:android:a0f58cedb100df0978d97e',
          messagingSenderId: '117538156123',
          projectId: 'cubit-phone-auth-5db6b',
        ))
      : await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (context) => AuthCubit(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: BlocBuilder<AuthCubit, AuthState>(buildWhen: (oldState, newState) {
          return oldState is AuthInitialState;
        }, builder: (context, state) {
          if (state is AuthLoggedInState) {
            return const HomeScreen();
          } else if (state is AuthLoggedOutState) {
            return SignInScreen();
          } else {
            return const Scaffold();
          }
        }),
      ),
    );
  }
}
