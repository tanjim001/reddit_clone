import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:reddit/core/constants/firebase_constant.dart';
import 'package:reddit/core/failure.dart';
import 'package:reddit/core/provider/firebase_provider.dart';
import 'package:reddit/core/type_def.dart';
import 'package:reddit/model/community_models.dart';

//provider for communityrepo..
final communityrepoProvider = Provider((ref) {
  return CommunityRepo(firestore: ref.watch(firestoreProvider));
});

class CommunityRepo {
  final FirebaseFirestore _firestore;

  CommunityRepo({required FirebaseFirestore firestore})
      : _firestore = firestore;
//getter method for getting community collection from firestore.
  CollectionReference get _communities =>
      _firestore.collection(FirebaseConstants.communitiesCollection);

//function to create community

  Futurevoid createcommunity(CommunityModel community) async {
    try {
      var communityDoc = await _communities.doc(community.name).get();
      if (communityDoc.exists) {
        throw 'Community with same name already exists!';
      }
      return right(_communities.doc(community.name).set(community.toMap()));
    } on FirebaseException catch (e) {
      return left(Failure(e.message!));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<List<CommunityModel>> getUserCommunities(String uid) {
    return _communities
        .where('members', arrayContains: uid)
        .snapshots()
        .map((event) {
      List<CommunityModel> communities = [];
      for (var doc in event.docs) {
        communities
            .add(CommunityModel.fromMap(doc.data() as Map<String, dynamic>));
      }
      return communities;
    });
  }
}
