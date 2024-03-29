// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

AppBar homeAppbar(String img, BuildContext context) {
  return AppBar(
    title: "Home".text.white.semiBold.white.size(20).make(),
    centerTitle: false,
    leading: Builder(builder: (context) {
      return IconButton(
          onPressed: () => draw(context), icon: const Icon(Icons.menu));
    }),
    actions: [
      IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundImage: NetworkImage(img),
          radius: 18,
        ),
      ),
    ],
  );
}

void draw(BuildContext context) {
  Scaffold.of(context).openDrawer();
}
