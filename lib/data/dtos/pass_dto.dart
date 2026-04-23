class PassDto {
  final String id;
  final String title;
  final double price;
  final String duration;
  final String type; 

  PassDto({
    required this.id,
    required this.title,
    required this.price,
    required this.duration,
    required this.type,
  });

  factory PassDto.fromJson(String id, Map<String, dynamic> json) {
    return PassDto(
      id: id,
      title: json['title'] ?? '',
      price: (json['price'] as num).toDouble(),
      duration: json['duration'] ?? '',
      type: json['type'] ?? 'day',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'price': price,
      'duration': duration,
      'type': type,
    };
  }
}