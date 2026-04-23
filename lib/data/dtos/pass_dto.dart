import "../../model/pass/pass.dart";

class PassDto {
  final String id, title, duration, type;
  final double price;

  PassDto({required this.id, required this.title, required this.duration, required this.type, required this.price});

  factory PassDto.fromJson(String id, Map<String, dynamic> json) {
    return PassDto(
      id: id,
      title: json['title'] ?? '',
      duration: json['duration'] ?? '',
      type: json['type'] ?? 'day',
      price: (json['price'] as num).toDouble(),
    );
  }

  Pass toDomain() {
    return Pass(
      id: id,
      title: title,
      price: price,
      duration: duration,
      type: type == 'monthly' ? PassType.monthly : (type == 'annual' ? PassType.annual : PassType.day),
    );
  }
}