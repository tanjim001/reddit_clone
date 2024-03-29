import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit/core/common/error.dart';
import 'package:reddit/core/common/loader.dart';
import 'package:reddit/core/common/routes.dart';
import 'package:reddit/features/auth/controller/auth_controller.dart';
import 'package:reddit/core/global/global.dart';
import 'package:reddit/model/user_model.dart';
import 'package:reddit/themes/pallete.dart';
import 'package:routemaster/routemaster.dart';

void main() async {
  await Global.init();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  Usermodel? usermodel;

  void getData(WidgetRef ref, User data) async {
    usermodel = await ref
        .watch(authcontrollerProvider.notifier)
        .getUserData(data.uid)
        .first;
    ref.read(userProvider.notifier).update((state) => usermodel);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(authstatechangeprovider).when(
        data: (data) => MaterialApp.router(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              theme: Pallete.darkModeAppTheme,
              routerDelegate: RoutemasterDelegate(routesBuilder: (context) {
                if (data != null) {
                  getData(ref, data);
                  if (usermodel != null) {
                    return loggedin;
                  }
                }
                return loggedout;
              }),
              routeInformationParser: const RoutemasterParser(),
            ),
        error: (e, stacktrace) => ErrorText(
              error: e.toString(),
            ),
        loading: () => const Loader());
  }
}
