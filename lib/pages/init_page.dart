import 'package:flutter/material.dart';
import 'package:fokus/pages/root_page.dart';
import 'package:fokus/services/init_service.dart';
import 'package:get/get.dart';

class InitPage extends StatefulWidget {
  const InitPage({super.key});

  @override
  State<InitPage> createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {
  /// Run all init tasks and then go to the root page
  void _initializeApp() async {
    // Run all necessary on-launch app initialization tasks
    await InitService.initApp();

    // Go to the root page
    Get.offAll(RootPage());
  }

  @override
  Widget build(BuildContext context) {
    // Run the initialization task in background
    Future.delayed(Duration.zero, _initializeApp);

    return const Center(child: CircularProgressIndicator());
  }
}
