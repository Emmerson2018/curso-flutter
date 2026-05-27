import 'package:freezed_annotation/freezed_annotation.dart';
part 'photo_model.freezed.dart';
part 'photo_model.g.dart';

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
