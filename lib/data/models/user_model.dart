// USER MODEL
// This is a blueprint/template for storing user information
// Think of it like a form with all the fields a user has
class UserModel {
  final int? id;           // local SQLite row id
  final String uid;        // Firebase unique user id
  final String fullName;   // user's real name
  final String email;
  final String phone;
  final String role;       // "worker", "customer", or "admin"
  final String? profileImage;
  final bool isVerified;   // CNIC verified or not
  final String? cnicNumber;
  final String? location;
  final double rating;
  final int jobsDone;
  final double walletBalance;
  final String createdAt;

  UserModel({
    this.id,
    required this.uid,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.role,
    this.profileImage,
    this.isVerified = false,
    this.cnicNumber,
    this.location,
    this.rating = 0.0,
    this.jobsDone = 0,
    this.walletBalance = 0.0,
    required this.createdAt,
  });

  // Convert to Map so we can save to SQLite and Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uid': uid,
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'role': role,
      'profileImage': profileImage,
      'isVerified': isVerified ? 1 : 0,
      'cnicNumber': cnicNumber,
      'location': location,
      'rating': rating,
      'jobsDone': jobsDone,
      'walletBalance': walletBalance,
      'createdAt': createdAt,
    };
  }

  // Create UserModel from a Map (reading from SQLite or Firestore)
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      // Use ?? '' to avoid null crashes - give empty string as default
      uid: map['uid'] ?? '',
      fullName: map['fullName'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      role: map['role'] ?? 'customer',
      profileImage: map['profileImage'],
      // SQLite stores bool as 0/1 integer
      isVerified: (map['isVerified'] == 1 || map['isVerified'] == true),
      cnicNumber: map['cnicNumber'],
      location: map['location'],
      rating: (map['rating'] ?? 0.0).toDouble(),
      jobsDone: map['jobsDone'] ?? 0,
      walletBalance: (map['walletBalance'] ?? 0.0).toDouble(),
      createdAt: map['createdAt'] ?? '',
    );
  }

  // CopyWith - creates a new UserModel with some fields changed
  // Used when we update just one field like name or balance
  UserModel copyWith({
    String? fullName,
    String? email,
    String? phone,
    String? role,
    String? profileImage,
    bool? isVerified,
    String? location,
    double? rating,
    int? jobsDone,
    double? walletBalance,
    String? cnicNumber,
  }) {
    return UserModel(
      id: id,
      uid: uid,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      profileImage: profileImage ?? this.profileImage,
      isVerified: isVerified ?? this.isVerified,
      cnicNumber: cnicNumber ?? this.cnicNumber,
      location: location ?? this.location,
      rating: rating ?? this.rating,
      jobsDone: jobsDone ?? this.jobsDone,
      walletBalance: walletBalance ?? this.walletBalance,
      createdAt: createdAt,
    );
  }
}