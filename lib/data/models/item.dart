import 'package:equatable/equatable.dart';

class Item extends Equatable {
  final dynamic id;
  final String? name;
  final DateTime? createdAt;

  const Item({this.id, this.name, this.createdAt});

  Item copyWith({
    int? id,
    String? name,
    DateTime? createdAt,
  }) {
    return Item(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'createdAt': createdAt!.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [id, name, createdAt];
}
