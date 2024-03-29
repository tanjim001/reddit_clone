//logged out route
import 'package:flutter/material.dart';
import 'package:reddit/features/auth/screens/login_screen.dart';
import 'package:reddit/features/community/views/community_screen.dart';
import 'package:reddit/features/home/views/home_screen.dart';
import 'package:routemaster/routemaster.dart';


class Routes{
 static const loginscreen='/';
 static const logoutscreen='/';
 static const createcommunity='/createcommunity';
}

final loggedout = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: LoginScreen()),
});

final loggedin = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: HomeScreen()),
  '/createcommunity': (_) => const MaterialPage(child: CreateCommunity())
});

