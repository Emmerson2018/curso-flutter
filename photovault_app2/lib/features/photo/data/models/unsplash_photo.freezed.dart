// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'unsplash_photo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UnsplashSearchResponse {

 int get total;@JsonKey(name: 'total_pages') int get totalPages; List<UnsplashPhoto> get results;
/// Create a copy of UnsplashSearchResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UnsplashSearchResponseCopyWith<UnsplashSearchResponse> get copyWith => _$UnsplashSearchResponseCopyWithImpl<UnsplashSearchResponse>(this as UnsplashSearchResponse, _$identity);

  /// Serializes this UnsplashSearchResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnsplashSearchResponse&&(identical(other.total, total) || other.total == total)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&const DeepCollectionEquality().equals(other.results, results));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,total,totalPages,const DeepCollectionEquality().hash(results));

@override
String toString() {
  return 'UnsplashSearchResponse(total: $total, totalPages: $totalPages, results: $results)';
}


}

/// @nodoc
abstract mixin class $UnsplashSearchResponseCopyWith<$Res>  {
  factory $UnsplashSearchResponseCopyWith(UnsplashSearchResponse value, $Res Function(UnsplashSearchResponse) _then) = _$UnsplashSearchResponseCopyWithImpl;
@useResult
$Res call({
 int total,@JsonKey(name: 'total_pages') int totalPages, List<UnsplashPhoto> results
});




}
/// @nodoc
class _$UnsplashSearchResponseCopyWithImpl<$Res>
    implements $UnsplashSearchResponseCopyWith<$Res> {
  _$UnsplashSearchResponseCopyWithImpl(this._self, this._then);

  final UnsplashSearchResponse _self;
  final $Res Function(UnsplashSearchResponse) _then;

/// Create a copy of UnsplashSearchResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? total = null,Object? totalPages = null,Object? results = null,}) {
  return _then(_self.copyWith(
total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,results: null == results ? _self.results : results // ignore: cast_nullable_to_non_nullable
as List<UnsplashPhoto>,
  ));
}

}


/// Adds pattern-matching-related methods to [UnsplashSearchResponse].
extension UnsplashSearchResponsePatterns on UnsplashSearchResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UnsplashSearchResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UnsplashSearchResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UnsplashSearchResponse value)  $default,){
final _that = this;
switch (_that) {
case _UnsplashSearchResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UnsplashSearchResponse value)?  $default,){
final _that = this;
switch (_that) {
case _UnsplashSearchResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int total, @JsonKey(name: 'total_pages')  int totalPages,  List<UnsplashPhoto> results)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UnsplashSearchResponse() when $default != null:
return $default(_that.total,_that.totalPages,_that.results);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int total, @JsonKey(name: 'total_pages')  int totalPages,  List<UnsplashPhoto> results)  $default,) {final _that = this;
switch (_that) {
case _UnsplashSearchResponse():
return $default(_that.total,_that.totalPages,_that.results);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int total, @JsonKey(name: 'total_pages')  int totalPages,  List<UnsplashPhoto> results)?  $default,) {final _that = this;
switch (_that) {
case _UnsplashSearchResponse() when $default != null:
return $default(_that.total,_that.totalPages,_that.results);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UnsplashSearchResponse implements UnsplashSearchResponse {
  const _UnsplashSearchResponse({required this.total, @JsonKey(name: 'total_pages') required this.totalPages, required final  List<UnsplashPhoto> results}): _results = results;
  factory _UnsplashSearchResponse.fromJson(Map<String, dynamic> json) => _$UnsplashSearchResponseFromJson(json);

@override final  int total;
@override@JsonKey(name: 'total_pages') final  int totalPages;
 final  List<UnsplashPhoto> _results;
@override List<UnsplashPhoto> get results {
  if (_results is EqualUnmodifiableListView) return _results;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_results);
}


/// Create a copy of UnsplashSearchResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UnsplashSearchResponseCopyWith<_UnsplashSearchResponse> get copyWith => __$UnsplashSearchResponseCopyWithImpl<_UnsplashSearchResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UnsplashSearchResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UnsplashSearchResponse&&(identical(other.total, total) || other.total == total)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&const DeepCollectionEquality().equals(other._results, _results));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,total,totalPages,const DeepCollectionEquality().hash(_results));

@override
String toString() {
  return 'UnsplashSearchResponse(total: $total, totalPages: $totalPages, results: $results)';
}


}

/// @nodoc
abstract mixin class _$UnsplashSearchResponseCopyWith<$Res> implements $UnsplashSearchResponseCopyWith<$Res> {
  factory _$UnsplashSearchResponseCopyWith(_UnsplashSearchResponse value, $Res Function(_UnsplashSearchResponse) _then) = __$UnsplashSearchResponseCopyWithImpl;
@override @useResult
$Res call({
 int total,@JsonKey(name: 'total_pages') int totalPages, List<UnsplashPhoto> results
});




}
/// @nodoc
class __$UnsplashSearchResponseCopyWithImpl<$Res>
    implements _$UnsplashSearchResponseCopyWith<$Res> {
  __$UnsplashSearchResponseCopyWithImpl(this._self, this._then);

  final _UnsplashSearchResponse _self;
  final $Res Function(_UnsplashSearchResponse) _then;

/// Create a copy of UnsplashSearchResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? total = null,Object? totalPages = null,Object? results = null,}) {
  return _then(_UnsplashSearchResponse(
total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,results: null == results ? _self._results : results // ignore: cast_nullable_to_non_nullable
as List<UnsplashPhoto>,
  ));
}


}


