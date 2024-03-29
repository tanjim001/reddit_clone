import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit/core/constants/constantsicon.dart';
import 'package:reddit/core/utils.dart';
import 'package:reddit/features/auth/controller/auth_controller.dart';
import 'package:reddit/features/community/repository/community_repo.dart';
import 'package:reddit/model/community_models.dart';
import 'package:routemaster/routemaster.dart';

//prove
final usercommunitiesProvider = StreamProvider((ref){
  final communitucontroller=ref.watch(communitycontrollerProvider.notifier);
  return communitucontroller.getusercommunity();
});

//community controller provider 
final communitycontrollerProvider =
    StateNotifierProvider<CommunityController, bool>((ref) {
  final communityrepo = ref.watch(communityrepoProvider);
  return CommunityController(communityRepo: communityrepo, ref: ref);
});

class CommunityController extends StateNotifier<bool> {
  final CommunityRepo _communityRepo;
  final Ref _ref;

  CommunityController({required CommunityRepo communityRepo, required Ref ref})
      : _communityRepo = communityRepo,
        _ref = ref,
        super(false);

  void createCommunity(String name, BuildContext context) async {
    state = true;
    final uid = _ref.read(userProvider)?.uid ?? "";
    CommunityModel community = CommunityModel(
        id: name,
        name: name,
        banner: Constanticon.bannerDefault,
        avatar: Constanticon.avatarDefault,
        members: [uid],
        mods: [uid]);

    final res = await _communityRepo.createcommunity(community);
    state = false;
    res.fold((l) => showSnackBar(context, l.message), (r) {
      showSnackBar(context, 'Community created successfully');
      Routemaster.of(context).pop();
    });
  }
//stream function used for geting user communities for total communities
  Stream<List<CommunityModel>> getusercommunity() {
    final uid = _ref.read(userProvider)!.uid;
    return _communityRepo.getUserCommunities(uid);
  }
}
