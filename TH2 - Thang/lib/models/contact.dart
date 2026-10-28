class Contact {
  final String id;
  String name;
  String phone;
  String group;
  String gender;
  bool isFavorite;
  String notes;

  Contact({
    required this.id,
    required this.name,
    required this.phone,
    required this.group,
    required this.gender,
    required this.isFavorite,
    required this.notes,
  });

  /// Lấy chữ cái đầu của tên (ưu tiên từ cuối cùng trong họ tên, ví dụ "Nguyễn Văn An" -> "A")
  String get initialLetter {
    if (name.trim().isEmpty) return '?';
    final parts = name.trim().split(RegExp(r'\s+'));
    final lastWord = parts.isNotEmpty ? parts.last : '';
    if (lastWord.isNotEmpty) {
      return lastWord[0].toUpperCase();
    }
    return '?';
  }

  Contact copyWith({
    String? id,
    String? name,
    String? phone,
    String? group,
    String? gender,
    bool? isFavorite,
    String? notes,
  }) {
    return Contact(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      group: group ?? this.group,
      gender: gender ?? this.gender,
      isFavorite: isFavorite ?? this.isFavorite,
      notes: notes ?? this.notes,
    );
  }
}
