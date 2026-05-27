// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'photo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Photo {

 String get id; String get localPath; DateTime get createdAt; String? get caption; String? get audioDescription; String? get remoteUrl; String? get photographerName; bool get isFavorite;
/// Create a copy of Photo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PhotoCopyWith<Photo> get copyWith => _$PhotoCopyWithImpl<Photo>(this as Photo, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Photo&&(identical(other.id, id) || other.id == id)&&(identical(other.localPath, localPath) || other.localPath == localPath)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.caption, caption) || other.caption == caption)&&(identical(other.audioDescription, audioDescription) || other.audioDescription == audioDescription)&&(identical(other.remoteUrl, remoteUrl) || other.remoteUrl == remoteUrl)&&(identical(other.photographerName, photographerName) || other.photographerName == photographerName)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite));
}


@override
int get hashCode => Object.hash(runtimeType,id,localPath,createdAt,caption,audioDescription,remoteUrl,photographerName,isFavorite);

@override
String toString() {
  return 'Photo(id: $id, localPath: $localPath, createdAt: $createdAt, caption: $caption, audioDescription: $audioDescription, remoteUrl: $remoteUrl, photographerName: $photographerName, isFavorite: $isFavorite)';
}


}

/// @nodoc
abstract mixin class $PhotoCopyWith<$Res>  {
  factory $PhotoCopyWith(Photo value, $Res Function(Photo) _then) = _$PhotoCopyWithImpl;
@useResult
$Res call({
 String id, String localPath, DateTime createdAt, String? caption, String? audioDescription, String? remoteUrl, String? photographerName, bool isFavorite
});




}
/// @nodoc
class _$PhotoCopyWithImpl<$Res>
    implements $PhotoCopyWith<$Res> {
  _$PhotoCopyWithImpl(this._self, this._then);

  final Photo _self;
  final $Res Function(Photo) _then;

/// Create a copy of Photo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? localPath = null,Object? createdAt = null,Object? caption = freezed,Object? audioDescription = freezed,Object? remoteUrl = freezed,Object? photographerName = freezed,Object? isFavorite = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,localPath: null == localPath ? _self.localPath : localPath // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,caption: freezed == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String?,audioDescription: freezed == audioDescription ? _self.audioDescription : audioDescription // ignore: cast_nullable_to_non_nullable
as String?,remoteUrl: freezed == remoteUrl ? _self.remoteUrl : remoteUrl // ignore: cast_nullable_to_non_nullable
as String?,photographerName: freezed == photographerName ? _self.photographerName : photographerName // ignore: cast_nullable_to_non_nullable
as String?,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Photo].
extension PhotoPatterns on Photo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Photo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Photo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Photo value)  $default,){
final _that = this;
switch (_that) {
case _Photo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Photo value)?  $default,){
final _that = this;
switch (_that) {
case _Photo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String localPath,  DateTime createdAt,  String? caption,  String? audioDescription,  String? remoteUrl,  String? photographerName,  bool isFavorite)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Photo() when $default != null:
return $default(_that.id,_that.localPath,_that.createdAt,_that.caption,_that.audioDescription,_that.remoteUrl,_that.photographerName,_that.isFavorite);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String localPath,  DateTime createdAt,  String? caption,  String? audioDescription,  String? remoteUrl,  String? photographerName,  bool isFavorite)  $default,) {final _that = this;
switch (_that) {
case _Photo():
return $default(_that.id,_that.localPath,_that.createdAt,_that.caption,_that.audioDescription,_that.remoteUrl,_that.photographerName,_that.isFavorite);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String localPath,  DateTime createdAt,  String? caption,  String? audioDescription,  String? remoteUrl,  String? photographerName,  bool isFavorite)?  $default,) {final _that = this;
switch (_that) {
case _Photo() when $default != null:
return $default(_that.id,_that.localPath,_that.createdAt,_that.caption,_that.audioDescription,_that.remoteUrl,_that.photographerName,_that.isFavorite);case _:
  return null;

}
}

}

/// @nodoc


class _Photo implements Photo {
  const _Photo({required this.id, required this.localPath, required this.createdAt, this.caption, this.audioDescription, this.remoteUrl, this.photographerName, this.isFavorite = false});
  

@override final  String id;
@override final  String localPath;
@override final  DateTime createdAt;
@override final  String? caption;
@override final  String? audioDescription;
@override final  String? remoteUrl;
@override final  String? photographerName;
@override@JsonKey() final  bool isFavorite;

/// Create a copy of Photo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PhotoCopyWith<_Photo> get copyWith => __$PhotoCopyWithImpl<_Photo>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Photo&&(identical(other.id, id) || other.id == id)&&(identical(other.localPath, localPath) || other.localPath == localPath)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.caption, caption) || other.caption == caption)&&(identical(other.audioDescription, audioDescription) || other.audioDescription == audioDescription)&&(identical(other.remoteUrl, remoteUrl) || other.remoteUrl == remoteUrl)&&(identical(other.photographerName, photographerName) || other.photographerName == photographerName)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite));
}


@override
int get hashCode => Object.hash(runtimeType,id,localPath,createdAt,caption,audioDescription,remoteUrl,photographerName,isFavorite);

@override
String toString() {
  return 'Photo(id: $id, localPath: $localPath, createdAt: $createdAt, caption: $caption, audioDescription: $audioDescription, remoteUrl: $remoteUrl, photographerName: $photographerName, isFavorite: $isFavorite)';
}


}