/// @nodoc
mixin _$UnsplashPhoto {

 String get id; UnsplashUrls get urls; UnsplashUser get user; String? get description;@JsonKey(name: 'alt_description') String? get altDescription; int get likes;
/// Create a copy of UnsplashPhoto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UnsplashPhotoCopyWith<UnsplashPhoto> get copyWith => _$UnsplashPhotoCopyWithImpl<UnsplashPhoto>(this as UnsplashPhoto, _$identity);

  /// Serializes this UnsplashPhoto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnsplashPhoto&&(identical(other.id, id) || other.id == id)&&(identical(other.urls, urls) || other.urls == urls)&&(identical(other.user, user) || other.user == user)&&(identical(other.description, description) || other.description == description)&&(identical(other.altDescription, altDescription) || other.altDescription == altDescription)&&(identical(other.likes, likes) || other.likes == likes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,urls,user,description,altDescription,likes);

@override
String toString() {
  return 'UnsplashPhoto(id: $id, urls: $urls, user: $user, description: $description, altDescription: $altDescription, likes: $likes)';
}


}

/// @nodoc
abstract mixin class $UnsplashPhotoCopyWith<$Res>  {
  factory $UnsplashPhotoCopyWith(UnsplashPhoto value, $Res Function(UnsplashPhoto) _then) = _$UnsplashPhotoCopyWithImpl;
@useResult
$Res call({
 String id, UnsplashUrls urls, UnsplashUser user, String? description,@JsonKey(name: 'alt_description') String? altDescription, int likes
});


$UnsplashUrlsCopyWith<$Res> get urls;$UnsplashUserCopyWith<$Res> get user;

}
/// @nodoc
class _$UnsplashPhotoCopyWithImpl<$Res>
    implements $UnsplashPhotoCopyWith<$Res> {
  _$UnsplashPhotoCopyWithImpl(this._self, this._then);

  final UnsplashPhoto _self;
  final $Res Function(UnsplashPhoto) _then;

/// Create a copy of UnsplashPhoto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? urls = null,Object? user = null,Object? description = freezed,Object? altDescription = freezed,Object? likes = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,urls: null == urls ? _self.urls : urls // ignore: cast_nullable_to_non_nullable
as UnsplashUrls,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UnsplashUser,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,altDescription: freezed == altDescription ? _self.altDescription : altDescription // ignore: cast_nullable_to_non_nullable
as String?,likes: null == likes ? _self.likes : likes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of UnsplashPhoto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UnsplashUrlsCopyWith<$Res> get urls {
  
  return $UnsplashUrlsCopyWith<$Res>(_self.urls, (value) {
    return _then(_self.copyWith(urls: value));
  });
}/// Create a copy of UnsplashPhoto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UnsplashUserCopyWith<$Res> get user {
  
  return $UnsplashUserCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// Adds pattern-matching-related methods to [UnsplashPhoto].
extension UnsplashPhotoPatterns on UnsplashPhoto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UnsplashPhoto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UnsplashPhoto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UnsplashPhoto value)  $default,){
final _that = this;
switch (_that) {
case _UnsplashPhoto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UnsplashPhoto value)?  $default,){
final _that = this;
switch (_that) {
case _UnsplashPhoto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  UnsplashUrls urls,  UnsplashUser user,  String? description, @JsonKey(name: 'alt_description')  String? altDescription,  int likes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UnsplashPhoto() when $default != null:
return $default(_that.id,_that.urls,_that.user,_that.description,_that.altDescription,_that.likes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  UnsplashUrls urls,  UnsplashUser user,  String? description, @JsonKey(name: 'alt_description')  String? altDescription,  int likes)  $default,) {final _that = this;
switch (_that) {
case _UnsplashPhoto():
return $default(_that.id,_that.urls,_that.user,_that.description,_that.altDescription,_that.likes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  UnsplashUrls urls,  UnsplashUser user,  String? description, @JsonKey(name: 'alt_description')  String? altDescription,  int likes)?  $default,) {final _that = this;
switch (_that) {
case _UnsplashPhoto() when $default != null:
return $default(_that.id,_that.urls,_that.user,_that.description,_that.altDescription,_that.likes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UnsplashPhoto implements UnsplashPhoto {
  const _UnsplashPhoto({required this.id, required this.urls, required this.user, this.description, @JsonKey(name: 'alt_description') this.altDescription, this.likes = 0});
  factory _UnsplashPhoto.fromJson(Map<String, dynamic> json) => _$UnsplashPhotoFromJson(json);

@override final  String id;
@override final  UnsplashUrls urls;
@override final  UnsplashUser user;
@override final  String? description;
@override@JsonKey(name: 'alt_description') final  String? altDescription;
@override@JsonKey() final  int likes;

/// Create a copy of UnsplashPhoto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UnsplashPhotoCopyWith<_UnsplashPhoto> get copyWith => __$UnsplashPhotoCopyWithImpl<_UnsplashPhoto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UnsplashPhotoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UnsplashPhoto&&(identical(other.id, id) || other.id == id)&&(identical(other.urls, urls) || other.urls == urls)&&(identical(other.user, user) || other.user == user)&&(identical(other.description, description) || other.description == description)&&(identical(other.altDescription, altDescription) || other.altDescription == altDescription)&&(identical(other.likes, likes) || other.likes == likes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,urls,user,description,altDescription,likes);

@override
String toString() {
  return 'UnsplashPhoto(id: $id, urls: $urls, user: $user, description: $description, altDescription: $altDescription, likes: $likes)';
}


}

/// @nodoc
abstract mixin class _$UnsplashPhotoCopyWith<$Res> implements $UnsplashPhotoCopyWith<$Res> {
  factory _$UnsplashPhotoCopyWith(_UnsplashPhoto value, $Res Function(_UnsplashPhoto) _then) = __$UnsplashPhotoCopyWithImpl;
@override @useResult
$Res call({
 String id, UnsplashUrls urls, UnsplashUser user, String? description,@JsonKey(name: 'alt_description') String? altDescription, int likes
});


@override $UnsplashUrlsCopyWith<$Res> get urls;@override $UnsplashUserCopyWith<$Res> get user;

}
/// @nodoc
class __$UnsplashPhotoCopyWithImpl<$Res>
    implements _$UnsplashPhotoCopyWith<$Res> {
  __$UnsplashPhotoCopyWithImpl(this._self, this._then);

  final _UnsplashPhoto _self;
  final $Res Function(_UnsplashPhoto) _then;

/// Create a copy of UnsplashPhoto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? urls = null,Object? user = null,Object? description = freezed,Object? altDescription = freezed,Object? likes = null,}) {
  return _then(_UnsplashPhoto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,urls: null == urls ? _self.urls : urls // ignore: cast_nullable_to_non_nullable
as UnsplashUrls,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UnsplashUser,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,altDescription: freezed == altDescription ? _self.altDescription : altDescription // ignore: cast_nullable_to_non_nullable
as String?,likes: null == likes ? _self.likes : likes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of UnsplashPhoto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UnsplashUrlsCopyWith<$Res> get urls {
  
  return $UnsplashUrlsCopyWith<$Res>(_self.urls, (value) {
    return _then(_self.copyWith(urls: value));
  });
}/// Create a copy of UnsplashPhoto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UnsplashUserCopyWith<$Res> get user {
  
  return $UnsplashUserCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// @nodoc
mixin _$UnsplashUrls {

 String get raw; String get full; String get regular; String get small; String get thumb;
/// Create a copy of UnsplashUrls
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UnsplashUrlsCopyWith<UnsplashUrls> get copyWith => _$UnsplashUrlsCopyWithImpl<UnsplashUrls>(this as UnsplashUrls, _$identity);

  /// Serializes this UnsplashUrls to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnsplashUrls&&(identical(other.raw, raw) || other.raw == raw)&&(identical(other.full, full) || other.full == full)&&(identical(other.regular, regular) || other.regular == regular)&&(identical(other.small, small) || other.small == small)&&(identical(other.thumb, thumb) || other.thumb == thumb));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,raw,full,regular,small,thumb);

@override
String toString() {
  return 'UnsplashUrls(raw: $raw, full: $full, regular: $regular, small: $small, thumb: $thumb)';
}


}

/// @nodoc
abstract mixin class $UnsplashUrlsCopyWith<$Res>  {
  factory $UnsplashUrlsCopyWith(UnsplashUrls value, $Res Function(UnsplashUrls) _then) = _$UnsplashUrlsCopyWithImpl;
@useResult
$Res call({
 String raw, String full, String regular, String small, String thumb
});




}
/// @nodoc
class _$UnsplashUrlsCopyWithImpl<$Res>
    implements $UnsplashUrlsCopyWith<$Res> {
  _$UnsplashUrlsCopyWithImpl(this._self, this._then);

  final UnsplashUrls _self;
  final $Res Function(UnsplashUrls) _then;

/// Create a copy of UnsplashUrls
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? raw = null,Object? full = null,Object? regular = null,Object? small = null,Object? thumb = null,}) {
  return _then(_self.copyWith(
raw: null == raw ? _self.raw : raw // ignore: cast_nullable_to_non_nullable
as String,full: null == full ? _self.full : full // ignore: cast_nullable_to_non_nullable
as String,regular: null == regular ? _self.regular : regular // ignore: cast_nullable_to_non_nullable
as String,small: null == small ? _self.small : small // ignore: cast_nullable_to_non_nullable
as String,thumb: null == thumb ? _self.thumb : thumb // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [UnsplashUrls].
extension UnsplashUrlsPatterns on UnsplashUrls {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UnsplashUrls value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UnsplashUrls() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UnsplashUrls value)  $default,){
final _that = this;
switch (_that) {
case _UnsplashUrls():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UnsplashUrls value)?  $default,){
final _that = this;
switch (_that) {
case _UnsplashUrls() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String raw,  String full,  String regular,  String small,  String thumb)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UnsplashUrls() when $default != null:
return $default(_that.raw,_that.full,_that.regular,_that.small,_that.thumb);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String raw,  String full,  String regular,  String small,  String thumb)  $default,) {final _that = this;
switch (_that) {
case _UnsplashUrls():
return $default(_that.raw,_that.full,_that.regular,_that.small,_that.thumb);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String raw,  String full,  String regular,  String small,  String thumb)?  $default,) {final _that = this;
switch (_that) {
case _UnsplashUrls() when $default != null:
return $default(_that.raw,_that.full,_that.regular,_that.small,_that.thumb);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UnsplashUrls implements UnsplashUrls {
  const _UnsplashUrls({required this.raw, required this.full, required this.regular, required this.small, required this.thumb});
  factory _UnsplashUrls.fromJson(Map<String, dynamic> json) => _$UnsplashUrlsFromJson(json);

@override final  String raw;
@override final  String full;
@override final  String regular;
@override final  String small;
@override final  String thumb;

/// Create a copy of UnsplashUrls
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UnsplashUrlsCopyWith<_UnsplashUrls> get copyWith => __$UnsplashUrlsCopyWithImpl<_UnsplashUrls>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UnsplashUrlsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UnsplashUrls&&(identical(other.raw, raw) || other.raw == raw)&&(identical(other.full, full) || other.full == full)&&(identical(other.regular, regular) || other.regular == regular)&&(identical(other.small, small) || other.small == small)&&(identical(other.thumb, thumb) || other.thumb == thumb));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,raw,full,regular,small,thumb);

@override
String toString() {
  return 'UnsplashUrls(raw: $raw, full: $full, regular: $regular, small: $small, thumb: $thumb)';
}


}

/// @nodoc
abstract mixin class _$UnsplashUrlsCopyWith<$Res> implements $UnsplashUrlsCopyWith<$Res> {
  factory _$UnsplashUrlsCopyWith(_UnsplashUrls value, $Res Function(_UnsplashUrls) _then) = __$UnsplashUrlsCopyWithImpl;
@override @useResult
$Res call({
 String raw, String full, String regular, String small, String thumb
});




}
/// @nodoc
class __$UnsplashUrlsCopyWithImpl<$Res>
    implements _$UnsplashUrlsCopyWith<$Res> {
  __$UnsplashUrlsCopyWithImpl(this._self, this._then);

  final _UnsplashUrls _self;
  final $Res Function(_UnsplashUrls) _then;

/// Create a copy of UnsplashUrls
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? raw = null,Object? full = null,Object? regular = null,Object? small = null,Object? thumb = null,}) {
  return _then(_UnsplashUrls(
raw: null == raw ? _self.raw : raw // ignore: cast_nullable_to_non_nullable
as String,full: null == full ? _self.full : full // ignore: cast_nullable_to_non_nullable
as String,regular: null == regular ? _self.regular : regular // ignore: cast_nullable_to_non_nullable
as String,small: null == small ? _self.small : small // ignore: cast_nullable_to_non_nullable
as String,thumb: null == thumb ? _self.thumb : thumb // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$UnsplashUser {

 String get id; String get name; String get username;
/// Create a copy of UnsplashUser
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UnsplashUserCopyWith<UnsplashUser> get copyWith => _$UnsplashUserCopyWithImpl<UnsplashUser>(this as UnsplashUser, _$identity);

  /// Serializes this UnsplashUser to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnsplashUser&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.username, username) || other.username == username));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,username);

@override
String toString() {
  return 'UnsplashUser(id: $id, name: $name, username: $username)';
}


}

/// @nodoc
abstract mixin class $UnsplashUserCopyWith<$Res>  {
  factory $UnsplashUserCopyWith(UnsplashUser value, $Res Function(UnsplashUser) _then) = _$UnsplashUserCopyWithImpl;
@useResult
$Res call({
 String id, String name, String username
});




}
/// @nodoc
class _$UnsplashUserCopyWithImpl<$Res>
    implements $UnsplashUserCopyWith<$Res> {
  _$UnsplashUserCopyWithImpl(this._self, this._then);

  final UnsplashUser _self;
  final $Res Function(UnsplashUser) _then;

/// Create a copy of UnsplashUser
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? username = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [UnsplashUser].
extension UnsplashUserPatterns on UnsplashUser {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UnsplashUser value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UnsplashUser() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UnsplashUser value)  $default,){
final _that = this;
switch (_that) {
case _UnsplashUser():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UnsplashUser value)?  $default,){
final _that = this;
switch (_that) {
case _UnsplashUser() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String username)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UnsplashUser() when $default != null:
return $default(_that.id,_that.name,_that.username);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String username)  $default,) {final _that = this;
switch (_that) {
case _UnsplashUser():
return $default(_that.id,_that.name,_that.username);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String username)?  $default,) {final _that = this;
switch (_that) {
case _UnsplashUser() when $default != null:
return $default(_that.id,_that.name,_that.username);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UnsplashUser implements UnsplashUser {
  const _UnsplashUser({required this.id, required this.name, required this.username});
  factory _UnsplashUser.fromJson(Map<String, dynamic> json) => _$UnsplashUserFromJson(json);

@override final  String id;
@override final  String name;
@override final  String username;

/// Create a copy of UnsplashUser
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UnsplashUserCopyWith<_UnsplashUser> get copyWith => __$UnsplashUserCopyWithImpl<_UnsplashUser>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UnsplashUserToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UnsplashUser&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.username, username) || other.username == username));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,username);

@override
String toString() {
  return 'UnsplashUser(id: $id, name: $name, username: $username)';
}


}

/// @nodoc
abstract mixin class _$UnsplashUserCopyWith<$Res> implements $UnsplashUserCopyWith<$Res> {
  factory _$UnsplashUserCopyWith(_UnsplashUser value, $Res Function(_UnsplashUser) _then) = __$UnsplashUserCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String username
});




}
/// @nodoc
class __$UnsplashUserCopyWithImpl<$Res>
    implements _$UnsplashUserCopyWith<$Res> {
  __$UnsplashUserCopyWithImpl(this._self, this._then);

  final _UnsplashUser _self;
  final $Res Function(_UnsplashUser) _then;

/// Create a copy of UnsplashUser
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? username = null,}) {
  return _then(_UnsplashUser(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
