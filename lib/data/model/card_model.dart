import 'dart:convert';

class CardModel {
  final String id;
  final String number;
  final String expiryDate;
  final String holder;
  final String cvv;

  CardModel({
    required this.id,
    required this.number,
    required this.expiryDate,
    required this.holder,
    required this.cvv,
  });

  CardModel copyWith({
    String? id,
    String? number,
    String? expiryDate,
    String? holder,
    String? cvv,
  }) {
    return CardModel(
      id: id ?? this.id,
      number: number ?? this.number,
      expiryDate: expiryDate ?? this.expiryDate,
      holder: holder ?? this.holder,
      cvv: cvv ?? this.cvv,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'number': number,
      'expiryDate': expiryDate,
      'holder': holder,
      'cvv': cvv,
    };
  }

  factory CardModel.fromMap(Map<String, dynamic> map) {
    return CardModel(
      id: map['id'] ?? '',
      number: map['number'] ?? '',
      expiryDate: map['expiryDate'] ?? '',
      holder: map['holder'] ?? '',
      cvv: map['cvv'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CardModel.fromJson(String source) =>
      CardModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CardModel(id: $id, number: $number, expiryDate: $expiryDate, holder: $holder, cvv: $cvv)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CardModel &&
        other.id == id &&
        other.number == number &&
        other.expiryDate == expiryDate &&
        other.holder == holder &&
        other.cvv == cvv;
  }

  @override
  int get hashCode {
    return number.hashCode ^
        id.hashCode ^
        expiryDate.hashCode ^
        holder.hashCode ^
        cvv.hashCode;
  }
}
