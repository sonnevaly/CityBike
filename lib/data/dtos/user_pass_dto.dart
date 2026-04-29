import '../../model/pass/pass.dart';
import '../../model/user_pass/user_pass.dart';

class UserPassDto {
  final String id;
  final String passId;
  final String activatedAt;
  final String expiresAt;

  const UserPassDto({
    required this.id,
    required this.passId,
    required this.activatedAt,
    required this.expiresAt,
  });

  factory UserPassDto.fromJson(String id, Map<String, dynamic> json) {
    return UserPassDto(
      id: id,
      passId: json['passId'] ?? '',
      activatedAt: json['activatedAt'] ?? '',
      expiresAt: json['expiresAt'] ?? '',
    );
  }

  factory UserPassDto.fromDomain(UserPass userPass) {
    return UserPassDto(
      id: userPass.id,
      passId: userPass.pass.id,
      activatedAt: userPass.activatedAt.toIso8601String(),
      expiresAt: userPass.expiresAt.toIso8601String(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'passId': passId,
      'activatedAt': activatedAt,
      'expiresAt': expiresAt,
    };
  }

  UserPass toDomain(Pass pass) {
    return UserPass(
      id: id,
      pass: pass,
      activatedAt: DateTime.tryParse(activatedAt) ?? DateTime.now(),
      expiresAt: DateTime.tryParse(expiresAt) ?? DateTime.now(),
    );
  }
}
