import 'package:cloud_firestore/cloud_firestore.dart';

enum RelationshipType {
  temporary,
  casual,
  serious,
  marriage,
  friendship,
  companionship,
}

enum Gender {
  male,
  female,
  other,
  preferNotToSay,
}

class UserModel {
  final String id;
  final String email;
  final String username;
  final String? displayName;
  final String? bio;
  final List<String> photos;
  final int age;
  final Gender gender;
  final Gender interestedIn;
  final double? latitude;
  final double? longitude;
  final String? city;
  final String? country;
  
  // Relationship expectations
  final RelationshipType relationshipType;
  final String? relationshipDescription;
  final List<String> interests;
  final List<String> hobbies;
  
  // Dating preferences
  final int minAge;
  final int maxAge;
  final double maxDistance; // in kilometers
  
  // App settings
  final bool isOnline;
  final DateTime lastSeen;
  final bool showOnlineStatus;
  final bool allowLocationSharing;
  
  // Relationship status
  final bool isInRelationship;
  final String? currentPartnerId;
  final DateTime? relationshipStartDate;
  final RelationshipType? currentRelationshipType;
  
  // AI Assistant preferences
  final Map<String, dynamic> aiPreferences;
  final List<String> conversationHistory;
  
  final DateTime createdAt;
  final DateTime updatedAt;

  UserModel({
    required this.id,
    required this.email,
    required this.username,
    this.displayName,
    this.bio,
    this.photos = const [],
    required this.age,
    required this.gender,
    required this.interestedIn,
    this.latitude,
    this.longitude,
    this.city,
    this.country,
    required this.relationshipType,
    this.relationshipDescription,
    this.interests = const [],
    this.hobbies = const [],
    required this.minAge,
    required this.maxAge,
    required this.maxDistance,
    this.isOnline = false,
    required this.lastSeen,
    this.showOnlineStatus = true,
    this.allowLocationSharing = true,
    this.isInRelationship = false,
    this.currentPartnerId,
    this.relationshipStartDate,
    this.currentRelationshipType,
    this.aiPreferences = const {},
    this.conversationHistory = const [],
    required this.createdAt,
    required this.updatedAt,
  });

