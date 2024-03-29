// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Usermodel {
  final String name;
  final String  banner;
  final String profile;
  final String uid;
  final bool isAuthinticated;
  final int karma;
  final List<String>awards;
  Usermodel({
    required this.name,
    required this.banner,
    required this.profile,
    required this.uid,
    required this.isAuthinticated,
    required this.karma,
    required this.awards,
  });
  
  

  Usermodel copyWith({
    String? name,
    String? banner,
    String? profile,
    String? uid,
    bool? isAuthinticated,
    int? karma,
  }) {
    return Usermodel(
      name: name ?? this.name,
      banner: banner ?? this.banner,
      profile: profile ?? this.profile,
      uid: uid ?? this.uid,
      isAuthinticated: isAuthinticated ?? this.isAuthinticated,
      karma: karma ?? this.karma, awards: [],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'banner': banner,
      'profile': profile,
      'uid': uid,
      'isAuthinticated': isAuthinticated,
      'karma': karma,
    };
  }

  factory Usermodel.fromMap(Map<String, dynamic> map) {
    return Usermodel(
      name: map['name'] as String,
      banner: map['banner'] as String,
      profile: map['profile'] as String,
      uid: map['uid'] as String,
      isAuthinticated: map['isAuthinticated'] as bool,
      karma: map['karma'] as int, awards: [],
    );
  }

  String toJson() => json.encode(toMap());

  factory Usermodel.fromJson(String source) => Usermodel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Usermodel(name: $name, banner: $banner, profile: $profile, uid: $uid, isAuthinticated: $isAuthinticated, karma: $karma)';
  }

  @override
  bool operator ==(covariant Usermodel other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.banner == banner &&
      other.profile == profile &&
      other.uid == uid &&
      other.isAuthinticated == isAuthinticated &&
      other.karma == karma;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      banner.hashCode ^
      profile.hashCode ^
      uid.hashCode ^
      isAuthinticated.hashCode ^
      karma.hashCode;
  }
}
