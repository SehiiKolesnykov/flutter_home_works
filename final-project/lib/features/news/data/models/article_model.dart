import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'article_model.g.dart';

/// Модель статті новин.
/// Використовується для JSON та Hive.
@JsonSerializable()
@HiveType(typeId: 0)
class ArticleModel {
  // Унікальний ID (потрібен для збереження в Hive та порівняння)
  @HiveField(0)
  @JsonKey(defaultValue: '')
  final String id;

  @HiveField(1)
  @JsonKey(defaultValue: '')
  final String title;

  @HiveField(2)
  @JsonKey(defaultValue: '')
  final String description;

  @HiveField(3)
  @JsonKey(defaultValue: '')
  final String url;

  // Назва поля в JSON — 'image', в моделі — urlToImage
  @HiveField(4)
  @JsonKey(defaultValue: '', name: 'image')
  final String urlToImage;

  @HiveField(5)
  @JsonKey(defaultValue: '', name: 'publishedAt')
  final String publishedAt;

  ArticleModel({
    required this.id,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleModelFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleModelToJson(this);

}