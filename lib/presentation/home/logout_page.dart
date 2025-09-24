import 'package:cbt_tpa_fic17_app/core/core.dart';
import 'package:cbt_tpa_fic17_app/presentation/auth/splash_page.dart';
import 'package:flutter/material.dart';

import '../../data/datasources/auth_local_datasource.dart';

class LogoutPage extends StatefulWidget {
  const LogoutPage({super.key});

  @override
  State<LogoutPage> createState() => _LogoutPageState();
}

class _LogoutPageState extends State<LogoutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Logout'),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              AuthLocalDataSource().removeAuthData();
              context.pushReplacement(const SplashPage());
            },
            child: Text('Logout')),
      ),
    );
  }
}
