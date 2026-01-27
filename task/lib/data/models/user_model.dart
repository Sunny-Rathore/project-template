import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    super.id,
    super.name,
    super.dob,
    super.gender,
    super.userName,
    super.email,
    super.isOnboarded,
    super.userRole,
    super.accessToken,
    super.latitude,
    super.longitude,

    super.isFollow,
    super.followerCount,
    super.followingCount,

    super.weight,
    super.profileImage,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['aocId']?.toString(),
      name: json['fullName'],
      dob: json['dob'],
      userName: json['userName'],
      gender: json['gender'],
      email: json['email'],
      userRole: json['userRole'],
      isOnboarded: json['isOnboarded'],
      accessToken: json['accessToken'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      isFollow: json['isFollow'],
      followingCount: json['followingCount'],
      followerCount: json['followerCount'],
      // state: json['state'] != null ? StateModel.fromJson(json['state']) : null,
      // city: json['city'] != null ? CityModel.fromJson(json['city']) : null,
      // height: json['height'] != null ? Height.fromJson(json['height']) : null,
      weight: json['weight'],
      profileImage: json['profileImage'],
    );
  }

  Map<String, dynamic> toJson() => {
    if (id != null) 'aocId': id,
    if (name != null) 'fullName': name,
    if (dob != null) 'dob': dob,
    if (userName != null) 'userName': userName,
    if (gender != null) 'gender': gender,
    if (email != null) 'email': email,
    if (userRole != null) 'userRole': userRole,
    if (isOnboarded != null) 'isOnboarded': isOnboarded,
    if (accessToken != null) 'accessToken': accessToken,
    if (latitude != null) 'latitude': latitude,
    if (longitude != null) 'longitude': longitude,
    if (isFollow != null) 'isFollow': isFollow,
    if (followingCount != null) 'followingCount': followingCount,
    if (followerCount != null) 'followerCount': followerCount,
    // if (state != null) 'state': (state as StateModel).toJson(),
    // if (city != null) 'city': (city as CityModel).toJson(),
    // if (height != null) 'user_metric': height?.toJson(),
    if (weight != null) 'weight': weight,
    if (profileImage != null) 'profileImage': profileImage,
  };
}
