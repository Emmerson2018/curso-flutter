// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PhotoModelImpl _$$PhotoModelImplFromJson(Map<String, dynamic> json) =>
    _$PhotoModelImpl(
      id: json['id'] as String,
      localPath: json['localPath'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      caption: json['caption'] as String?,
      audioDesc: json['audioDesc'] as String?,
      remoteUrl: json['remoteUrl'] as String?,
      photographerName: json['photographerName'] as String?,
      isFavorite: json['isFavorite'] as bool? ?? false,
    );

Map<String, dynamic> _$$PhotoModelImplToJson(_$PhotoModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'localPath': instance.localPath,
      'createdAt': instance.createdAt.toIso8601String(),
      'caption': instance.caption,
      'audioDesc': instance.audioDesc,
      'remoteUrl': instance.remoteUrl,
      'photographerName': instance.photographerName,
      'isFavorite': instance.isFavorite,
    };
