import "../../model/pass/pass.dart";

class PassDto {
  final String id;
  final String title;
  final double price;
  final int durationDays;

  const PassDto({
    required this.id,
    required this.title,
    required this.price,
    required this.durationDays,
  });

  factory PassDto.fromJson(String id, Map<String, dynamic> json) {
    return PassDto(
      id: id,
      title: json['title'] ?? '',
      price: (json['price'] as num).toDouble(),
      durationDays: (json['durationDays'] as num?)?.toInt() ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'price': price,
      'durationDays': durationDays,
    };
  }

  Pass toDomain() {
    return Pass(
      id: id,
      title: title,
      price: price,
      durationDays: durationDays,
    );
    return {'title': title, 'price': price, 'durationDays': durationDays};
  }

  Pass toDomain() {
    return Pass(id: id, title: title, price: price, durationDays: durationDays);
  }
}
