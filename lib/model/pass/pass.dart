enum PassType { day, monthly, annual }

class Pass {
  final String id;
  final String title;
  final double price;
  final String duration;
  final PassType type;
  final DateTime? expiryDate; // Added for Acceptance Point: "Each pass has an expiration date"

  Pass({
    required this.id,
    required this.title,
    required this.price,
    required this.duration,
    required this.type,
    this.expiryDate,
  });

  // Helper to check if pass is still valid
  bool get isValid => expiryDate == null || expiryDate!.isAfter(DateTime.now());
}