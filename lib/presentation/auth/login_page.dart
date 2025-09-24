import 'package:cbt_tpa_fic17_app/core/core.dart';
import 'package:cbt_tpa_fic17_app/data/datasources/auth_local_datasource.dart';
import 'package:cbt_tpa_fic17_app/presentation/auth/bloc/login/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/assets/assets.gen.dart';
import '../../core/components/custom_text_field.dart';
import '../../core/components/spaces.dart';
import '../../core/constants/colors.dart';
import '../home/main_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Stack(
        children: [
          SizedBox(
            height: 260.0,
            child: Center(
              child: Assets.images.logoWhite.image(height: 55.0),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SingleChildScrollView(
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20.0)),
                child: ColoredBox(
                  color: AppColors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 28.0, vertical: 44.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextField(
                          controller: emailController,
                          label: 'Email',
                          isOutlineBorder: false,
                        ),
                        const SpaceHeight(36.0),
                        CustomTextField(
                          controller: passwordController,
                          label: 'Password',
                          isOutlineBorder: false,
                          obscureText: true,
                        ),
                        SpaceHeight(MediaQuery.of(context).size.height * 0.1),
                        BlocListener<LoginBloc, LoginState>(
                          listener: (context, state) {
                            state.maybeWhen(
                              orElse: () {},
                              success: (data) async {
                                await AuthLocalDataSource().saveAuthData(data);
                                context.pushReplacement(const MainPage());
                              },
                              error: (error) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        textAlign: TextAlign.center,
                                        "Mohon periksa kembali email dan password anda!"),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              },
                            );
                          },
                          child: BlocBuilder<LoginBloc, LoginState>(
                            builder: (context, state) {
                              return state.maybeWhen(
                                orElse: () {
                                  return Button.filled(
                                    onPressed: () {
                                      context.read<LoginBloc>().add(
                                          LoginEvent.login(
                                              email: emailController.text,
                                              password:
                                                  passwordController.text));
                                    },
                                    label: 'Login',
                                  );
                                },
                                loading: () {
                                  return Button.filled(
                                    icon: Center(
                                        child: CircularProgressIndicator(
                                      color: Colors.white,
                                    )),
                                    onPressed: () {},
                                    disabled: true,
                                    label: '',
                                  );
                                },
                              );
                            },
                          ),
                        ),
                        SpaceHeight(MediaQuery.of(context).size.height * 0.03),
                        Center(
                          child: Assets.images.logoCwb.image(height: 40.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