  // Convert to Firestore document
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'displayName': displayName,
      'bio': bio,
      'photos': photos,
      'age': age,
      'gender': gender.name,
      'interestedIn': interestedIn.name,
      'latitude': latitude,
      'longitude': longitude,
      'city': city,
      'country': country,
      'relationshipType': relationshipType.name,
      'relationshipDescription': relationshipDescription,
      'interests': interests,
      'hobbies': hobbies,
      'minAge': minAge,
      'maxAge': maxAge,
      'maxDistance': maxDistance,
      'isOnline': isOnline,
      'lastSeen': lastSeen.millisecondsSinceEpoch,
      'showOnlineStatus': showOnlineStatus,
      'allowLocationSharing': allowLocationSharing,
      'isInRelationship': isInRelationship,
      'currentPartnerId': currentPartnerId,
      'relationshipStartDate': relationshipStartDate?.millisecondsSinceEpoch,
      'currentRelationshipType': currentRelationshipType?.name,
      'aiPreferences': aiPreferences,
      'conversationHistory': conversationHistory,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  // Create from Firestore document
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      username: json['username'] ?? '',
      displayName: json['displayName'],
      bio: json['bio'],
      photos: List<String>.from(json['photos'] ?? []),
      age: json['age'] ?? 18,
      gender: Gender.values.firstWhere(
        (e) => e.name == json['gender'],
        orElse: () => Gender.preferNotToSay,
      ),
      interestedIn: Gender.values.firstWhere(
        (e) => e.name == json['interestedIn'],
        orElse: () => Gender.preferNotToSay,
      ),
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
      city: json['city'],
      country: json['country'],
      relationshipType: RelationshipType.values.firstWhere(
        (e) => e.name == json['relationshipType'],
        orElse: () => RelationshipType.casual,
      ),
      relationshipDescription: json['relationshipDescription'],
      interests: List<String>.from(json['interests'] ?? []),
      hobbies: List<String>.from(json['hobbies'] ?? []),
      minAge: json['minAge'] ?? 18,
      maxAge: json['maxAge'] ?? 99,
      maxDistance: json['maxDistance']?.toDouble() ?? 50.0,
      isOnline: json['isOnline'] ?? false,
      lastSeen: DateTime.fromMillisecondsSinceEpoch(
        json['lastSeen'] ?? DateTime.now().millisecondsSinceEpoch,
      ),
      showOnlineStatus: json['showOnlineStatus'] ?? true,
      allowLocationSharing: json['allowLocationSharing'] ?? true,
      isInRelationship: json['isInRelationship'] ?? false,
      currentPartnerId: json['currentPartnerId'],
      relationshipStartDate: json['relationshipStartDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['relationshipStartDate'])
          : null,
      currentRelationshipType: json['currentRelationshipType'] != null
          ? RelationshipType.values.firstWhere(
              (e) => e.name == json['currentRelationshipType'],
              orElse: () => RelationshipType.casual,
            )
          : null,
      aiPreferences: Map<String, dynamic>.from(json['aiPreferences'] ?? {}),
      conversationHistory: List<String>.from(json['conversationHistory'] ?? []),
      createdAt: DateTime.fromMillisecondsSinceEpoch(
        json['createdAt'] ?? DateTime.now().millisecondsSinceEpoch,
      ),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(
        json['updatedAt'] ?? DateTime.now().millisecondsSinceEpoch,
      ),
    );
  }

  // Create a copy with updated fields
  UserModel copyWith({
    String? id,
    String? email,
    String? username,
    String? displayName,
    String? bio,
    List<String>? photos,
    int? age,
    Gender? gender,
    Gender? interestedIn,
    double? latitude,
    double? longitude,
    String? city,
    String? country,
    RelationshipType? relationshipType,
    String? relationshipDescription,
    List<String>? interests,
    List<String>? hobbies,
    int? minAge,
    int? maxAge,
    double? maxDistance,
    bool? isOnline,
    DateTime? lastSeen,
    bool? showOnlineStatus,
    bool? allowLocationSharing,
    bool? isInRelationship,
    String? currentPartnerId,
    DateTime? relationshipStartDate,
    RelationshipType? currentRelationshipType,
    Map<String, dynamic>? aiPreferences,
    List<String>? conversationHistory,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      username: username ?? this.username,
      displayName: displayName ?? this.displayName,
      bio: bio ?? this.bio,
      photos: photos ?? this.photos,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      interestedIn: interestedIn ?? this.interestedIn,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      city: city ?? this.city,
      country: country ?? this.country,
      relationshipType: relationshipType ?? this.relationshipType,
      relationshipDescription: relationshipDescription ?? this.relationshipDescription,
      interests: interests ?? this.interests,
      hobbies: hobbies ?? this.hobbies,
      minAge: minAge ?? this.minAge,
      maxAge: maxAge ?? this.maxAge,
      maxDistance: maxDistance ?? this.maxDistance,
      isOnline: isOnline ?? this.isOnline,
      lastSeen: lastSeen ?? this.lastSeen,
      showOnlineStatus: showOnlineStatus ?? this.showOnlineStatus,
      allowLocationSharing: allowLocationSharing ?? this.allowLocationSharing,
      isInRelationship: isInRelationship ?? this.isInRelationship,
      currentPartnerId: currentPartnerId ?? this.currentPartnerId,
      relationshipStartDate: relationshipStartDate ?? this.relationshipStartDate,
      currentRelationshipType: currentRelationshipType ?? this.currentRelationshipType,
      aiPreferences: aiPreferences ?? this.aiPreferences,
      conversationHistory: conversationHistory ?? this.conversationHistory,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }

  // Helper methods
  String get relationshipTypeDisplay {
    switch (relationshipType) {
      case RelationshipType.temporary:
        return 'Temporary Companion';
      case RelationshipType.casual:
        return 'Casual Dating';
      case RelationshipType.serious:
        return 'Serious Relationship';
      case RelationshipType.marriage:
        return 'Marriage';
      case RelationshipType.friendship:
        return 'Friendship';
      case RelationshipType.companionship:
        return 'Companionship';
    }
  }

  String get genderDisplay {
    switch (gender) {
      case Gender.male:
        return 'Male';
      case Gender.female:
        return 'Female';
      case Gender.other:
        return 'Other';
      case Gender.preferNotToSay:
        return 'Prefer not to say';
    }
  }

  bool get hasCompleteProfile {
    return displayName != null &&
        bio != null &&
        photos.isNotEmpty &&
        interests.isNotEmpty &&
        city != null;
  }
}
