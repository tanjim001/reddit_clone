import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:reddit/features/auth/controller/auth_controller.dart';
import 'package:reddit/features/home/drawer/community_list_drawer.dart';
import 'package:reddit/features/home/views/app_bar.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  void opendrawer(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    // if (kDebugMode) {
    //   print("home");
    //   print(user);
    // }
    return Scaffold(
      appBar:homeAppbar(user!.profile,context) ,
      drawer: const CommunityDrawer(),
    );
  }
}