/// @nodoc
abstract mixin class _$PhotoCopyWith<$Res> implements $PhotoCopyWith<$Res> {
  factory _$PhotoCopyWith(_Photo value, $Res Function(_Photo) _then) = __$PhotoCopyWithImpl;
@override @useResult
$Res call({
 String id, String localPath, DateTime createdAt, String? caption, String? audioDescription, String? remoteUrl, String? photographerName, bool isFavorite
});




}
/// @nodoc
class __$PhotoCopyWithImpl<$Res>
    implements _$PhotoCopyWith<$Res> {
  __$PhotoCopyWithImpl(this._self, this._then);

  final _Photo _self;
  final $Res Function(_Photo) _then;

/// Create a copy of Photo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? localPath = null,Object? createdAt = null,Object? caption = freezed,Object? audioDescription = freezed,Object? remoteUrl = freezed,Object? photographerName = freezed,Object? isFavorite = null,}) {
  return _then(_Photo(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,localPath: null == localPath ? _self.localPath : localPath // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,caption: freezed == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String?,audioDescription: freezed == audioDescription ? _self.audioDescription : audioDescription // ignore: cast_nullable_to_non_nullable
as String?,remoteUrl: freezed == remoteUrl ? _self.remoteUrl : remoteUrl // ignore: cast_nullable_to_non_nullable
as String?,photographerName: freezed == photographerName ? _self.photographerName : photographerName // ignore: cast_nullable_to_non_nullable
as String?,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$PhotoFilterState {

 String get searchQuery; SortOrder get sortOrder;
/// Create a copy of PhotoFilterState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PhotoFilterStateCopyWith<PhotoFilterState> get copyWith => _$PhotoFilterStateCopyWithImpl<PhotoFilterState>(this as PhotoFilterState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PhotoFilterState&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder));
}


@override
int get hashCode => Object.hash(runtimeType,searchQuery,sortOrder);

@override
String toString() {
  return 'PhotoFilterState(searchQuery: $searchQuery, sortOrder: $sortOrder)';
}


}

/// @nodoc
abstract mixin class $PhotoFilterStateCopyWith<$Res>  {
  factory $PhotoFilterStateCopyWith(PhotoFilterState value, $Res Function(PhotoFilterState) _then) = _$PhotoFilterStateCopyWithImpl;
@useResult
$Res call({
 String searchQuery, SortOrder sortOrder
});




}
/// @nodoc
class _$PhotoFilterStateCopyWithImpl<$Res>
    implements $PhotoFilterStateCopyWith<$Res> {
  _$PhotoFilterStateCopyWithImpl(this._self, this._then);

  final PhotoFilterState _self;
  final $Res Function(PhotoFilterState) _then;

/// Create a copy of PhotoFilterState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? searchQuery = null,Object? sortOrder = null,}) {
  return _then(_self.copyWith(
searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as SortOrder,
  ));
}

}


/// Adds pattern-matching-related methods to [PhotoFilterState].
extension PhotoFilterStatePatterns on PhotoFilterState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PhotoFilterState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PhotoFilterState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PhotoFilterState value)  $default,){
final _that = this;
switch (_that) {
case _PhotoFilterState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PhotoFilterState value)?  $default,){
final _that = this;
switch (_that) {
case _PhotoFilterState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String searchQuery,  SortOrder sortOrder)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PhotoFilterState() when $default != null:
return $default(_that.searchQuery,_that.sortOrder);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String searchQuery,  SortOrder sortOrder)  $default,) {final _that = this;
switch (_that) {
case _PhotoFilterState():
return $default(_that.searchQuery,_that.sortOrder);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String searchQuery,  SortOrder sortOrder)?  $default,) {final _that = this;
switch (_that) {
case _PhotoFilterState() when $default != null:
return $default(_that.searchQuery,_that.sortOrder);case _:
  return null;

}
}

}

/// @nodoc


class _PhotoFilterState implements PhotoFilterState {
  const _PhotoFilterState({this.searchQuery = '', this.sortOrder = SortOrder.newest});
  

@override@JsonKey() final  String searchQuery;
@override@JsonKey() final  SortOrder sortOrder;

/// Create a copy of PhotoFilterState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PhotoFilterStateCopyWith<_PhotoFilterState> get copyWith => __$PhotoFilterStateCopyWithImpl<_PhotoFilterState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PhotoFilterState&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder));
}


@override
int get hashCode => Object.hash(runtimeType,searchQuery,sortOrder);

@override
String toString() {
  return 'PhotoFilterState(searchQuery: $searchQuery, sortOrder: $sortOrder)';
}


}

/// @nodoc
abstract mixin class _$PhotoFilterStateCopyWith<$Res> implements $PhotoFilterStateCopyWith<$Res> {
  factory _$PhotoFilterStateCopyWith(_PhotoFilterState value, $Res Function(_PhotoFilterState) _then) = __$PhotoFilterStateCopyWithImpl;
@override @useResult
$Res call({
 String searchQuery, SortOrder sortOrder
});




}
/// @nodoc
class __$PhotoFilterStateCopyWithImpl<$Res>
    implements _$PhotoFilterStateCopyWith<$Res> {
  __$PhotoFilterStateCopyWithImpl(this._self, this._then);

  final _PhotoFilterState _self;
  final $Res Function(_PhotoFilterState) _then;

/// Create a copy of PhotoFilterState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? searchQuery = null,Object? sortOrder = null,}) {
  return _then(_PhotoFilterState(
searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as SortOrder,
  ));
}


}

// dart format on
