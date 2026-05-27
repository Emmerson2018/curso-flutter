import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
part 'unsplash_photo.freezed.dart';
part 'unsplash_photo.g.dart';

@freezed
class UnsplashSearchResponse with _$UnsplashSearchResponse {
  const factory UnsplashSearchResponse({
    required int                  total,
    @JsonKey(name: 'total_pages') required int totalPages,
    required List<UnsplashPhoto> results,
  }) = _UnsplashSearchResponse;
  factory UnsplashSearchResponse.fromJson(Map<String, dynamic> j) =>
      _$UnsplashSearchResponseFromJson(j);
}

@freezed
class UnsplashPhoto with _$UnsplashPhoto {
  const factory UnsplashPhoto({
    required String       id,
    required UnsplashUrls urls,
    required UnsplashUser user,
             String?      description,
    @JsonKey(name: 'alt_description') String? altDescription,
    @Default(0) int likes,
  }) = _UnsplashPhoto;
  factory UnsplashPhoto.fromJson(Map<String, dynamic> j) =>
      _$UnsplashPhotoFromJson(j);
}

@freezed
class UnsplashUrls with _$UnsplashUrls {
  const factory UnsplashUrls({
    required String raw,
    required String full,
    required String regular,  // 1080px — use para exibir
    required String small,    // 400px — use no detalhe
    required String thumb,    // 200px — use no grid
  }) = _UnsplashUrls;
  factory UnsplashUrls.fromJson(Map<String, dynamic> j) =>
      _$UnsplashUrlsFromJson(j);
}

@freezed
class UnsplashUser with _$UnsplashUser {
  const factory UnsplashUser({
    required String id,
    required String name,
    required String username,
  }) = _UnsplashUser;
  factory UnsplashUser.fromJson(Map<String, dynamic> j) =>
      _$UnsplashUserFromJson(j);
}