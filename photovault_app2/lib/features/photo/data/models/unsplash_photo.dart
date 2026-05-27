import 'package:freezed_annotation/freezed_annotation.dart';
// json_annotation NÃO é necessário — freezed_annotation já o reexporta
part 'unsplash_photo.freezed.dart';
part 'unsplash_photo.g.dart';

@freezed
abstract class UnsplashSearchResponse with _$UnsplashSearchResponse {
  const factory UnsplashSearchResponse({
    required int                  total,
    @JsonKey(name: 'total_pages') required int totalPages,
    required List<UnsplashPhoto>  results,
  }) = _UnsplashSearchResponse;
  factory UnsplashSearchResponse.fromJson(Map<String, dynamic> j) =>
      _$UnsplashSearchResponseFromJson(j);
}

@freezed
abstract class UnsplashPhoto with _$UnsplashPhoto {
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
abstract class UnsplashUrls with _$UnsplashUrls {
  const factory UnsplashUrls({
    required String raw,
    required String full,
    required String regular,
    required String small,
    required String thumb,
  }) = _UnsplashUrls;
  factory UnsplashUrls.fromJson(Map<String, dynamic> j) =>
      _$UnsplashUrlsFromJson(j);
}

@freezed
abstract class UnsplashUser with _$UnsplashUser {
  const factory UnsplashUser({
    required String id,
    required String name,
    required String username,
  }) = _UnsplashUser;
  factory UnsplashUser.fromJson(Map<String, dynamic> j) =>
      _$UnsplashUserFromJson(j);
}
