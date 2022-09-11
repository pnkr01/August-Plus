class User {
  final String name;
  final String email;
  final String phone;
  final String signedInAs;
  final String createdAt;
  final int bookedAmbulanceSoFar;
  final int bookedDoctorsSoFar;
  User({
    required this.name,
    required this.email,
    required this.phone,
    required this.signedInAs,
    required this.createdAt,
    required this.bookedAmbulanceSoFar,
    required this.bookedDoctorsSoFar,
  });
}
