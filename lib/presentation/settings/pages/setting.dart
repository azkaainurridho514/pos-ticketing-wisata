import 'package:cbt_tpa_fic17_app/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../core/assets/assets.gen.dart';
import '../widgets/setting_button.dart';
import 'setting_printer_page.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: GridView.count(
          crossAxisCount: 2,
          padding: const EdgeInsets.all(24.0),
          crossAxisSpacing: 15.0,
          mainAxisSpacing: 24.0,
          children: [
            SettingButton(
              iconPath: Assets.icons.settings.printer.path,
              title: 'Printer',
              subtitle: 'Kelola printer',
              onPressed: () {
                context.push(const SettingPrinterPage());
              },
            ),
            // SettingButton(
            //   iconPath: Assets.icons.settings.printer.path,
            //   title: 'Printer',
            //   subtitle: 'Kelola printer',
            //   onPressed: () {
            //     context.push(const LogoutTicketDialog());
            //   },
            // ),
            // SettingButton(
            //   iconPath: Assets.icons.settings.syncData.path,
            //   title: 'Sync data',
            //   subtitle: 'Sinkronasi online',
            //   onPressed: () {
            //     context.push(const SyncDataPage());
            //   },
            // ),
            // SettingButton(
            //   iconPath: Assets.icons.settings.syncData.path,
            //   title: 'Server key',
            //   subtitle: 'inout server key',
            //   onPressed: () {
            //     context.push(const SaveServerKeyPage());
            //   },
            // ),
          ]),
    );
  }
}
