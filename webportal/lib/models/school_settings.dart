class SchoolSettings {
  // Visual Branding
  final String? logoUrl; // Path to uploaded logo
  final String primaryColor; // Hex color code
  final String schoolName;
  final String tagline;

  // School Information
  final String schoolAddress;
  final String phoneNumber;
  final String email;
  final String website;
  final String principalName;
  final String establishedYear;
  final String schoolTiming;
  final String aboutUs;

  // App Customization
  final String appDisplayName;
  final String welcomeMessage;
  final String emergencyContact;
  
  // Social Media Links
  final String? facebookUrl;
  final String? instagramUrl;
  final String? twitterUrl;
  final String? youtubeUrl;

  final DateTime lastUpdated;
  final String updatedBy;

  SchoolSettings({
    this.logoUrl,
    required this.primaryColor,
    required this.schoolName,
    required this.tagline,
    required this.schoolAddress,
    required this.phoneNumber,
    required this.email,
    required this.website,
    required this.principalName,
    required this.establishedYear,
    required this.schoolTiming,
    required this.aboutUs,
    required this.appDisplayName,
    required this.welcomeMessage,
    required this.emergencyContact,
    this.facebookUrl,
    this.instagramUrl,
    this.twitterUrl,
    this.youtubeUrl,
    required this.lastUpdated,
    required this.updatedBy,
  });

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'logoUrl': logoUrl,
      'primaryColor': primaryColor,
      'schoolName': schoolName,
      'tagline': tagline,
      'schoolAddress': schoolAddress,
      'phoneNumber': phoneNumber,
      'email': email,
      'website': website,
      'principalName': principalName,
      'establishedYear': establishedYear,
      'schoolTiming': schoolTiming,
      'aboutUs': aboutUs,
      'appDisplayName': appDisplayName,
      'welcomeMessage': welcomeMessage,
      'emergencyContact': emergencyContact,
      'facebookUrl': facebookUrl,
      'instagramUrl': instagramUrl,
      'twitterUrl': twitterUrl,
      'youtubeUrl': youtubeUrl,
      'lastUpdated': lastUpdated.toIso8601String(),
      'updatedBy': updatedBy,
    };
  }

  // Create from JSON
  factory SchoolSettings.fromJson(Map<String, dynamic> json) {
    return SchoolSettings(
      logoUrl: json['logoUrl'],
      primaryColor: json['primaryColor'],
      schoolName: json['schoolName'],
      tagline: json['tagline'],
      schoolAddress: json['schoolAddress'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      website: json['website'],
      principalName: json['principalName'],
      establishedYear: json['establishedYear'],
      schoolTiming: json['schoolTiming'],
      aboutUs: json['aboutUs'],
      appDisplayName: json['appDisplayName'],
      welcomeMessage: json['welcomeMessage'],
      emergencyContact: json['emergencyContact'],
      facebookUrl: json['facebookUrl'],
      instagramUrl: json['instagramUrl'],
      twitterUrl: json['twitterUrl'],
      youtubeUrl: json['youtubeUrl'],
      lastUpdated: DateTime.parse(json['lastUpdated']),
      updatedBy: json['updatedBy'],
    );
  }

  // Default settings
  factory SchoolSettings.defaults() {
    return SchoolSettings(
      logoUrl: null,
      primaryColor: '#3b82f6',
      schoolName: 'My School',
      tagline: 'Building Tomorrow\'s Leaders',
      schoolAddress: '123 Main Street, City, State 12345',
      phoneNumber: '+1 (555) 123-4567',
      email: 'info@myschool.com',
      website: 'https://myschool.com',
      principalName: 'Dr. Jane Smith',
      establishedYear: '2020',
      schoolTiming: '8:00 AM - 1:00 PM',
      aboutUs: 'We are committed to providing quality education and care for young children.',
      appDisplayName: 'KidzView',
      welcomeMessage: 'Welcome to our school community!',
      emergencyContact: '+1 (555) 999-0000',
      facebookUrl: null,
      instagramUrl: null,
      twitterUrl: null,
      youtubeUrl: null,
      lastUpdated: DateTime.now(),
      updatedBy: 'System',
    );
  }

  // Create copy with updated fields
  SchoolSettings copyWith({
    String? logoUrl,
    String? primaryColor,
    String? schoolName,
    String? tagline,
    String? schoolAddress,
    String? phoneNumber,
    String? email,
    String? website,
    String? principalName,
    String? establishedYear,
    String? schoolTiming,
    String? aboutUs,
    String? appDisplayName,
    String? welcomeMessage,
    String? emergencyContact,
    String? facebookUrl,
    String? instagramUrl,
    String? twitterUrl,
    String? youtubeUrl,
    DateTime? lastUpdated,
    String? updatedBy,
  }) {
    return SchoolSettings(
      logoUrl: logoUrl ?? this.logoUrl,
      primaryColor: primaryColor ?? this.primaryColor,
      schoolName: schoolName ?? this.schoolName,
      tagline: tagline ?? this.tagline,
      schoolAddress: schoolAddress ?? this.schoolAddress,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      website: website ?? this.website,
      principalName: principalName ?? this.principalName,
      establishedYear: establishedYear ?? this.establishedYear,
      schoolTiming: schoolTiming ?? this.schoolTiming,
      aboutUs: aboutUs ?? this.aboutUs,
      appDisplayName: appDisplayName ?? this.appDisplayName,
      welcomeMessage: welcomeMessage ?? this.welcomeMessage,
      emergencyContact: emergencyContact ?? this.emergencyContact,
      facebookUrl: facebookUrl ?? this.facebookUrl,
      instagramUrl: instagramUrl ?? this.instagramUrl,
      twitterUrl: twitterUrl ?? this.twitterUrl,
      youtubeUrl: youtubeUrl ?? this.youtubeUrl,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      updatedBy: updatedBy ?? this.updatedBy,
    );
  }
}

