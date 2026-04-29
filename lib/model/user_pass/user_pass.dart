import '../pass/pass.dart';

class UserPass {
  final String id;
  final Pass pass;
  final DateTime activatedAt;
  final DateTime expiresAt;

  const UserPass({
    required this.id,
    required this.pass,
    required this.activatedAt,
    required this.expiresAt,
  });
}
