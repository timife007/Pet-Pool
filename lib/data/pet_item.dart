import 'package:json_annotation/json_annotation.dart';
part 'pet_item.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PetItem {
  String imageLink;
  int goodWithChildren;
  int playfulness;
  int protectiveness;
  int barking;
  String name;

  PetItem(
      {required this.imageLink,
      required this.goodWithChildren,
      required this.playfulness,
      required this.protectiveness,
      required this.barking,
      required this.name});

  factory PetItem.fromJson(Map<String, dynamic> json) =>
      _$PetItemFromJson(json);

  Map<String, dynamic> toJson() => _$PetItemToJson(this);
}
