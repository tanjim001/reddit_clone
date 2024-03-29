import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit/core/common/loader.dart';
import 'package:reddit/features/community/controller/community_controller.dart';
import 'package:velocity_x/velocity_x.dart';

class CreateCommunity extends ConsumerStatefulWidget {
  const CreateCommunity({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateCommunityState();
}

class _CreateCommunityState extends ConsumerState<CreateCommunity> {
  //handle user input for community name
  TextEditingController communitytext = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    communitytext.dispose();
  }
//here created function for create community
  void createCommunity() {
    ref
        .read(communitycontrollerProvider.notifier)
        .createCommunity(communitytext.text.trim(), context);
  }

  @override
  Widget build(BuildContext context) {
    final isloading=ref.watch(communitycontrollerProvider);
    return Scaffold(
      appBar: AppBar(
        title: "Create a Community".text.xl2.make(),
        centerTitle: true,
      ),
      body: isloading?const Loader():createcommunitybody(),
    );
  }
// extracted body widget
  Padding createcommunitybody() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          "Create community".text.lg.make(),
          10.heightBox,
          TextField(
            controller: communitytext,
            maxLength: 21,
            decoration: InputDecoration(
                fillColor: Colors.grey[900],
                hintText: 'r/Community_name',
                border: InputBorder.none,
                filled: true,
                contentPadding: const EdgeInsets.all(18)),
          ),
          30.heightBox,
          ElevatedButton(
            onPressed: createCommunity,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              backgroundColor: Colors.blue[500],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
            ),
            child: "Create Community".text.white.lg.semiBold.make(),
          )
        ],
      ),
    );
  }
}
