class EducationalAdvisor {
  const EducationalAdvisor({required this.id, required this.name, required this.field, required this.isVerified, this.bio = '', this.institution = '', this.rating = 0, this.consultationFee = 0, this.photoUrl});
  final String id;
  final String name;
  final String field;
  final bool isVerified;
  final String bio;
  final String institution;
  final double rating;
  final double consultationFee;
  final String? photoUrl;
  factory EducationalAdvisor.fromMap(String id, Map<String, dynamic> data) => EducationalAdvisor(
    id: id, name: data['fullName']?.toString() ?? data['name']?.toString() ?? '', field: data['field']?.toString() ?? data['specialty']?.toString() ?? '',
    isVerified: data['isVerified'] == true || data['verificationStatus'] == 'approved', bio: data['bio']?.toString() ?? '', institution: data['institution']?.toString() ?? '',
    rating: (data['rating'] as num?)?.toDouble() ?? 0, consultationFee: (data['consultationFee'] as num?)?.toDouble() ?? 0, photoUrl: data['photoURL']?.toString(),
  );
}
