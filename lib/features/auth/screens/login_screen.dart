import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:reddit/core/common/loader.dart';
import 'package:reddit/core/common/sign_in_button.dart';
import 'package:reddit/core/constants/constantsicon.dart';
import 'package:reddit/features/auth/controller/auth_controller.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final h=MediaQuery.of(context).size.height;
    final w=MediaQuery.of(context).size.width;
    final isloading=ref.watch(authcontrollerProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          Constanticon.logo,
          height: (0.05*h),
        ),
        actions: [
          TextButton(
              onPressed: () {}, child: "Skip".text.semiBold.blue400.make())
        ],
      ),
      body:isloading?const Loader(): Column(
        children: [
          (0.02*h).heightBox,
          "Dive into anything".text.white.xl4.semiBold.tight.make(),
          (0.05*h).heightBox,
          Padding(
            padding:  EdgeInsets.all(w*0.04),
            child: Image.asset(Constanticon.login),
          ),
          (0.07*h).heightBox,
           Padding(
            padding:  EdgeInsets.symmetric(horizontal: w*.07),
            child: LoginButton(hight: (h*.05), context: context,),
          )
        ],
      ),
    );
  }
}


