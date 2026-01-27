import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? id;
  final String? name;
  final String? email;
  final String? profileImage;
  final bool? isOnboarded;
  final String? userRole;
  final String? userName;
  final String? accessToken;
  final String? dob;
  final String? gender;
  final String? latitude;
  final String? longitude;
  final bool? isFollow;
  final num? followingCount;
  final num? followerCount;
  final num? weight;

  const User({
    this.id,
    this.name,
    this.email,
    this.isOnboarded,
    this.userRole,
    this.userName,
    this.accessToken,
    this.dob,
    this.gender,
    this.latitude,
    this.longitude,
    this.isFollow,
    this.followerCount,
    this.followingCount,
    this.weight,
    this.profileImage,
  });

  User copyWith({bool? isFollow, num? followerCount, num? followingCount, String? accessToken}) {
    return User(
      id: id,
      name: name,
      email: email,
      isOnboarded: isOnboarded,
      userRole: userRole,
      userName: userName,
      accessToken: accessToken ?? this.accessToken,
      dob: dob,
      gender: gender,
      isFollow: isFollow ?? this.isFollow,
      followingCount: followingCount ?? this.followingCount,
      followerCount: followerCount ?? this.followerCount,
      weight: weight,
      profileImage: profileImage,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    email,
    isOnboarded,
    userRole,
    userName,
    accessToken,
    dob,
    gender,
    latitude,
    longitude,
    isFollow,
    followerCount,
    followingCount,
    weight,
    profileImage,
  ];
}
