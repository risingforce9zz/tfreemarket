class UserModel {

  String id ='';
  String name = '';
  String displayName = '';
  String email = '';
  String phoneNumber = '';
  String profilePic = '';
  String storeDescription = '';

  UserModel({
    required this.id,
    required this.name,
    required this.displayName,
    required this.email,
    required this.phoneNumber,
    required this.profilePic,
    required this.storeDescription,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'displayName': displayName,
      'email': email,
      'phoneNumber': phoneNumber,
      'profilePic': profilePic,
      'storeDescription': storeDescription,
    };
  }

  UserModel.fromMap(Map<dynamic, dynamic>? map) {
    if (map == null) {
      return;
    }
    id = map["id"];
    name = map['name'];
    displayName = map['displayName'];
    email = map['email'];
    phoneNumber = map['phoneNumber'];
    profilePic = map['profilePic'];
    storeDescription = map['storeDescription'];
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? displayName,
    String? email,
    String? phoneNumber,
    String? profilePic,
    String? storeDescription,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profilePic: profilePic ?? this.profilePic,
      storeDescription: storeDescription ?? this.storeDescription,
    );
  }
}