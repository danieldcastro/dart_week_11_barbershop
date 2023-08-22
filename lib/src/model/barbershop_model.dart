class BarbershopModel {
  final int id;
  final String name;
  final String email;
  final List<String> openingDays;
  final List<int> openingHours;

  BarbershopModel({
    required this.id,
    required this.name,
    required this.email,
    required this.openingDays,
    required this.openingHours,
  });

  factory BarbershopModel.fromMap(Map<String, dynamic> json) => switch (json) {
        {
          'id': final int id,
          'name': final String name,
          'email': final String email,
          'opening_days': final List openingDays,
          'opening_hours': final List openingHours,
        } =>
          BarbershopModel(
            id: id,
            email: email,
            name: name,
            openingDays: openingDays.cast<String>(),
            openingHours: openingHours.cast<int>(),
          ),
        _ => throw ArgumentError('Invalid Json'),
      };

  @override
  String toString() {
    return 'BarbershopModel{id=$id, name=$name, email=$email, openingDays=$openingDays, openingHours=$openingHours}';
  }
}
