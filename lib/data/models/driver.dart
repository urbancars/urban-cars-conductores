class Driver {
  final String id;
  final String name;
  final String documento;

  Driver({
    required this.id,
    required this.name,
    required this.documento,
  });

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      id: json['conductor_id']?.toString() ?? '',   // always String
      name: json['conductor']?.toString() ?? '',
      documento: json['documento']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'conductor_id': id,
      'conductor': name,
      'documento': documento,
    };
  }
}