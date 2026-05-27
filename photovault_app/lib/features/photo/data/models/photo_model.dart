import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
part 'photo_model.freezed.dart';
part 'photo_model.g.dart';

// DTO local — espelha a tabela do banco + serialização JSON
// Diferente da Entity (Domain), pode mudar quando o banco muda
@freezed
class PhotoModel with _$PhotoModel {
  const factory PhotoModel({
    required String   id,
    required String   localPath,
    required DateTime createdAt,
             String?  caption,
             String?  audioDesc,
             String?  remoteUrl,
             String?  photographerName,
    @Default(false) bool isFavorite,
  }) = _PhotoModel;

  factory PhotoModel.fromJson(Map<String, dynamic> j) =>
      _$PhotoModelFromJson(j);
}