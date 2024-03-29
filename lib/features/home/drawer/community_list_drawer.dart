import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:reddit/core/common/error.dart';
import 'package:reddit/core/common/loader.dart';
import 'package:reddit/core/common/routes.dart';
import 'package:reddit/features/community/controller/community_controller.dart';
import 'package:routemaster/routemaster.dart';
import 'package:velocity_x/velocity_x.dart';

void tocreatecommunity(BuildContext context) {
  Routemaster.of(context).push(Routes.createcommunity);
}

class CommunityDrawer extends ConsumerWidget {
  const CommunityDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            ListTile(
              title: "Create a community".text.white.semiBold.size(18).make(),
              leading: const Icon(Icons.add),
              onTap: () => tocreatecommunity(context),
            ),
            ref.watch(usercommunitiesProvider).when(
                data: (data) => Expanded(
                  child: ListView.builder(
                    itemCount: data.length,
                          itemBuilder: (BuildContext context, int index) {
                        final community = data[index];
                        return  ListTile(
                          title: Text("r/${community.name}"),
                          leading: const CircleAvatar(),
                        );
                      }),
                ),
                error: (e, s) => ErrorText(error: e.toString()),
                loading: () => const Loader())
          ],
        ),
      ),
    );
  }
}
