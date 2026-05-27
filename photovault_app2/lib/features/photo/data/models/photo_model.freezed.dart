// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'photo_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PhotoModel {

 String get id; String get localPath; DateTime get createdAt; String? get caption; String? get audioDesc; String? get remoteUrl; String? get photographerName; bool get isFavorite;
/// Create a copy of PhotoModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PhotoModelCopyWith<PhotoModel> get copyWith => _$PhotoModelCopyWithImpl<PhotoModel>(this as PhotoModel, _$identity);

  /// Serializes this PhotoModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PhotoModel&&(identical(other.id, id) || other.id == id)&&(identical(other.localPath, localPath) || other.localPath == localPath)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.caption, caption) || other.caption == caption)&&(identical(other.audioDesc, audioDesc) || other.audioDesc == audioDesc)&&(identical(other.remoteUrl, remoteUrl) || other.remoteUrl == remoteUrl)&&(identical(other.photographerName, photographerName) || other.photographerName == photographerName)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,localPath,createdAt,caption,audioDesc,remoteUrl,photographerName,isFavorite);

@override
String toString() {
  return 'PhotoModel(id: $id, localPath: $localPath, createdAt: $createdAt, caption: $caption, audioDesc: $audioDesc, remoteUrl: $remoteUrl, photographerName: $photographerName, isFavorite: $isFavorite)';
}


}

/// @nodoc
abstract mixin class $PhotoModelCopyWith<$Res>  {
  factory $PhotoModelCopyWith(PhotoModel value, $Res Function(PhotoModel) _then) = _$PhotoModelCopyWithImpl;
@useResult
$Res call({
 String id, String localPath, DateTime createdAt, String? caption, String? audioDesc, String? remoteUrl, String? photographerName, bool isFavorite
});




}
/// @nodoc
class _$PhotoModelCopyWithImpl<$Res>
    implements $PhotoModelCopyWith<$Res> {
  _$PhotoModelCopyWithImpl(this._self, this._then);

  final PhotoModel _self;
  final $Res Function(PhotoModel) _then;

/// Create a copy of PhotoModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? localPath = null,Object? createdAt = null,Object? caption = freezed,Object? audioDesc = freezed,Object? remoteUrl = freezed,Object? photographerName = freezed,Object? isFavorite = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,localPath: null == localPath ? _self.localPath : localPath // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,caption: freezed == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String?,audioDesc: freezed == audioDesc ? _self.audioDesc : audioDesc // ignore: cast_nullable_to_non_nullable
as String?,remoteUrl: freezed == remoteUrl ? _self.remoteUrl : remoteUrl // ignore: cast_nullable_to_non_nullable
as String?,photographerName: freezed == photographerName ? _self.photographerName : photographerName // ignore: cast_nullable_to_non_nullable
as String?,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PhotoModel].
extension PhotoModelPatterns on PhotoModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PhotoModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PhotoModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PhotoModel value)  $default,){
final _that = this;
switch (_that) {
case _PhotoModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PhotoModel value)?  $default,){
final _that = this;
switch (_that) {
case _PhotoModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String localPath,  DateTime createdAt,  String? caption,  String? audioDesc,  String? remoteUrl,  String? photographerName,  bool isFavorite)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PhotoModel() when $default != null:
return $default(_that.id,_that.localPath,_that.createdAt,_that.caption,_that.audioDesc,_that.remoteUrl,_that.photographerName,_that.isFavorite);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String localPath,  DateTime createdAt,  String? caption,  String? audioDesc,  String? remoteUrl,  String? photographerName,  bool isFavorite)  $default,) {final _that = this;
switch (_that) {
case _PhotoModel():
return $default(_that.id,_that.localPath,_that.createdAt,_that.caption,_that.audioDesc,_that.remoteUrl,_that.photographerName,_that.isFavorite);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String localPath,  DateTime createdAt,  String? caption,  String? audioDesc,  String? remoteUrl,  String? photographerName,  bool isFavorite)?  $default,) {final _that = this;
switch (_that) {
case _PhotoModel() when $default != null:
return $default(_that.id,_that.localPath,_that.createdAt,_that.caption,_that.audioDesc,_that.remoteUrl,_that.photographerName,_that.isFavorite);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PhotoModel implements PhotoModel {
  const _PhotoModel({required this.id, required this.localPath, required this.createdAt, this.caption, this.audioDesc, this.remoteUrl, this.photographerName, this.isFavorite = false});
  factory _PhotoModel.fromJson(Map<String, dynamic> json) => _$PhotoModelFromJson(json);

@override final  String id;
@override final  String localPath;
@override final  DateTime createdAt;
@override final  String? caption;
@override final  String? audioDesc;
@override final  String? remoteUrl;
@override final  String? photographerName;
@override@JsonKey() final  bool isFavorite;

/// Create a copy of PhotoModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PhotoModelCopyWith<_PhotoModel> get copyWith => __$PhotoModelCopyWithImpl<_PhotoModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PhotoModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PhotoModel&&(identical(other.id, id) || other.id == id)&&(identical(other.localPath, localPath) || other.localPath == localPath)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.caption, caption) || other.caption == caption)&&(identical(other.audioDesc, audioDesc) || other.audioDesc == audioDesc)&&(identical(other.remoteUrl, remoteUrl) || other.remoteUrl == remoteUrl)&&(identical(other.photographerName, photographerName) || other.photographerName == photographerName)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,localPath,createdAt,caption,audioDesc,remoteUrl,photographerName,isFavorite);

@override
String toString() {
  return 'PhotoModel(id: $id, localPath: $localPath, createdAt: $createdAt, caption: $caption, audioDesc: $audioDesc, remoteUrl: $remoteUrl, photographerName: $photographerName, isFavorite: $isFavorite)';
}


}

/// @nodoc
abstract mixin class _$PhotoModelCopyWith<$Res> implements $PhotoModelCopyWith<$Res> {
  factory _$PhotoModelCopyWith(_PhotoModel value, $Res Function(_PhotoModel) _then) = __$PhotoModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String localPath, DateTime createdAt, String? caption, String? audioDesc, String? remoteUrl, String? photographerName, bool isFavorite
});




}
/// @nodoc
class __$PhotoModelCopyWithImpl<$Res>
    implements _$PhotoModelCopyWith<$Res> {
  __$PhotoModelCopyWithImpl(this._self, this._then);

  final _PhotoModel _self;
  final $Res Function(_PhotoModel) _then;

/// Create a copy of PhotoModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? localPath = null,Object? createdAt = null,Object? caption = freezed,Object? audioDesc = freezed,Object? remoteUrl = freezed,Object? photographerName = freezed,Object? isFavorite = null,}) {
  return _then(_PhotoModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,localPath: null == localPath ? _self.localPath : localPath // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,caption: freezed == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String?,audioDesc: freezed == audioDesc ? _self.audioDesc : audioDesc // ignore: cast_nullable_to_non_nullable
as String?,remoteUrl: freezed == remoteUrl ? _self.remoteUrl : remoteUrl // ignore: cast_nullable_to_non_nullable
as String?,photographerName: freezed == photographerName ? _self.photographerName : photographerName // ignore: cast_nullable_to_non_nullable
as String?,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
