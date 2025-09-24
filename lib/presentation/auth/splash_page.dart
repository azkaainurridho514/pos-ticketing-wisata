import 'package:cbt_tpa_fic17_app/data/datasources/auth_local_datasource.dart';
import 'package:flutter/material.dart';

import '../../core/core.dart';
import '../home/main_page.dart';
import 'login_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Future.delayed(
            const Duration(seconds: 2), () => AuthLocalDataSource().isLogin()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == true) {
              return const MainPage();
            } else {
              return const LoginPage();
            }
          }
          return Stack(
            children: [
              Column(
                children: [
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(96.0),
                    child: Assets.images.logoBlue.image(),
                  ),
                  const Spacer(),
                  const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primary,
                    ),
                  ),
                  const SpaceHeight(40),
                  SizedBox(
                    height: 100.0,
                    child: Align(
                      alignment: Alignment.center,
                      child: Assets.images.logoCwb.image(width: 150.0),
                    ),
                  )
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
