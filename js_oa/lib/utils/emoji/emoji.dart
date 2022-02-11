/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-10-14 15:53:05
 * @Description: 
 * @FilePath: \js_oa\lib\utils\emoji\emoji.dart
 * @LastEditTime: 2021-10-14 16:02:28
 */
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Emoji extends Object {
  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'unicode')
  int unicode;

  Emoji({required this.name, required this.unicode});

  factory Emoji.fromJson(Map<String, dynamic> srcJson) => Emoji(
      name: srcJson['name'] as String, unicode: srcJson['unicode'] as int);

  Map<String, dynamic> toJson(Emoji instance) =>
      <String, dynamic>{'name': instance.name, 'unicode': instance.unicode};
}
