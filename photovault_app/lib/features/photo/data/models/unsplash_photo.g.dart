// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unsplash_photo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UnsplashSearchResponseImpl _$$UnsplashSearchResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$UnsplashSearchResponseImpl(
      total: (json['total'] as num).toInt(),
      totalPages: (json['total_pages'] as num).toInt(),
      results: (json['results'] as List<dynamic>)
          .map((e) => UnsplashPhoto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$UnsplashSearchResponseImplToJson(
        _$UnsplashSearchResponseImpl instance) =>
    <String, dynamic>{
      'total': instance.total,
      'total_pages': instance.totalPages,
      'results': instance.results,
    };

_$UnsplashPhotoImpl _$$UnsplashPhotoImplFromJson(Map<String, dynamic> json) =>
    _$UnsplashPhotoImpl(
      id: json['id'] as String,
      urls: UnsplashUrls.fromJson(json['urls'] as Map<String, dynamic>),
      user: UnsplashUser.fromJson(json['user'] as Map<String, dynamic>),
      description: json['description'] as String?,
      altDescription: json['alt_description'] as String?,
      likes: (json['likes'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$UnsplashPhotoImplToJson(_$UnsplashPhotoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'urls': instance.urls,
      'user': instance.user,
      'description': instance.description,
      'alt_description': instance.altDescription,
      'likes': instance.likes,
    };

_$UnsplashUrlsImpl _$$UnsplashUrlsImplFromJson(Map<String, dynamic> json) =>
    _$UnsplashUrlsImpl(
      raw: json['raw'] as String,
      full: json['full'] as String,
      regular: json['regular'] as String,
      small: json['small'] as String,
      thumb: json['thumb'] as String,
    );

Map<String, dynamic> _$$UnsplashUrlsImplToJson(_$UnsplashUrlsImpl instance) =>
    <String, dynamic>{
      'raw': instance.raw,
      'full': instance.full,
      'regular': instance.regular,
      'small': instance.small,
      'thumb': instance.thumb,
    };

_$UnsplashUserImpl _$$UnsplashUserImplFromJson(Map<String, dynamic> json) =>
    _$UnsplashUserImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      username: json['username'] as String,
    );

Map<String, dynamic> _$$UnsplashUserImplToJson(_$UnsplashUserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'username': instance.username,
    };
