// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PetItem _$PetItemFromJson(Map<String, dynamic> json) => PetItem(
      imageLink: json['image_link'] as String,
      goodWithChildren: json['good_with_children'] as int,
      playfulness: json['playfulness'] as int,
      protectiveness: json['protectiveness'] as int,
      barking: json['barking'] as int,
      name: json['name'] as String,
    );

Map<String, dynamic> _$PetItemToJson(PetItem instance) => <String, dynamic>{
      'image_link': instance.imageLink,
      'good_with_children': instance.goodWithChildren,
      'playfulness': instance.playfulness,
      'protectiveness': instance.protectiveness,
      'barking': instance.barking,
      'name': instance.name,
    };
