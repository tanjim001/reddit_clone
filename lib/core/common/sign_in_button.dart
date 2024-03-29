import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:reddit/core/constants/constantsicon.dart';
import 'package:reddit/features/auth/controller/auth_controller.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginButton extends ConsumerWidget {
  final BuildContext _context;
   const LoginButton({super.key,required this.hight,required BuildContext context}):_context=context;
  final double hight;
  
  void signinwithgoogle(WidgetRef ref){
    ref.read(authcontrollerProvider.notifier).signInWithGoogle(_context);
  }
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
        height: hight ,
        width: double.infinity,
        child: ElevatedButton.icon(
            onPressed: ()=>signinwithgoogle(ref),
            icon: Image.asset(Constanticon.google),
            label: "Continue with google".text.white.semiBold.lg.make()));
  }
}